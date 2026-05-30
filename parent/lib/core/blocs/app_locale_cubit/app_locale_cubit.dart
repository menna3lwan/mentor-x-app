import 'package:bloc/bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/localization/generated/strings.g.dart';

import '../../../core/events/app_global_events.dart';

part 'app_locale_state.dart';

final class AppLocaleCubit extends Cubit<AppLocaleState> {
  final CacheRepository _cacheRepository;
  final List<LocalizedClient> _localizedClients;

  static final MentorXLogger _logger = MentorXLogger('AppLocaleCubit');

  AppLocaleCubit({
    required String initialLanguageCode,
    required CacheRepository cacheRepository,
    List<LocalizedClient> localizedClients = const [],
  }) : _cacheRepository = cacheRepository,
       _localizedClients = localizedClients,
       super(AppLocaleState(languageCode: initialLanguageCode)) {
    // Initial sync
    LocaleSettings.setLocaleRaw(initialLanguageCode);
    for (final client in _localizedClients) {
      client.setLocale(initialLanguageCode);
    }
  }

  Future<void> setLocale(String languageCode) async {
    if (state.languageCode == languageCode) return;
    _logger.info('Changing locale to $languageCode');

    // 1. Cache
    await _cacheRepository.put(CacheKeys.languageCode, languageCode);

    // 2. i18n
    LocaleSettings.setLocaleRaw(languageCode);

    // 3. Clients
    for (final client in _localizedClients) {
      try {
        client.setLocale(languageCode);
      } catch (e, s) {
        _logger.error('Failed to update locale for client: $client', e, s);
      }
    }

    emit(AppLocaleState(languageCode: languageCode));
    appEventBus.fire(const AppRefreshEvent());
  }
}
