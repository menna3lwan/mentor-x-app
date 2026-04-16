part of 'parent_registration_bloc.dart';

sealed class ParentRegistrationEvent extends Equatable {
  const ParentRegistrationEvent();

  @override
  List<Object?> get props => [];
}

final class ParentRegistrationStepChanged extends ParentRegistrationEvent {
  final int step;

  const ParentRegistrationStepChanged({required this.step});

  @override
  List<Object?> get props => [step];
}

final class ParentRegistrationLookupTypeChanged
    extends ParentRegistrationEvent {
  final ParentLookupType lookupType;

  const ParentRegistrationLookupTypeChanged({required this.lookupType});

  @override
  List<Object?> get props => [lookupType];
}

final class ParentRegistrationLookupValueChanged
    extends ParentRegistrationEvent {
  final String value;

  const ParentRegistrationLookupValueChanged({required this.value});

  @override
  List<Object?> get props => [value];
}

final class ParentRegistrationFindStudentSubmitted
    extends ParentRegistrationEvent {
  const ParentRegistrationFindStudentSubmitted();
}

final class ParentRegistrationStudentConfirmed extends ParentRegistrationEvent {
  const ParentRegistrationStudentConfirmed();
}

final class ParentRegistrationFirstNameChanged extends ParentRegistrationEvent {
  final String value;

  const ParentRegistrationFirstNameChanged({required this.value});

  @override
  List<Object?> get props => [value];
}

final class ParentRegistrationLastNameChanged extends ParentRegistrationEvent {
  final String value;

  const ParentRegistrationLastNameChanged({required this.value});

  @override
  List<Object?> get props => [value];
}

final class ParentRegistrationPhoneChanged extends ParentRegistrationEvent {
  final String value;

  const ParentRegistrationPhoneChanged({required this.value});

  @override
  List<Object?> get props => [value];
}

final class ParentRegistrationEmailChanged extends ParentRegistrationEvent {
  final String value;

  const ParentRegistrationEmailChanged({required this.value});

  @override
  List<Object?> get props => [value];
}

final class ParentRegistrationRelationshipChanged
    extends ParentRegistrationEvent {
  final String value;

  const ParentRegistrationRelationshipChanged({required this.value});

  @override
  List<Object?> get props => [value];
}

final class ParentRegistrationPasswordChanged extends ParentRegistrationEvent {
  final String value;

  const ParentRegistrationPasswordChanged({required this.value});

  @override
  List<Object?> get props => [value];
}

final class ParentRegistrationConfirmPasswordChanged
    extends ParentRegistrationEvent {
  final String value;

  const ParentRegistrationConfirmPasswordChanged({required this.value});

  @override
  List<Object?> get props => [value];
}

final class ParentRegistrationNextStepRequested
    extends ParentRegistrationEvent {
  const ParentRegistrationNextStepRequested();
}

final class ParentRegistrationBackStepRequested
    extends ParentRegistrationEvent {
  const ParentRegistrationBackStepRequested();
}

final class ParentRegistrationSubmitted extends ParentRegistrationEvent {
  const ParentRegistrationSubmitted();
}
