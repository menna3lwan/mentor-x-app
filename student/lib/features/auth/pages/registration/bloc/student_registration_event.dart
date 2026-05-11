part of 'student_registration_bloc.dart';

sealed class StudentRegistrationEvent extends Equatable {
  const StudentRegistrationEvent();

  @override
  List<Object?> get props => [];
}

final class StudentRegistrationBootstrapRequested
    extends StudentRegistrationEvent {
  const StudentRegistrationBootstrapRequested();
}

final class StudentRegistrationNextStepRequested
    extends StudentRegistrationEvent {
  const StudentRegistrationNextStepRequested();
}

final class StudentRegistrationPreviousStepRequested
    extends StudentRegistrationEvent {
  const StudentRegistrationPreviousStepRequested();
}

final class StudentRegistrationStepChanged extends StudentRegistrationEvent {
  final int step;
  const StudentRegistrationStepChanged(this.step);
  @override
  List<Object?> get props => [step];
}

// Step 0: Start
final class StudentRegistrationFirstNameChanged
    extends StudentRegistrationEvent {
  final String value;
  const StudentRegistrationFirstNameChanged(this.value);
}

final class StudentRegistrationPhoneChanged extends StudentRegistrationEvent {
  final String value;
  const StudentRegistrationPhoneChanged(this.value);
}

final class StudentRegistrationParentPhoneChanged
    extends StudentRegistrationEvent {
  final String value;
  const StudentRegistrationParentPhoneChanged(this.value);
}

final class StudentRegistrationStartRequested extends StudentRegistrationEvent {
  const StudentRegistrationStartRequested();
}

final class StudentRegistrationCheckPhoneRequested
    extends StudentRegistrationEvent {
  final String phone;
  const StudentRegistrationCheckPhoneRequested(this.phone);
}

// Step 1: OTP
final class StudentRegistrationOtpChanged extends StudentRegistrationEvent {
  final String value;
  const StudentRegistrationOtpChanged(this.value);
}

final class StudentRegistrationResendOtpRequested
    extends StudentRegistrationEvent {
  const StudentRegistrationResendOtpRequested();
}

final class StudentRegistrationVerifyOtpRequested
    extends StudentRegistrationEvent {
  const StudentRegistrationVerifyOtpRequested();
}

// Step 2: Full Personal
final class StudentRegistrationSecondNameChanged
    extends StudentRegistrationEvent {
  final String value;
  const StudentRegistrationSecondNameChanged(this.value);
}

final class StudentRegistrationThirdNameChanged
    extends StudentRegistrationEvent {
  final String value;
  const StudentRegistrationThirdNameChanged(this.value);
}

final class StudentRegistrationFourthNameChanged
    extends StudentRegistrationEvent {
  final String value;
  const StudentRegistrationFourthNameChanged(this.value);
}

final class StudentRegistrationProfilePhotoChanged
    extends StudentRegistrationEvent {
  final String path;
  const StudentRegistrationProfilePhotoChanged(this.path);
}

// Step 3: Academic
final class StudentRegistrationGradeChanged extends StudentRegistrationEvent {
  final GradeEntity? value;
  const StudentRegistrationGradeChanged(this.value);
}

final class StudentRegistrationSchoolNameChanged
    extends StudentRegistrationEvent {
  final String value;
  const StudentRegistrationSchoolNameChanged(this.value);
}

final class StudentRegistrationOnlineToggleChanged
    extends StudentRegistrationEvent {
  final bool value;
  const StudentRegistrationOnlineToggleChanged(this.value);
}

final class StudentRegistrationCenterNameChanged
    extends StudentRegistrationEvent {
  final String value;
  const StudentRegistrationCenterNameChanged(this.value);
}

final class StudentRegistrationEducationDepartmentChanged
    extends StudentRegistrationEvent {
  final String value;
  const StudentRegistrationEducationDepartmentChanged(this.value);
}

// Step 4: Location
final class StudentRegistrationGovernorateChanged
    extends StudentRegistrationEvent {
  final GovernorateEntity? value;
  const StudentRegistrationGovernorateChanged(this.value);
}

final class StudentRegistrationAreaChanged extends StudentRegistrationEvent {
  final String? value;
  const StudentRegistrationAreaChanged(this.value);
}

// Step 5: Security
final class StudentRegistrationPasswordChanged
    extends StudentRegistrationEvent {
  final String value;
  const StudentRegistrationPasswordChanged(this.value);
}

final class StudentRegistrationConfirmPasswordChanged
    extends StudentRegistrationEvent {
  final String value;
  const StudentRegistrationConfirmPasswordChanged(this.value);
}

final class StudentRegistrationIdCardPhotoChanged
    extends StudentRegistrationEvent {
  final String path;
  const StudentRegistrationIdCardPhotoChanged(this.path);
}

final class StudentRegistrationSubmitted extends StudentRegistrationEvent {
  const StudentRegistrationSubmitted();
}

@Deprecated('Use individual name parts')
final class StudentRegistrationLastNameChanged
    extends StudentRegistrationEvent {
  final String value;
  const StudentRegistrationLastNameChanged(this.value);
}

@Deprecated('Use areas strings')
final class StudentRegistrationDistrictChanged
    extends StudentRegistrationEvent {
  final DistrictEntity? value;
  const StudentRegistrationDistrictChanged(this.value);
}

@Deprecated('Use individual center/online fields')
final class StudentRegistrationStudyTypeChanged
    extends StudentRegistrationEvent {
  final StudyType value;
  const StudentRegistrationStudyTypeChanged(this.value);
}
