part of 'parent_registration_bloc.dart';

enum ParentRegistrationLoadingState {
  initial,
  loading,
  loaded,
  failure
  ;

  bool get isLoading => this == ParentRegistrationLoadingState.loading;
}

final class ParentRegistrationState extends Equatable {
  final ParentRegistrationLoadingState loadingState;
  final int currentStep;
  final ParentLookupType lookupType;
  final String lookupValue;
  final ParentStudentLookupEntity? foundStudent;
  final bool isStudentConfirmed;

  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String relationship;
  final String password;
  final String confirmPassword;

  const ParentRegistrationState({
    this.loadingState = ParentRegistrationLoadingState.initial,
    this.currentStep = 0,
    this.lookupType = ParentLookupType.phone,
    this.lookupValue = '',
    this.foundStudent,
    this.isStudentConfirmed = false,
    this.firstName = '',
    this.lastName = '',
    this.phone = '',
    this.email = '',
    this.relationship = '',
    this.password = '',
    this.confirmPassword = '',
  });

  ParentRegistrationState copyWith({
    ParentRegistrationLoadingState? loadingState,
    int? currentStep,
    ParentLookupType? lookupType,
    String? lookupValue,
    MentorXNullableValue<ParentStudentLookupEntity?>? foundStudent,
    bool? isStudentConfirmed,
    String? firstName,
    String? lastName,
    String? phone,
    String? email,
    String? relationship,
    String? password,
    String? confirmPassword,
  }) {
    return ParentRegistrationState(
      loadingState: loadingState ?? this.loadingState,
      currentStep: currentStep ?? this.currentStep,
      lookupType: lookupType ?? this.lookupType,
      lookupValue: lookupValue ?? this.lookupValue,
      foundStudent: foundStudent != null
          ? foundStudent.value
          : this.foundStudent,
      isStudentConfirmed: isStudentConfirmed ?? this.isStudentConfirmed,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      relationship: relationship ?? this.relationship,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }

  @override
  List<Object?> get props => [
    loadingState,
    currentStep,
    lookupType,
    lookupValue,
    foundStudent,
    isStudentConfirmed,
    firstName,
    lastName,
    phone,
    email,
    relationship,
    password,
    confirmPassword,
  ];
}
