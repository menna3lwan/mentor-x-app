part of 'student_registration_bloc.dart';

final class StudentRegistrationState extends Equatable {
  final int currentStep;
  final LoadingState loadingState;
  final String? errorMessage;
  
  // Step 1: Personal
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final Gender gender;
  final DateTime? dateOfBirth;
  final String? profilePhotoPath;
  final bool isPhoneUnique;
  
  // Step 2: Academic
  final List<GradeEntity> grades;
  final GradeEntity? selectedGrade;
  final String schoolName;
  final StudyType studyType;
  final List<CenterEntity> centers;
  final CenterEntity? selectedCenter;
  final List<ScheduleEntity> schedules;
  final ScheduleEntity? selectedSchedule;
  final List<GroupEntity> groups;
  final GroupEntity? selectedGroup;
  
  // Step 3: Location
  final List<GovernorateEntity> governorates;
  final GovernorateEntity? selectedGovernorate;
  final List<DistrictEntity> districts;
  final DistrictEntity? selectedDistrict;
  
  // Step 4: Parent
  final String parentName;
  final String parentPhone;
  
  // Step 5: Security
  final String password;
  final String confirmPassword;
  final String? idCardPhotoPath;

  const StudentRegistrationState({
    this.currentStep = 0,
    this.loadingState = LoadingState.initial,
    this.errorMessage,
    this.firstName = '',
    this.lastName = '',
    this.phone = '',
    this.email = '',
    this.gender = Gender.male,
    this.dateOfBirth,
    this.profilePhotoPath,
    this.isPhoneUnique = true,
    this.grades = const [],
    this.selectedGrade,
    this.schoolName = '',
    this.studyType = StudyType.online,
    this.centers = const [],
    this.selectedCenter,
    this.schedules = const [],
    this.selectedSchedule,
    this.groups = const [],
    this.selectedGroup,
    this.governorates = const [],
    this.selectedGovernorate,
    this.districts = const [],
    this.selectedDistrict,
    this.parentName = '',
    this.parentPhone = '',
    this.password = '',
    this.confirmPassword = '',
    this.idCardPhotoPath,
  });

  @override
  List<Object?> get props => [
    currentStep, loadingState, errorMessage,
    firstName, lastName, phone, email, gender, dateOfBirth, profilePhotoPath, isPhoneUnique,
    grades, selectedGrade, schoolName, studyType, centers, selectedCenter, schedules, selectedSchedule, groups, selectedGroup,
    governorates, selectedGovernorate, districts, selectedDistrict,
    parentName, parentPhone,
    password, confirmPassword, idCardPhotoPath,
  ];

  StudentRegistrationState copyWith({
    int? currentStep,
    LoadingState? loadingState,
    MentorXNullableValue<String?>? errorMessage,
    String? firstName,
    String? lastName,
    String? phone,
    String? email,
    Gender? gender,
    MentorXNullableValue<DateTime?>? dateOfBirth,
    MentorXNullableValue<String?>? profilePhotoPath,
    bool? isPhoneUnique,
    List<GradeEntity>? grades,
    MentorXNullableValue<GradeEntity?>? selectedGrade,
    String? schoolName,
    StudyType? studyType,
    List<CenterEntity>? centers,
    MentorXNullableValue<CenterEntity?>? selectedCenter,
    List<ScheduleEntity>? schedules,
    MentorXNullableValue<ScheduleEntity?>? selectedSchedule,
    List<GroupEntity>? groups,
    MentorXNullableValue<GroupEntity?>? selectedGroup,
    List<GovernorateEntity>? governorates,
    MentorXNullableValue<GovernorateEntity?>? selectedGovernorate,
    List<DistrictEntity>? districts,
    MentorXNullableValue<DistrictEntity?>? selectedDistrict,
    String? parentName,
    String? parentPhone,
    String? password,
    String? confirmPassword,
    MentorXNullableValue<String?>? idCardPhotoPath,
  }) {
    return StudentRegistrationState(
      currentStep: currentStep ?? this.currentStep,
      loadingState: loadingState ?? this.loadingState,
      errorMessage: errorMessage != null ? errorMessage.value : this.errorMessage,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth != null ? dateOfBirth.value : this.dateOfBirth,
      profilePhotoPath: profilePhotoPath != null ? profilePhotoPath.value : this.profilePhotoPath,
      isPhoneUnique: isPhoneUnique ?? this.isPhoneUnique,
      grades: grades ?? this.grades,
      selectedGrade: selectedGrade != null ? selectedGrade.value : this.selectedGrade,
      schoolName: schoolName ?? this.schoolName,
      studyType: studyType ?? this.studyType,
      centers: centers ?? this.centers,
      selectedCenter: selectedCenter != null ? selectedCenter.value : this.selectedCenter,
      schedules: schedules ?? this.schedules,
      selectedSchedule: selectedSchedule != null ? selectedSchedule.value : this.selectedSchedule,
      groups: groups ?? this.groups,
      selectedGroup: selectedGroup != null ? selectedGroup.value : this.selectedGroup,
      governorates: governorates ?? this.governorates,
      selectedGovernorate: selectedGovernorate != null ? selectedGovernorate.value : this.selectedGovernorate,
      districts: districts ?? this.districts,
      selectedDistrict: selectedDistrict != null ? selectedDistrict.value : this.selectedDistrict,
      parentName: parentName ?? this.parentName,
      parentPhone: parentPhone ?? this.parentPhone,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      idCardPhotoPath: idCardPhotoPath != null ? idCardPhotoPath.value : this.idCardPhotoPath,
    );
  }
}
