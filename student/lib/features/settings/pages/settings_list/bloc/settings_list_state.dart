part of 'settings_list_bloc.dart';

final class SettingsListState extends Equatable {
  final LoadingState loadingState;

  const SettingsListState({
    this.loadingState = LoadingState.initial,
  });

  static const initial = SettingsListState();

  @override
  List<Object?> get props => [loadingState];

  SettingsListState copyWith({LoadingState? loadingState}) {
    return SettingsListState(
      loadingState: loadingState ?? this.loadingState,
    );
  }
}
