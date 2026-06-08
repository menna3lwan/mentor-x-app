part of 'app_brightness_cubit.dart';

final class AppBrightnessState extends Equatable {
  final AppThemePreference preference;
  final Brightness systemBrightness;

  const AppBrightnessState({
    required this.preference,
    required this.systemBrightness,
  });

  /// The brightness the app should actually render with, given the
  /// preference + the current system brightness.
  Brightness get effectiveBrightness {
    return switch (preference) {
      AppThemePreference.light => Brightness.light,
      AppThemePreference.dark => Brightness.dark,
      AppThemePreference.system => systemBrightness,
    };
  }

  AppBrightnessState copyWith({
    AppThemePreference? preference,
    Brightness? systemBrightness,
  }) {
    return AppBrightnessState(
      preference: preference ?? this.preference,
      systemBrightness: systemBrightness ?? this.systemBrightness,
    );
  }

  @override
  List<Object?> get props => [preference, systemBrightness];
}
