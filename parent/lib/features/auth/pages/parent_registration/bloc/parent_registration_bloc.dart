import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:device_info_service/device_info_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/core.dart';

part 'parent_registration_event.dart';
part 'parent_registration_state.dart';

/// Identifies why registration failed so the UI can show a localized,
/// contextual message instead of forwarding raw strings.
enum ParentRegistrationFailureKind {
  unknown,
  lookupEmpty,
  studentNotFound,
  findFailed,
  findChildFirst,
  confirmChild,
  firstNameShort,
  lastNameShort,
  invalidPhone,
  invalidEmail,
  relationshipRequired,
  passwordWeak,
  passwordMismatch,
  registrationFailed,
  phoneAlreadyExists,
  network,
  unauthorized,
}

sealed class ParentRegistrationPresentationEvent {
  const ParentRegistrationPresentationEvent();
}

final class ParentRegistrationFailurePresentationEvent
    extends ParentRegistrationPresentationEvent {
  final ParentRegistrationFailureKind kind;
  final String? rawMessage;

  const ParentRegistrationFailurePresentationEvent({
    required this.kind,
    this.rawMessage,
  });
}

final class ParentRegistrationSuccessPresentationEvent
    extends ParentRegistrationPresentationEvent {
  final String phone;

  const ParentRegistrationSuccessPresentationEvent({required this.phone});
}

