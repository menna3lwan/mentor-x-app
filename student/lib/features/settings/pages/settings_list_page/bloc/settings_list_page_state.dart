part of 'settings_list_page_bloc.dart';

final class SettingsListPageState extends Equatable {
  final LoadingState loadingState;

  const SettingsListPageState({
    this.loadingState = LoadingState.initial,
  });

  static const initial = SettingsListPageState();

  @override
  List<Object?> get props => [loadingState];

  SettingsListPageState copyWith({LoadingState? loadingState}) {
    return SettingsListPageState(
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
