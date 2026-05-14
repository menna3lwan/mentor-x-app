part of 'edit_profile_page_bloc.dart';

sealed class EditProfilePageEvent extends Equatable {
  const EditProfilePageEvent();

  @override
  List<Object?> get props => [];
}

final class EditProfilePageLoadEvent extends EditProfilePageEvent {
  const EditProfilePageLoadEvent();
}

final class EditProfilePageSubmitRequestEvent extends EditProfilePageEvent {
  final String fieldName;
  final String oldValue;
  final String newValue;
  final String reason;

  const EditProfilePageSubmitRequestEvent({
    required this.fieldName,
    required this.oldValue,
    required this.newValue,
    required this.reason,
  });

  @override
  List<Object?> get props => [fieldName, oldValue, newValue, reason];
}
