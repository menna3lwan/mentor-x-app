part of 'settings_list_page_bloc.dart';

sealed class SettingsListPageEvent extends Equatable {
  const SettingsListPageEvent();

  @override
  List<Object?> get props => [];
}

final class SettingsListPageLoadEvent extends SettingsListPageEvent {
  const SettingsListPageLoadEvent();
}
