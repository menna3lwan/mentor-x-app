import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:mentorx_core/mentorx_core.dart';

import '../../events/app_global_events.dart';

part 'app_brightness_state.dart';

/// Tri-state theme preference: follow the system, force light, or force dark.
enum AppThemePreference { system, light, dark }

/// Holds the current theme preference + the resolved [Brightness] used by
/// [MentorXThemeProvider]. Persists the preference under [_kCacheKey] so it
/// survives app restarts.
final class AppBrightnessCubit extends Cubit<AppBrightnessState> {
  static const String _kCacheKey = 'theme_preference';

  static final MentorXLogger _logger = MentorXLogger('AppBrightnessCubit');

  final CacheRepository _cacheRepository;

  AppBrightnessCubit({
    required CacheRepository cacheRepository,
    required AppThemePreference initialPreference,
    required Brightness systemBrightness,
  }) : _cacheRepository = cacheRepository,
       super(
         AppBrightnessState(
           preference: initialPreference,
           systemBrightness: systemBrightness,
         ),
       );

  /// The brightness MaterialApp should render with.
  Brightness get effectiveBrightness => state.effectiveBrightness;

  /// Updates the user's preference, persists it, and emits a refresh event
  /// so widgets re-evaluate.
  Future<void> setPreference(AppThemePreference preference) async {
    if (state.preference == preference) return;
    _logger.info('Theme preference changed to ${preference.name}');

    await _cacheRepository.put(_kCacheKey, preference.name);

    emit(state.copyWith(preference: preference));
    appEventBus.fire(const AppRefreshEvent());
  }

  /// Called when the OS-level brightness flips (e.g. user enabled dark mode
  /// in system settings). Only meaningful when [preference] is `system`.
  void updateSystemBrightness(Brightness brightness) {
    if (state.systemBrightness == brightness) return;
    emit(state.copyWith(systemBrightness: brightness));
  }

  /// Reads the cached preference. Falls back to `system` when missing.
  static Future<AppThemePreference> readCachedPreference(
    CacheRepository cacheRepository,
  ) async {
    final raw = await cacheRepository.get(_kCacheKey);
    if (raw == null) return AppThemePreference.system;
    return AppThemePreference.values.firstWhere(
      (e) => e.name == raw,
      orElse: () => AppThemePreference.system,
    );
  }
}
