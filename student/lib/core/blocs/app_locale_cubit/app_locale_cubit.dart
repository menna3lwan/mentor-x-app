import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/localization/generated/strings.g.dart';

part 'app_locale_state.dart';

final class AppLocaleCubit extends Cubit<AppLocaleState> {
  AppLocaleCubit({
    required String initialLanguageCode,
    required CacheRepository cacheRepository,
    List<LocalizedClient> localizedClients = const [],
  }) : _cacheRepository = cacheRepository,
       _localizedClients = localizedClients,
       super(AppLocaleState(languageCode: initialLanguageCode)) {
    // Ensure all clients are initialized with the starting locale.
    for (final client in _localizedClients) {
      client.setLocale(initialLanguageCode);
    }
  }

  final CacheRepository _cacheRepository;
  final List<LocalizedClient> _localizedClients;

  static final MentorXLogger _logger = MentorXLogger('AppLocaleCubit');

  /// Updates the application language.
  Future<void> setLocale(String languageCode) async {
    if (state.languageCode == languageCode) return;

    _logger.info('Changing app language to: $languageCode');

    // 1. Persist to cache
    await _cacheRepository.put(CacheKeys.languageCode, languageCode);

    // 2. Update i18n
    LocaleSettings.setLocaleRaw(languageCode);

    // 3. Update localized clients (e.g. HttpClients)
    for (final client in _localizedClients) {
      try {
        client.setLocale(languageCode);
      } catch (e, s) {
        _logger.error('Failed to update locale for client: $client', e, s);
      }
    }

    // 4. Update state to trigger UI rebuild
    emit(AppLocaleState(languageCode: languageCode));
  }
}
