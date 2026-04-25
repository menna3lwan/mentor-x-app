import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import '../../../../../core/core.dart';

part 'student_registration_event.dart';
part 'student_registration_state.dart';

sealed class StudentRegistrationPresentationEvent {}

final class StudentRegistrationSuccessPresentationEvent
    extends StudentRegistrationPresentationEvent {
  final String? studentCode;
  final int? otpExpiresInSeconds;
  StudentRegistrationSuccessPresentationEvent({
    this.studentCode,
    this.otpExpiresInSeconds,
  });
}

final class StudentRegistrationFailurePresentationEvent
    extends StudentRegistrationPresentationEvent {
  final String message;
  StudentRegistrationFailurePresentationEvent(this.message);
}

final class StudentRegistrationOtpSentPresentationEvent
    extends StudentRegistrationPresentationEvent {}

final class StudentRegistrationBloc
    extends Bloc<StudentRegistrationEvent, StudentRegistrationState>
    with
        BlocPresentationMixin<
          StudentRegistrationState,
          StudentRegistrationPresentationEvent
        > {
  final StudentRegistrationRepository _registrationRepository;

  StudentRegistrationBloc({
    required StudentRegistrationRepository registrationRepository,
    required String tenantId,
  }) : _registrationRepository = registrationRepository,
       super(const StudentRegistrationState()) {
    on<StudentRegistrationBootstrapRequested>(_onBootstrapRequested);
    on<StudentRegistrationStepChanged>(_onStepChanged);
    on<StudentRegistrationNextStepRequested>(_onNextStepRequested);
    on<StudentRegistrationPreviousStepRequested>(_onPreviousStepRequested);
    
    // Step 0: Start
    on<StudentRegistrationFirstNameChanged>(
      (event, emit) => emit(state.copyWith(firstName: event.value)),
    );
    on<StudentRegistrationPhoneChanged>(_onPhoneChanged);
    on<StudentRegistrationCheckPhoneRequested>(_onCheckPhoneRequested);
    on<StudentRegistrationParentPhoneChanged>(
      (event, emit) => emit(state.copyWith(parentPhone: event.value)),
    );
    on<StudentRegistrationStartRequested>(_onStartRequested);

    // Step 1: OTP
    on<StudentRegistrationOtpChanged>(
      (event, emit) => emit(state.copyWith(otp: event.value)),
    );
    on<StudentRegistrationResendOtpRequested>(_onResendOtpRequested);

    // Step 2: Full Personal
    on<StudentRegistrationSecondNameChanged>(
      (event, emit) => emit(state.copyWith(secondName: event.value)),
    );
    on<StudentRegistrationThirdNameChanged>(
      (event, emit) => emit(state.copyWith(thirdName: event.value)),
    );
    on<StudentRegistrationFourthNameChanged>(
      (event, emit) => emit(state.copyWith(fourthName: event.value)),
    );
    on<StudentRegistrationProfilePhotoChanged>(
      (event, emit) => emit(
        state.copyWith(profilePhotoPath: MentorXNullableValue(event.path)),
      ),
    );

    // Step 3: Academic
    on<StudentRegistrationGradeChanged>(_onGradeChanged);
    on<StudentRegistrationSchoolNameChanged>(
      (event, emit) => emit(state.copyWith(schoolName: event.value)),
    );
    on<StudentRegistrationOnlineToggleChanged>(
      (event, emit) => emit(state.copyWith(isOnline: event.value)),
    );
    on<StudentRegistrationCenterNameChanged>(
      (event, emit) => emit(state.copyWith(centerName: MentorXNullableValue(event.value))),
    );
    on<StudentRegistrationEducationDepartmentChanged>(
      (event, emit) => emit(state.copyWith(educationDepartment: event.value)),
    );

    // Step 4: Location
    on<StudentRegistrationGovernorateChanged>(_onGovernorateChanged);
    on<StudentRegistrationAreaChanged>(
      (event, emit) => emit(
        state.copyWith(selectedArea: MentorXNullableValue(event.value)),
      ),
    );

    // Step 5: Security
    on<StudentRegistrationPasswordChanged>(
      (event, emit) => emit(state.copyWith(password: event.value)),
    );
    on<StudentRegistrationConfirmPasswordChanged>(
      (event, emit) => emit(state.copyWith(confirmPassword: event.value)),
    );
    on<StudentRegistrationIdCardPhotoChanged>(
      (event, emit) => emit(
        state.copyWith(idCardPhotoPath: MentorXNullableValue(event.path)),
      ),
    );

    on<StudentRegistrationSubmitted>(_onSubmitted);

    add(const StudentRegistrationBootstrapRequested());
  }

  void _onPhoneChanged(
    StudentRegistrationPhoneChanged event,
    Emitter<StudentRegistrationState> emit,
  ) {
    emit(state.copyWith(phone: event.value));
    if (_isValidEgyptPhone(event.value)) {
      add(StudentRegistrationCheckPhoneRequested(event.value));
    }
  }

  Future<void> _onCheckPhoneRequested(
    StudentRegistrationCheckPhoneRequested event,
    Emitter<StudentRegistrationState> emit,
  ) async {
    try {
      final isAvailable = await _registrationRepository.checkPhone(event.phone);
      emit(state.copyWith(isPhoneUnique: isAvailable));
    } catch (_) {
      // If check fails, assume it's okay or ignore? 
      // Usually, if it's 409, checkPhone returns false.
    }
  }

  Future<void> _onBootstrapRequested(
    StudentRegistrationBootstrapRequested event,
    Emitter<StudentRegistrationState> emit,
  ) async {
    try {
      final governorates = await _registrationRepository.getGovernorates();
      final appInfo = await _registrationRepository.getApplicationInfo();
      
      final gradesRaw = appInfo['grades'] as List?;
      final grades = gradesRaw?.map((g) {
        final map = g as Map<String, dynamic>;
        return GradeEntity(
          id: map['id']?.toString() ?? '',
          name: map['name']?.toString() ?? '',
        );
      }).toList() ?? [];

      emit(state.copyWith(
        governorates: governorates,
        grades: grades,
      ));
    } catch (_) {}
  }

  void _onStepChanged(
    StudentRegistrationStepChanged event,
    Emitter<StudentRegistrationState> emit,
  ) {
    emit(state.copyWith(currentStep: event.step));
  }

  Future<void> _onStartRequested(
    StudentRegistrationStartRequested event,
    Emitter<StudentRegistrationState> emit,
  ) async {
    final validation = _validationMessageForStep(0);
    if (validation != null) {
      emitPresentation(StudentRegistrationFailurePresentationEvent(validation));
      return;
    }

    emit(state.copyWith(loadingState: LoadingState.loading));
    try {
      await _registrationRepository.startRegistration(
        firstName: state.firstName,
        phone: state.phone,
        parentPhone: state.parentPhone,
      );
      emit(state.copyWith(
        loadingState: LoadingState.loaded,
        isRegistrationStarted: true,
        currentStep: 1, // Move to OTP
      ));
      emitPresentation(StudentRegistrationOtpSentPresentationEvent());
    } catch (e) {
      emit(state.copyWith(
        loadingState: LoadingState.error,
        errorMessage: MentorXNullableValue(e.toString()),
      ));
      emitPresentation(StudentRegistrationFailurePresentationEvent(e.toString()));
    }
  }

  Future<void> _onResendOtpRequested(
    StudentRegistrationResendOtpRequested event,
    Emitter<StudentRegistrationState> emit,
  ) async {
    try {
      await _registrationRepository.resendOtp(state.phone);
      emitPresentation(StudentRegistrationOtpSentPresentationEvent());
    } catch (e) {
      emitPresentation(StudentRegistrationFailurePresentationEvent(e.toString()));
    }
  }

  void _onNextStepRequested(
    StudentRegistrationNextStepRequested event,
    Emitter<StudentRegistrationState> emit,
  ) {
    if (state.currentStep == 0 && !state.isRegistrationStarted) {
      add(const StudentRegistrationStartRequested());
      return;
    }

    final validationMessage = _validationMessageForStep(state.currentStep);
    if (validationMessage != null) {
      emitPresentation(
        StudentRegistrationFailurePresentationEvent(validationMessage),
      );
      return;
    }

    if (state.currentStep < 5) {
      emit(state.copyWith(currentStep: state.currentStep + 1));
    }
  }

  void _onPreviousStepRequested(
    StudentRegistrationPreviousStepRequested event,
    Emitter<StudentRegistrationState> emit,
  ) {
    if (state.currentStep > 0) {
      emit(state.copyWith(currentStep: state.currentStep - 1));
    }
  }

  Future<void> _onGradeChanged(
    StudentRegistrationGradeChanged event,
    Emitter<StudentRegistrationState> emit,
  ) async {
    emit(state.copyWith(selectedGrade: MentorXNullableValue(event.value)));
  }

  Future<void> _onGovernorateChanged(
    StudentRegistrationGovernorateChanged event,
    Emitter<StudentRegistrationState> emit,
  ) async {
    emit(
      state.copyWith(
        selectedGovernorate: MentorXNullableValue(event.value),
        selectedArea: const MentorXNullableValue(null),
      ),
    );
    if (event.value != null) {
      try {
        final areas = await _registrationRepository.getAreas(event.value!.name);
        emit(state.copyWith(areas: areas));
      } catch (_) {}
    }
  }

  Future<void> _onSubmitted(
    StudentRegistrationSubmitted event,
    Emitter<StudentRegistrationState> emit,
  ) async {
    for (var step = 0; step <= 5; step++) {
      final validationMessage = _validationMessageForStep(step);
      if (validationMessage != null) {
        emitPresentation(
          StudentRegistrationFailurePresentationEvent(validationMessage),
        );
        return;
      }
    }

    emit(state.copyWith(loadingState: LoadingState.loading));

    try {
      await _registrationRepository.completeRegistration(
        firstName: state.firstName,
        secondName: state.secondName,
        thirdName: state.thirdName,
        fourthName: state.fourthName,
        governorate: state.selectedGovernorate!.name,
        area: state.selectedArea!,
        grade: state.selectedGrade!.name,
        online: state.isOnline,
        otp: state.otp,
        parentPhone: state.parentPhone,
        phone: state.phone,
        password: state.password,
        confirmPassword: state.confirmPassword,
        schoolName: state.schoolName.isEmpty ? null : state.schoolName,
        educationDepartment: state.educationDepartment.isEmpty ? null : state.educationDepartment,
        centerName: state.centerName?.isEmpty ?? true ? null : state.centerName,
        profileImagePath: state.profilePhotoPath,
        identityDocumentPath: state.idCardPhotoPath,
      );

      emit(state.copyWith(loadingState: LoadingState.loaded));
      emitPresentation(StudentRegistrationSuccessPresentationEvent());
    } catch (e) {
      emit(
        state.copyWith(
          loadingState: LoadingState.error,
          errorMessage: MentorXNullableValue(e.toString()),
        ),
      );
      emitPresentation(
        StudentRegistrationFailurePresentationEvent(e.toString()),
      );
    }
  }

  String? _validationMessageForStep(int step) {
    switch (step) {
      case 0:
        if (state.firstName.trim().length < 2) {
          return 'First name is required.';
        }
        if (!_isValidEgyptPhone(state.phone)) {
          return 'Please enter a valid phone number.';
        }
        if (!state.isPhoneUnique) {
          return 'This phone number is already registered.';
        }
        if (!_isValidEgyptPhone(state.parentPhone)) {
          return 'Please enter a valid parent phone number.';
        }
        if (state.parentPhone == state.phone) {
          return 'Parent phone number must be different from student phone.';
        }
        break;
      case 1:
        if (state.otp.length < 4) {
          return 'Please enter a valid OTP.';
        }
        break;
      case 2:
        if (state.secondName.trim().isEmpty) return 'Second name is required.';
        if (state.thirdName.trim().isEmpty) return 'Third name is required.';
        if (state.fourthName.trim().isEmpty) return 'Fourth name is required.';
        break;
      case 3:
        if (state.selectedGrade == null) {
          return 'Please select your grade.';
        }
        if (!state.isOnline && (state.centerName?.isEmpty ?? true)) {
          return 'Please enter the center name.';
        }
        break;
      case 4:
        if (state.selectedGovernorate == null) {
          return 'Please select your governorate.';
        }
        if (state.selectedArea == null) {
          return 'Please select your area.';
        }
        break;
      case 5:
        if (state.password != state.confirmPassword) {
          return 'Passwords do not match.';
        }
        if (state.password.length < 6) {
          return 'Password must be at least 6 characters.';
        }
        break;
    }
    return null;
  }

  bool _isValidEgyptPhone(String phone) {
    final value = phone.trim();
    if (value.length != 11) return false;
    return value.startsWith('010') ||
        value.startsWith('011') ||
        value.startsWith('012') ||
        value.startsWith('015');
  }
}
