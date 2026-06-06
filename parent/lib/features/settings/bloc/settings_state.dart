part of 'settings_cubit.dart';

final class SettingsState extends Equatable {
  final bool pushNotificationsEnabled;
  final bool isHydrated;

  const SettingsState({
    required this.pushNotificationsEnabled,
    required this.isHydrated,
  });

  factory SettingsState.initial() => const SettingsState(
    pushNotificationsEnabled: true,
    isHydrated: false,
  );

  SettingsState copyWith({bool? pushNotificationsEnabled, bool? isHydrated}) {
    return SettingsState(
      pushNotificationsEnabled:
          pushNotificationsEnabled ?? this.pushNotificationsEnabled,
      isHydrated: isHydrated ?? this.isHydrated,
    );
  }

  @override
  List<Object?> get props => [pushNotificationsEnabled, isHydrated];
}
