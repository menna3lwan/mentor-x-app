import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import '../../../../../core/core.dart';

part 'student_registration_event.dart';
part 'student_registration_state.dart';

sealed class StudentRegistrationPresentationEvent {}

final class StudentRegistrationSuccessPresentationEvent
    extends StudentRegistrationPresentationEvent {
  final String studentCode;
  final int? otpExpiresInSeconds;
  StudentRegistrationSuccessPresentationEvent({
    required this.studentCode,
    this.otpExpiresInSeconds,
  });
}

final class StudentRegistrationFailurePresentationEvent
    extends StudentRegistrationPresentationEvent {
  final String message;
  StudentRegistrationFailurePresentationEvent(this.message);
}

final class StudentRegistrationBloc
    extends Bloc<StudentRegistrationEvent, StudentRegistrationState>
    with
        BlocPresentationMixin<
          StudentRegistrationState,
          StudentRegistrationPresentationEvent
        > {
  final StudentRegistrationRepository _registrationRepository;
  final String _tenantId;
  Timer? _phoneUniquenessTimer;

  StudentRegistrationBloc({
    required StudentRegistrationRepository registrationRepository,
    required String tenantId,
  }) : _registrationRepository = registrationRepository,
       _tenantId = tenantId,
       super(const StudentRegistrationState()) {
    on<StudentRegistrationBootstrapRequested>(_onBootstrapRequested);
    on<StudentRegistrationStepChanged>(_onStepChanged);
    on<StudentRegistrationNextStepRequested>(_onNextStepRequested);
    on<StudentRegistrationPreviousStepRequested>(_onPreviousStepRequested);
    on<StudentRegistrationFirstNameChanged>(
      (event, emit) => emit(state.copyWith(firstName: event.value)),
    );
    on<StudentRegistrationLastNameChanged>(
      (event, emit) => emit(state.copyWith(lastName: event.value)),
    );
    on<StudentRegistrationPhoneChanged>(_onPhoneChanged);
    on<StudentRegistrationPhoneUniquenessChecked>(
      _onPhoneUniquenessChecked,
    );
    on<StudentRegistrationEmailChanged>(
      (event, emit) => emit(state.copyWith(email: event.value)),
    );
    on<StudentRegistrationGenderChanged>(
      (event, emit) => emit(state.copyWith(gender: event.value)),
    );
    on<StudentRegistrationDateOfBirthChanged>(
      (event, emit) =>
          emit(state.copyWith(dateOfBirth: MentorXNullableValue(event.value))),
    );
    on<StudentRegistrationProfilePhotoChanged>(
      (event, emit) => emit(
        state.copyWith(profilePhotoPath: MentorXNullableValue(event.path)),
      ),
    );

    // Academic
    on<StudentRegistrationGradeChanged>(_onGradeChanged);
    on<StudentRegistrationSchoolNameChanged>(
      (event, emit) => emit(state.copyWith(schoolName: event.value)),
    );
    on<StudentRegistrationStudyTypeChanged>(_onStudyTypeChanged);
    on<StudentRegistrationCenterChanged>(_onCenterChanged);
    on<StudentRegistrationScheduleChanged>(_onScheduleChanged);
    on<StudentRegistrationGroupChanged>(_onGroupChanged);

    // Location
    on<StudentRegistrationGovernorateChanged>(_onGovernorateChanged);
    on<StudentRegistrationDistrictChanged>(
      (event, emit) => emit(
        state.copyWith(selectedDistrict: MentorXNullableValue(event.value)),
      ),
    );

    // Parent
    on<StudentRegistrationParentNameChanged>(
      (event, emit) => emit(state.copyWith(parentName: event.value)),
    );
    on<StudentRegistrationParentPhoneChanged>(
      (event, emit) => emit(state.copyWith(parentPhone: event.value)),
    );

    // Security
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

  Future<void> _onBootstrapRequested(
    StudentRegistrationBootstrapRequested event,
    Emitter<StudentRegistrationState> emit,
  ) async {
    add(const StudentRegistrationStepChanged(0));
    try {
      final grades = await _registrationRepository.getGrades(_tenantId);
      final governorates = await _registrationRepository.getGovernorates();
      emit(state.copyWith(grades: grades, governorates: governorates));
    } catch (_) {}
  }

  void _onStepChanged(
    StudentRegistrationStepChanged event,
    Emitter<StudentRegistrationState> emit,
  ) {
    emit(state.copyWith(currentStep: event.step));
  }

  void _onNextStepRequested(
    StudentRegistrationNextStepRequested event,
    Emitter<StudentRegistrationState> emit,
  ) {
    final validationMessage = _validationMessageForStep(state.currentStep);
    if (validationMessage != null) {
      emitPresentation(
        StudentRegistrationFailurePresentationEvent(validationMessage),
      );
      return;
    }

    if (state.currentStep < 4) {
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

  Future<void> _onPhoneChanged(
    StudentRegistrationPhoneChanged event,
    Emitter<StudentRegistrationState> emit,
  ) async {
    _phoneUniquenessTimer?.cancel();

    emit(state.copyWith(phone: event.value));

    if (event.value.length != 11) {
      emit(state.copyWith(isPhoneUnique: true));
      return;
    }

    _phoneUniquenessTimer = Timer(const Duration(milliseconds: 500), () async {
      bool isUnique = true;

      try {
        isUnique = await _registrationRepository.checkPhoneUniqueness(
          event.value,
        );
      } catch (_) {
        isUnique = true;
      }

      if (isClosed) {
        return;
      }

      add(
        StudentRegistrationPhoneUniquenessChecked(
          phone: event.value,
          isUnique: isUnique,
        ),
      );
    });
  }

  void _onPhoneUniquenessChecked(
    StudentRegistrationPhoneUniquenessChecked event,
    Emitter<StudentRegistrationState> emit,
  ) {
    if (state.phone != event.phone) {
      return;
    }

    emit(state.copyWith(isPhoneUnique: event.isUnique));
  }

  Future<void> _onGradeChanged(
    StudentRegistrationGradeChanged event,
    Emitter<StudentRegistrationState> emit,
  ) async {
    emit(
      state.copyWith(
        selectedGrade: MentorXNullableValue(event.value),
        selectedCenter: const MentorXNullableValue(null),
        selectedSchedule: const MentorXNullableValue(null),
        selectedGroup: const MentorXNullableValue(null),
      ),
    );
    if (event.value != null &&
        (state.studyType == StudyType.center ||
            state.studyType == StudyType.both)) {
      final centers = await _registrationRepository.getCenters(_tenantId);
      emit(state.copyWith(centers: centers));
    }
  }

  Future<void> _onStudyTypeChanged(
    StudentRegistrationStudyTypeChanged event,
    Emitter<StudentRegistrationState> emit,
  ) async {
    emit(state.copyWith(studyType: event.value));
    if ((event.value == StudyType.center || event.value == StudyType.both) &&
        state.selectedGrade != null) {
      final centers = await _registrationRepository.getCenters(_tenantId);
      emit(state.copyWith(centers: centers));
    }
  }

  Future<void> _onCenterChanged(
    StudentRegistrationCenterChanged event,
    Emitter<StudentRegistrationState> emit,
  ) async {
    emit(
      state.copyWith(
        selectedCenter: MentorXNullableValue(event.value),
        selectedSchedule: const MentorXNullableValue(null),
        selectedGroup: const MentorXNullableValue(null),
      ),
    );
    if (event.value != null && state.selectedGrade != null) {
      final schedules = await _registrationRepository.getSchedules(
        centerId: event.value!.id,
        gradeId: state.selectedGrade!.id,
      );
      emit(state.copyWith(schedules: schedules));
    }
  }

  Future<void> _onScheduleChanged(
    StudentRegistrationScheduleChanged event,
    Emitter<StudentRegistrationState> emit,
  ) async {
    emit(
      state.copyWith(
        selectedSchedule: MentorXNullableValue(event.value),
        selectedGroup: const MentorXNullableValue(null),
      ),
    );
    if (event.value != null &&
        state.selectedCenter != null &&
        state.selectedGrade != null) {
      final groups = await _registrationRepository.getGroups(
        centerId: state.selectedCenter!.id,
        gradeId: state.selectedGrade!.id,
        scheduleId: event.value!.id,
      );
      emit(state.copyWith(groups: groups));
    }
  }

  void _onGroupChanged(
    StudentRegistrationGroupChanged event,
    Emitter<StudentRegistrationState> emit,
  ) {
    emit(state.copyWith(selectedGroup: MentorXNullableValue(event.value)));
  }

  Future<void> _onGovernorateChanged(
    StudentRegistrationGovernorateChanged event,
    Emitter<StudentRegistrationState> emit,
  ) async {
    emit(
      state.copyWith(
        selectedGovernorate: MentorXNullableValue(event.value),
        selectedDistrict: const MentorXNullableValue(null),
      ),
    );
    if (event.value != null) {
      final districts = await _registrationRepository.getDistricts(
        event.value!.id,
      );
      emit(state.copyWith(districts: districts));
    }
  }

  Future<void> _onSubmitted(
    StudentRegistrationSubmitted event,
    Emitter<StudentRegistrationState> emit,
  ) async {
    for (var step = 0; step <= 4; step++) {
      final validationMessage = _validationMessageForStep(step);
      if (validationMessage != null) {
        emitPresentation(
          StudentRegistrationFailurePresentationEvent(validationMessage),
        );
        return;
      }
    }

    if (state.password != state.confirmPassword) {
      emitPresentation(
        StudentRegistrationFailurePresentationEvent('Passwords do not match.'),
      );
      return;
    }

    emit(state.copyWith(loadingState: LoadingState.loading));

    try {
      String? profilePhotoUrl;
      if (state.profilePhotoPath != null) {
        profilePhotoUrl = await _registrationRepository.uploadImage(
          state.profilePhotoPath!,
        );
      }

      String? idCardPhotoUrl;
      if (state.idCardPhotoPath != null) {
        idCardPhotoUrl = await _registrationRepository.uploadImage(
          state.idCardPhotoPath!,
        );
      }

      final deviceHash = await _buildDeviceHash();

      final result = await _registrationRepository.register(
        tenantId: _tenantId,
        firstName: state.firstName,
        lastName: state.lastName,
        phone: state.phone,
        email: state.email.isEmpty ? null : state.email,
        gender: state.gender.name,
        dateOfBirth: state.dateOfBirth!,
        profilePhotoUrl: profilePhotoUrl,
        gradeId: state.selectedGrade!.id,
        schoolName: state.schoolName.isEmpty ? null : state.schoolName,
        studyType: state.studyType.name,
        centerId: state.selectedCenter?.id,
        scheduleId: state.selectedSchedule?.id,
        centerGroupId: state.selectedGroup?.id,
        governorateId: state.selectedGovernorate!.id,
        districtId: state.selectedDistrict!.id,
        parentName: state.parentName,
        parentPhone: state.parentPhone,
        password: state.password,
        idCardPhotoUrl: idCardPhotoUrl,
        deviceHash: deviceHash,
      );

      emit(state.copyWith(loadingState: LoadingState.loaded));
      emitPresentation(
        StudentRegistrationSuccessPresentationEvent(
          studentCode: result.studentCode,
          otpExpiresInSeconds: result.otpExpiresInSeconds,
        ),
      );
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
          return 'First name must be at least 2 characters.';
        }
        if (state.lastName.trim().length < 2) {
          return 'Last name must be at least 2 characters.';
        }
        if (!_isValidEgyptPhone(state.phone)) {
          return 'Please enter a valid phone number.';
        }
        if (!state.isPhoneUnique) {
          return 'This phone number is already registered.';
        }
        if (state.dateOfBirth == null) {
          return 'Please select your date of birth.';
        }
        if (!_isAgeBetween(state.dateOfBirth!, 5, 25)) {
          return 'Age must be between 5 and 25 years.';
        }
        break;
      case 1:
        if (state.selectedGrade == null) {
          return 'Please select your grade.';
        }
        if (state.studyType == StudyType.center ||
            state.studyType == StudyType.both) {
          if (state.selectedCenter == null) {
            return 'Please select a center.';
          }
          if (state.selectedSchedule == null) {
            return 'Please select a schedule.';
          }
        }
        break;
      case 2:
        if (state.selectedGovernorate == null) {
          return 'Please select your governorate.';
        }
        if (state.selectedDistrict == null) {
          return 'Please select your district.';
        }
        break;
      case 3:
        if (state.parentName.trim().length < 5) {
          return 'Parent name must be at least 5 characters.';
        }
        if (!_isValidEgyptPhone(state.parentPhone)) {
          return 'Please enter a valid parent phone number.';
        }
        if (state.parentPhone == state.phone) {
          return 'Parent phone number must be different from student phone.';
        }
        break;
      case 4:
        if (state.password != state.confirmPassword) {
          return 'Passwords do not match.';
        }
        final passwordValidationMessage = _passwordValidationMessage(
          state.password,
        );
        if (passwordValidationMessage != null) {
          return passwordValidationMessage;
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

  bool _isAgeBetween(DateTime dateOfBirth, int minAge, int maxAge) {
    final now = DateTime.now();
    var age = now.year - dateOfBirth.year;
    final hadBirthdayThisYear =
        now.month > dateOfBirth.month ||
        (now.month == dateOfBirth.month && now.day >= dateOfBirth.day);
    if (!hadBirthdayThisYear) {
      age -= 1;
    }
    return age >= minAge && age <= maxAge;
  }

  String? _passwordValidationMessage(String password) {
    if (password.length < 8) {
      return 'Password must be at least 8 characters.';
    }
    final hasUppercase = password.contains(RegExp(r'[A-Z]'));
    final hasLowercase = password.contains(RegExp(r'[a-z]'));
    final hasDigit = password.contains(RegExp(r'[0-9]'));
    final hasSpecialCharacter = password.contains(
      RegExp(r'[!@#\$%^&*(),.?":{}|<>]'),
    );

    if (!hasUppercase || !hasLowercase || !hasDigit || !hasSpecialCharacter) {
      return 'Password must include uppercase, lowercase, number, and special character.';
    }
    return null;
  }

  Future<String> _buildDeviceHash() async {
    final raw = [
      Platform.operatingSystem,
      Platform.operatingSystemVersion,
      Platform.localHostname,
      Platform.localeName,
    ].join('|');
    return base64UrlEncode(utf8.encode(raw)).replaceAll('=', '');
  }

  @override
  Future<void> close() {
    _phoneUniquenessTimer?.cancel();
    return super.close();
  }
}
