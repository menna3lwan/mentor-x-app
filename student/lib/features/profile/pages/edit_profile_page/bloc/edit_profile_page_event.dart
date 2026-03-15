part of 'edit_profile_page_bloc.dart';

sealed class EditProfilePageEvent extends Equatable {
  const EditProfilePageEvent();

  @override
  List<Object?> get props => [];
}

final class EditProfilePageLoadEvent extends EditProfilePageEvent {
  const EditProfilePageLoadEvent();
}
