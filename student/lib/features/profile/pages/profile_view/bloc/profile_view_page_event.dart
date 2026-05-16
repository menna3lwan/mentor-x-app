part of 'profile_view_page_bloc.dart';

sealed class ProfileViewPageEvent extends Equatable {
  const ProfileViewPageEvent();

  @override
  List<Object?> get props => [];
}

final class ProfileViewPageLoadEvent extends ProfileViewPageEvent {
  const ProfileViewPageLoadEvent();
}
