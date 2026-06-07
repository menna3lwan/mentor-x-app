part of 'settings_list_bloc.dart';

sealed class SettingsListEvent extends Equatable {
  const SettingsListEvent();

  @override
  List<Object?> get props => [];
}

final class SettingsListLoadEvent extends SettingsListEvent {
  const SettingsListLoadEvent();
}
