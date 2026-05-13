import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/core.dart';
import 'package:device_info_service/device_info_service.dart';

part 'parent_registration_event.dart';
part 'parent_registration_state.dart';

sealed class ParentRegistrationPresentationEvent {
  const ParentRegistrationPresentationEvent();
}

final class ParentRegistrationFailurePresentationEvent
    extends ParentRegistrationPresentationEvent {
  final String message;

  const ParentRegistrationFailurePresentationEvent({required this.message});
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
  final AnalyticsService _analyticsService;
  final MentorXLogger _logger = MentorXLogger('ParentRegistrationBloc');

  ParentRegistrationBloc({
    required AuthenticationRepository authenticationRepository,
    required DeviceInfoService deviceInfoService,
    required AnalyticsService analyticsService,
  }) : _authenticationRepository = authenticationRepository,
       _deviceInfoService = deviceInfoService,
       _analyticsService = analyticsService,
       super(const ParentRegistrationState()) {
    on<ParentRegistrationStepChanged>(_onStepChanged);
    on<ParentRegistrationLookupTypeChanged>(_onLookupTypeChanged);
    on<ParentRegistrationLookupValueChanged>(_onLookupValueChanged);
    on<ParentRegistrationFindStudentSubmitted>(_onFindStudentSubmitted);
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
    on<ParentRegistrationSubmitted>(_onSubmitted);
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
          message: 'Please enter a child phone number or student code.',
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
          message: e.message ?? 'No student found with this identifier.',
        ),
      );
    } catch (e, s) {
      _logger.error('Find student failed: $e', e, s);
      emit(
        state.copyWith(loadingState: ParentRegistrationLoadingState.failure),
      );
      emitPresentation(
        const ParentRegistrationFailurePresentationEvent(
          message: 'Failed to find student. Please try again.',
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
    final validation = _validationMessageForStep(state.currentStep);
    if (validation != null) {
      emitPresentation(
        ParentRegistrationFailurePresentationEvent(message: validation),
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
      final validation = _validationMessageForStep(step);
      if (validation != null) {
        emitPresentation(
          ParentRegistrationFailurePresentationEvent(message: validation),
        );
        return;
      }
    }

    final foundStudent = state.foundStudent;
    if (foundStudent == null) {
      emitPresentation(
        const ParentRegistrationFailurePresentationEvent(
          message: 'Please find and confirm your child first.',
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

      _analyticsService.logEvent(name: AnalyticsEvents.registrationStarted);
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
          message: e.message ?? 'Registration failed. Please try again.',
        ),
      );
    } catch (e, s) {
      _logger.error('Register parent failed: $e', e, s);
      emit(
        state.copyWith(loadingState: ParentRegistrationLoadingState.failure),
      );
      emitPresentation(
        const ParentRegistrationFailurePresentationEvent(
          message: 'Registration failed. Please try again.',
        ),
      );
    }
  }

  String? _validationMessageForStep(int step) {
    switch (step) {
      case 0:
        if (state.foundStudent == null) {
          return 'Please find your child first.';
        }
        if (!state.isStudentConfirmed) {
          return 'Please confirm that this is your child.';
        }
        break;
      case 1:
        if (state.firstName.trim().length < 2) {
          return 'First name must be at least 2 characters.';
        }
        if (state.lastName.trim().length < 2) {
          return 'Last name must be at least 2 characters.';
        }
        if (!_isValidEgyptianPhone(state.phone)) {
          return 'Please enter a valid Egyptian phone number.';
        }
        if (state.email.trim().isNotEmpty &&
            Validator.validateEmail(state.email.trim()) != null) {
          return Validator.validateEmail(state.email.trim());
        }
        if (state.relationship.isEmpty) {
          return 'Please select relationship with the child.';
        }
        break;
      case 2:
        if (Validator.validatePassword(state.password) != null) {
          return Validator.validatePassword(state.password);
        }
        if (state.confirmPassword != state.password) {
          return 'Passwords do not match.';
        }
        break;
    }

    return null;
  }

  bool _isValidEgyptianPhone(String value) {
    final phone = value.trim();
    return phone.startsWith('01') && phone.length == 11;
  }
}
