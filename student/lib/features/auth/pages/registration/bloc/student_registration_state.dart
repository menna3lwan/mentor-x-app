part of 'student_registration_bloc.dart';

final class StudentRegistrationState extends Equatable {
  final int currentStep;
  final LoadingState loadingState;
  final String? errorMessage;
  
  // Step 0: Initial Start
  final String firstName;
  final String phone;
  final String parentPhone;
  final bool isRegistrationStarted;
  
  // Step 1: OTP
  final String otp;
  
  // Step 2: Full Personal
  final String secondName;
  final String thirdName;
  final String fourthName;
  final String? profilePhotoPath;
  final bool isPhoneUnique;
  
  // Step 3: Academic
  final List<GradeEntity> grades;
  final GradeEntity? selectedGrade;
  final String schoolName;
  final bool isOnline;
  final String? centerName;
  final String educationDepartment;
  
  // Step 4: Location
  final List<GovernorateEntity> governorates;
  final GovernorateEntity? selectedGovernorate;
  final List<String> areas;
  final String? selectedArea;
  
  // Step 5: Security
  final String password;
  final String confirmPassword;
  final String? idCardPhotoPath;

  const StudentRegistrationState({
    this.currentStep = 0,
    this.loadingState = LoadingState.initial,
    this.errorMessage,
    this.firstName = '',
    this.phone = '',
    this.parentPhone = '',
    this.isRegistrationStarted = false,
    this.otp = '',
    this.secondName = '',
    this.thirdName = '',
    this.fourthName = '',
    this.profilePhotoPath,
    this.isPhoneUnique = true,
    this.grades = const [],
    this.selectedGrade,
    this.schoolName = '',
    this.isOnline = true,
    this.centerName,
    this.educationDepartment = '',
    this.governorates = const [],
    this.selectedGovernorate,
    this.areas = const [],
    this.selectedArea,
    this.password = '',
    this.confirmPassword = '',
    this.idCardPhotoPath,
  });

  @override
  List<Object?> get props => [
    currentStep, loadingState, errorMessage,
    firstName, phone, parentPhone, isRegistrationStarted,
    otp,
    secondName, thirdName, fourthName, profilePhotoPath, isPhoneUnique,
    grades, selectedGrade, schoolName, isOnline, centerName, educationDepartment,
    governorates, selectedGovernorate, areas, selectedArea,
    password, confirmPassword, idCardPhotoPath,
  ];

  StudentRegistrationState copyWith({
    int? currentStep,
    LoadingState? loadingState,
    MentorXNullableValue<String?>? errorMessage,
    String? firstName,
    String? phone,
    String? parentPhone,
    bool? isRegistrationStarted,
    String? otp,
    String? secondName,
    String? thirdName,
    String? fourthName,
    MentorXNullableValue<String?>? profilePhotoPath,
    bool? isPhoneUnique,
    List<GradeEntity>? grades,
    MentorXNullableValue<GradeEntity?>? selectedGrade,
    String? schoolName,
    bool? isOnline,
    MentorXNullableValue<String?>? centerName,
    String? educationDepartment,
    List<GovernorateEntity>? governorates,
    MentorXNullableValue<GovernorateEntity?>? selectedGovernorate,
    List<String>? areas,
    MentorXNullableValue<String?>? selectedArea,
    String? password,
    String? confirmPassword,
    MentorXNullableValue<String?>? idCardPhotoPath,
  }) {
    return StudentRegistrationState(
      currentStep: currentStep ?? this.currentStep,
      loadingState: loadingState ?? this.loadingState,
      errorMessage: errorMessage != null ? errorMessage.value : this.errorMessage,
      firstName: firstName ?? this.firstName,
      phone: phone ?? this.phone,
      parentPhone: parentPhone ?? this.parentPhone,
      isRegistrationStarted: isRegistrationStarted ?? this.isRegistrationStarted,
      otp: otp ?? this.otp,
      secondName: secondName ?? this.secondName,
      thirdName: thirdName ?? this.thirdName,
      fourthName: fourthName ?? this.fourthName,
      profilePhotoPath: profilePhotoPath != null ? profilePhotoPath.value : this.profilePhotoPath,
      isPhoneUnique: isPhoneUnique ?? this.isPhoneUnique,
      grades: grades ?? this.grades,
      selectedGrade: selectedGrade != null ? selectedGrade.value : this.selectedGrade,
      schoolName: schoolName ?? this.schoolName,
      isOnline: isOnline ?? this.isOnline,
      centerName: centerName != null ? centerName.value : this.centerName,
      educationDepartment: educationDepartment ?? this.educationDepartment,
      governorates: governorates ?? this.governorates,
      selectedGovernorate: selectedGovernorate != null ? selectedGovernorate.value : this.selectedGovernorate,
      areas: areas ?? this.areas,
      selectedArea: selectedArea != null ? selectedArea.value : this.selectedArea,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      idCardPhotoPath: idCardPhotoPath != null ? idCardPhotoPath.value : this.idCardPhotoPath,
    );
  }
}
