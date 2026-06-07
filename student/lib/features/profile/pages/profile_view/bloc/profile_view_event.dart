part of 'profile_view_bloc.dart';

sealed class ProfileViewEvent extends Equatable {
  const ProfileViewEvent();

  @override
  List<Object?> get props => [];
}

final class ProfileViewLoadEvent extends ProfileViewEvent {
  const ProfileViewLoadEvent();
}
