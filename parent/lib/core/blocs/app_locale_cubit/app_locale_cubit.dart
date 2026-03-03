import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:parent/core/events/app_global_events.dart';

part 'app_locale_state.dart';

final class AppLocaleCubit extends Cubit<AppLocaleState> {
  final CacheRepository _cacheRepository;

  AppLocaleCubit({
    required String initialLanguageCode,
    required CacheRepository cacheRepository,
  })  : _cacheRepository = cacheRepository,
        super(AppLocaleState(languageCode: initialLanguageCode));

  Future<void> setLocale(String languageCode) async {
    await _cacheRepository.put('language_code', languageCode);
    emit(AppLocaleState(languageCode: languageCode));
    appEventBus.fire(const AppRefreshEvent());
  }
}
