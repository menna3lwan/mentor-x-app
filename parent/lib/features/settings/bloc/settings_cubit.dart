import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mentorx_core/mentorx_core.dart';

import '../../../core/utils/parent_cache_keys.dart';

part 'settings_state.dart';

/// Persists user-controlled app preferences (push toggle, future flags).
///
/// Theme + Locale already have dedicated cubits at the app level — this
/// cubit only owns the settings that don't have a natural home elsewhere.
/// Push state is stored as a string ("true"/"false") to match the existing
/// [CacheRepository] string-only API.
final class SettingsCubit extends Cubit<SettingsState> {
  final CacheRepository _cacheRepository;

  static final MentorXLogger _logger = MentorXLogger('SettingsCubit');

  SettingsCubit({required CacheRepository cacheRepository})
    : _cacheRepository = cacheRepository,
      super(SettingsState.initial()) {
    _hydrate();
  }

  Future<void> _hydrate() async {
    try {
      final raw = await _cacheRepository.get(
        ParentCacheKeys.pushNotificationsEnabled,
      );
      // Defaults to true so first-launch behaviour mirrors expectations.
      final isOn = raw == null ? true : raw.toLowerCase() == 'true';
      emit(state.copyWith(pushNotificationsEnabled: isOn, isHydrated: true));
    } catch (e, s) {
      _logger.error('Failed to hydrate settings: $e', e, s);
      emit(state.copyWith(isHydrated: true));
    }
  }

  Future<void> setPushNotificationsEnabled(bool enabled) async {
    emit(state.copyWith(pushNotificationsEnabled: enabled));
    try {
      await _cacheRepository.put(
        ParentCacheKeys.pushNotificationsEnabled,
        enabled.toString(),
      );
    } catch (e, s) {
      _logger.error('Failed to persist push toggle: $e', e, s);
    }
  }
}