final class ParentRegistrationBloc
    extends Bloc<ParentRegistrationEvent, ParentRegistrationState>
    with
        BlocPresentationMixin<
          ParentRegistrationState,
          ParentRegistrationPresentationEvent
        > {
  final AuthenticationRepository _authenticationRepository;
  final DeviceInfoService _deviceInfoService;
  final MentorXLogger _logger = MentorXLogger('ParentRegistrationBloc');

  ParentRegistrationBloc({
    required AuthenticationRepository authenticationRepository,
    required DeviceInfoService deviceInfoService,
  }) : _authenticationRepository = authenticationRepository,
       _deviceInfoService = deviceInfoService,
       super(const ParentRegistrationState()) {
    on<ParentRegistrationStepChanged>(_onStepChanged);
    on<ParentRegistrationLookupTypeChanged>(_onLookupTypeChanged);
    on<ParentRegistrationLookupValueChanged>(_onLookupValueChanged);
    // Restartable: latest find-student request wins; older ones get dropped.
    on<ParentRegistrationFindStudentSubmitted>(
      _onFindStudentSubmitted,
      transformer: restartable(),
    );
    on<ParentRegistrationStudentConfirmed>(_onStudentConfirmed);

    on<ParentRegistrationFirstNameChanged>(
      (event, emit) => emit(state.copyWith(firstName: event.value)),
    );
    on<ParentRegistrationLastNameChanged>(
      (event, emit) => emit(state.copyWith(lastName: event.value)),
    );
    on<ParentRegistrationPhoneChanged>(
      (event, emit) => emit(state.copyWith(phone: event.value)),
    );
    on<ParentRegistrationEmailChanged>(
      (event, emit) => emit(state.copyWith(email: event.value)),
    );
    on<ParentRegistrationRelationshipChanged>(
      (event, emit) => emit(state.copyWith(relationship: event.value)),
    );
    on<ParentRegistrationPasswordChanged>(
      (event, emit) => emit(state.copyWith(password: event.value)),
    );
    on<ParentRegistrationConfirmPasswordChanged>(
      (event, emit) => emit(state.copyWith(confirmPassword: event.value)),
    );

    on<ParentRegistrationNextStepRequested>(_onNextStepRequested);
    on<ParentRegistrationBackStepRequested>(_onBackStepRequested);
    // Droppable: protect against double-tap on the final submit button.
    on<ParentRegistrationSubmitted>(
      _onSubmitted,
      transformer: droppable(),
    );
  }

  void _onStepChanged(
    ParentRegistrationStepChanged event,
    Emitter<ParentRegistrationState> emit,
  ) {
    emit(state.copyWith(currentStep: event.step));
  }

  void _onLookupTypeChanged(
    ParentRegistrationLookupTypeChanged event,
    Emitter<ParentRegistrationState> emit,
  ) {
    emit(
      state.copyWith(
        lookupType: event.lookupType,
        lookupValue: '',
        foundStudent: const MentorXNullableValue(null),
        isStudentConfirmed: false,
      ),
    );
  }

  void _onLookupValueChanged(
    ParentRegistrationLookupValueChanged event,
    Emitter<ParentRegistrationState> emit,
  ) {
    emit(
      state.copyWith(
        lookupValue: event.value,
        foundStudent: const MentorXNullableValue(null),
        isStudentConfirmed: false,
      ),
    );
  }

  Future<void> _onFindStudentSubmitted(
    ParentRegistrationFindStudentSubmitted event,
    Emitter<ParentRegistrationState> emit,
  ) async {
    if (state.lookupValue.trim().isEmpty) {
      emitPresentation(
        const ParentRegistrationFailurePresentationEvent(
          kind: ParentRegistrationFailureKind.lookupEmpty,
        ),
      );
      return;
    }

    emit(state.copyWith(loadingState: ParentRegistrationLoadingState.loading));

    try {
      final student = await _authenticationRepository
          .findStudentForParentRegistration(
            lookupType: state.lookupType,
            value: state.lookupValue.trim(),
          );

      emit(
        state.copyWith(
          loadingState: ParentRegistrationLoadingState.loaded,
          foundStudent: MentorXNullableValue(student),
          isStudentConfirmed: false,
        ),
      );
    } on AuthenticationException catch (e) {
      emit(
        state.copyWith(loadingState: ParentRegistrationLoadingState.failure),
      );
      emitPresentation(
        ParentRegistrationFailurePresentationEvent(
          kind: _classifyLookupError(e),
          rawMessage: e.message,
        ),
      );
    } catch (e, s) {
      _logger.error('Find student failed: $e', e, s);
      emit(
        state.copyWith(loadingState: ParentRegistrationLoadingState.failure),
      );
      emitPresentation(
        const ParentRegistrationFailurePresentationEvent(
          kind: ParentRegistrationFailureKind.findFailed,
        ),
      );
    }
  }

  void _onStudentConfirmed(
    ParentRegistrationStudentConfirmed event,
    Emitter<ParentRegistrationState> emit,
  ) {
    emit(state.copyWith(isStudentConfirmed: true));
  }

  void _onNextStepRequested(
    ParentRegistrationNextStepRequested event,
    Emitter<ParentRegistrationState> emit,
  ) {
    final validation = _validationKindForStep(state.currentStep);
    if (validation != null) {
      emitPresentation(
        ParentRegistrationFailurePresentationEvent(kind: validation),
      );
      return;
    }

    if (state.currentStep < 2) {
      emit(state.copyWith(currentStep: state.currentStep + 1));
    }
  }

  void _onBackStepRequested(
    ParentRegistrationBackStepRequested event,
    Emitter<ParentRegistrationState> emit,
  ) {
    if (state.currentStep > 0) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
    }
  }

  Future<void> _onSubmitted(
    ParentRegistrationSubmitted event,
    Emitter<ParentRegistrationState> emit,
  ) async {
    for (var step = 0; step <= 2; step++) {
      final validation = _validationKindForStep(step);
      if (validation != null) {
        emitPresentation(
          ParentRegistrationFailurePresentationEvent(kind: validation),
        );
        return;
      }
    }

    final foundStudent = state.foundStudent;
    if (foundStudent == null) {
      emitPresentation(
        const ParentRegistrationFailurePresentationEvent(
          kind: ParentRegistrationFailureKind.findChildFirst,
        ),
      );
      return;
    }

    emit(state.copyWith(loadingState: ParentRegistrationLoadingState.loading));

    try {
      final deviceName = await _deviceInfoService.getDeviceName();
      final deviceHash = await _deviceInfoService.getDeviceHash();
      final appVersion = await _deviceInfoService.getAppVersion();

      final result = await _authenticationRepository.registerParent(
        firstName: state.firstName.trim(),
        lastName: state.lastName.trim(),
        phone: state.phone.trim(),
        email: state.email.trim().isEmpty ? null : state.email.trim(),
        password: state.password,
        relationship: state.relationship,
        studentId: foundStudent.studentId,
        deviceHash: deviceHash,
        deviceName: deviceName,
        appVersion: appVersion,
      );

      emit(state.copyWith(loadingState: ParentRegistrationLoadingState.loaded));
      emitPresentation(
        ParentRegistrationSuccessPresentationEvent(
          phone: result.phone ?? state.phone.trim(),
        ),
      );
    } on AuthenticationException catch (e) {
      emit(
        state.copyWith(loadingState: ParentRegistrationLoadingState.failure),
      );
      emitPresentation(
        ParentRegistrationFailurePresentationEvent(
          kind: _classifyRegistrationError(e),
          rawMessage: e.message,
        ),
      );
    } catch (e, s) {
      _logger.error('Register parent failed: $e', e, s);
      emit(
        state.copyWith(loadingState: ParentRegistrationLoadingState.failure),
      );
      emitPresentation(
        const ParentRegistrationFailurePresentationEvent(
          kind: ParentRegistrationFailureKind.registrationFailed,
        ),
      );
    }
  }

  /// Returns the first failure kind that prevents the user from advancing
  /// past the given step, or `null` if the step is fully valid.
  ParentRegistrationFailureKind? _validationKindForStep(int step) {
    switch (step) {
      case 0:
        if (state.foundStudent == null) {
          return ParentRegistrationFailureKind.findChildFirst;
        }
        if (!state.isStudentConfirmed) {
          return ParentRegistrationFailureKind.confirmChild;
        }
      case 1:
        if (state.firstName.trim().length < 2) {
          return ParentRegistrationFailureKind.firstNameShort;
        }
        if (state.lastName.trim().length < 2) {
          return ParentRegistrationFailureKind.lastNameShort;
        }
        if (!_isValidEgyptianPhone(state.phone)) {
          return ParentRegistrationFailureKind.invalidPhone;
        }
        if (state.email.trim().isNotEmpty &&
            Validator.validateEmail(state.email.trim()) != null) {
          return ParentRegistrationFailureKind.invalidEmail;
        }
        if (state.relationship.isEmpty) {
          return ParentRegistrationFailureKind.relationshipRequired;
        }
      case 2:
        if (Validator.validatePassword(state.password) != null) {
          return ParentRegistrationFailureKind.passwordWeak;
        }
        if (state.confirmPassword != state.password) {
          return ParentRegistrationFailureKind.passwordMismatch;
        }
    }
    return null;
  }

  /// Maps a backend lookup exception to a typed UI failure.
  ParentRegistrationFailureKind _classifyLookupError(
    AuthenticationException e,
  ) {
    return switch (e.code) {
      AuthenticationExceptionCode.studentNotFound =>
        ParentRegistrationFailureKind.studentNotFound,
      AuthenticationExceptionCode.networkError =>
        ParentRegistrationFailureKind.network,
      AuthenticationExceptionCode.sessionExpired =>
        ParentRegistrationFailureKind.unauthorized,
      _ => ParentRegistrationFailureKind.findFailed,
    };
  }

  /// Maps a backend registration exception to a typed UI failure.
  ParentRegistrationFailureKind _classifyRegistrationError(
    AuthenticationException e,
  ) {
    return switch (e.code) {
      AuthenticationExceptionCode.phoneAlreadyExists =>
        ParentRegistrationFailureKind.phoneAlreadyExists,
      AuthenticationExceptionCode.networkError =>
        ParentRegistrationFailureKind.network,
      AuthenticationExceptionCode.sessionExpired =>
        ParentRegistrationFailureKind.unauthorized,
      _ => ParentRegistrationFailureKind.registrationFailed,
    };
  }

  bool _isValidEgyptianPhone(String value) {
    final phone = value.trim();
    return phone.startsWith('01') && phone.length == 11;
  }
}
