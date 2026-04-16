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
    extends StudentRegistrationEvent {}

final class StudentRegistrationPreviousStepRequested
    extends StudentRegistrationEvent {}

final class StudentRegistrationStepChanged extends StudentRegistrationEvent {
  final int step;
  const StudentRegistrationStepChanged(this.step);
  @override
  List<Object?> get props => [step];
}

// Step 1: Personal
final class StudentRegistrationFirstNameChanged
    extends StudentRegistrationEvent {
  final String value;
  const StudentRegistrationFirstNameChanged(this.value);
}

final class StudentRegistrationLastNameChanged
    extends StudentRegistrationEvent {
  final String value;
  const StudentRegistrationLastNameChanged(this.value);
}

final class StudentRegistrationPhoneChanged extends StudentRegistrationEvent {
  final String value;
  const StudentRegistrationPhoneChanged(this.value);
}

final class StudentRegistrationPhoneUniquenessChecked
    extends StudentRegistrationEvent {
  final String phone;
  final bool isUnique;

  const StudentRegistrationPhoneUniquenessChecked({
    required this.phone,
    required this.isUnique,
  });

  @override
  List<Object?> get props => [phone, isUnique];
}

final class StudentRegistrationEmailChanged extends StudentRegistrationEvent {
  final String value;
  const StudentRegistrationEmailChanged(this.value);
}

final class StudentRegistrationGenderChanged extends StudentRegistrationEvent {
  final Gender value;
  const StudentRegistrationGenderChanged(this.value);
}

final class StudentRegistrationDateOfBirthChanged
    extends StudentRegistrationEvent {
  final DateTime value;
  const StudentRegistrationDateOfBirthChanged(this.value);
}

final class StudentRegistrationProfilePhotoChanged
    extends StudentRegistrationEvent {
  final String path;
  const StudentRegistrationProfilePhotoChanged(this.path);
}

// Step 2: Academic
final class StudentRegistrationGradeChanged extends StudentRegistrationEvent {
  final GradeEntity? value;
  const StudentRegistrationGradeChanged(this.value);
}

final class StudentRegistrationSchoolNameChanged
    extends StudentRegistrationEvent {
  final String value;
  const StudentRegistrationSchoolNameChanged(this.value);
}

final class StudentRegistrationStudyTypeChanged
    extends StudentRegistrationEvent {
  final StudyType value;
  const StudentRegistrationStudyTypeChanged(this.value);
}

final class StudentRegistrationCenterChanged extends StudentRegistrationEvent {
  final CenterEntity? value;
  const StudentRegistrationCenterChanged(this.value);
}

final class StudentRegistrationScheduleChanged
    extends StudentRegistrationEvent {
  final ScheduleEntity? value;
  const StudentRegistrationScheduleChanged(this.value);
}

final class StudentRegistrationGroupChanged extends StudentRegistrationEvent {
  final GroupEntity? value;
  const StudentRegistrationGroupChanged(this.value);
}

// Step 3: Location
final class StudentRegistrationGovernorateChanged
    extends StudentRegistrationEvent {
  final GovernorateEntity? value;
  const StudentRegistrationGovernorateChanged(this.value);
}

final class StudentRegistrationDistrictChanged
    extends StudentRegistrationEvent {
  final DistrictEntity? value;
  const StudentRegistrationDistrictChanged(this.value);
}

// Step 4: Parent
final class StudentRegistrationParentNameChanged
    extends StudentRegistrationEvent {
  final String value;
  const StudentRegistrationParentNameChanged(this.value);
}

final class StudentRegistrationParentPhoneChanged
    extends StudentRegistrationEvent {
  final String value;
  const StudentRegistrationParentPhoneChanged(this.value);
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

final class StudentRegistrationSubmitted extends StudentRegistrationEvent {}
