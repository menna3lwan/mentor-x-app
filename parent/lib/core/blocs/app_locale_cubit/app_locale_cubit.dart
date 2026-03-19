import 'package:bloc/bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';

import '../../../core/events/app_global_events.dart';

part 'app_locale_state.dart';

final class AppLocaleCubit extends Cubit<AppLocaleState> {
  final CacheRepository _cacheRepository;

  static final MentorXLogger _logger = MentorXLogger('AppLocaleCubit');

  AppLocaleCubit({
    required String initialLanguageCode,
    required CacheRepository cacheRepository,
  })  : _cacheRepository = cacheRepository,
        super(AppLocaleState(languageCode: initialLanguageCode));

  Future<void> setLocale(String languageCode) async {
    if (state.languageCode == languageCode) return;
    _logger.info('Changing locale to $languageCode');
    await _cacheRepository.put(CacheKeys.languageCode, languageCode);
    emit(AppLocaleState(languageCode: languageCode));
    appEventBus.fire(const AppRefreshEvent());
  }
}
