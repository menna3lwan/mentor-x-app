part of 'edit_profile_bloc.dart';

sealed class EditProfileEvent extends Equatable {
  const EditProfileEvent();

  @override
  List<Object?> get props => [];
}

final class EditProfileLoadEvent extends EditProfileEvent {
  const EditProfileLoadEvent();
}

final class EditProfileSubmitRequestEvent extends EditProfileEvent {
  final String fieldName;
  final String oldValue;
  final String newValue;
  final String reason;

  const EditProfileSubmitRequestEvent({
    required this.fieldName,
    required this.oldValue,
    required this.newValue,
    required this.reason,
  });

  @override
  List<Object?> get props => [fieldName, oldValue, newValue, reason];
}

final class EditProfileUpdateProfileEvent extends EditProfileEvent {
  final StudentEntity updatedUser;

  const EditProfileUpdateProfileEvent({
    required this.updatedUser,
  });

  @override
  List<Object?> get props => [updatedUser];
}
