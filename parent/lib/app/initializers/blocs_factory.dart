import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';

import '../../core/blocs/app_authentication_cubit/app_authentication_cubit.dart';
import '../../core/blocs/app_locale_cubit/app_locale_cubit.dart';
import 'repositories_factory.dart';

// ──────────────────────────────────────────────
// AppBlocs — Container for all app-level cubits.
// ──────────────────────────────────────────────

final class AppBlocs {
  final AppAuthenticationCubit appAuthenticationCubit;
  final AppLocaleCubit appLocaleCubit;

  const AppBlocs._({
    required this.appAuthenticationCubit,
    required this.appLocaleCubit,
  });

  /// Convert to [BlocProvider] list for [MultiBlocProvider].
  List<BlocProvider> toProviders() {
    return [
      BlocProvider<AppAuthenticationCubit>.value(
        value: appAuthenticationCubit,
      ),
      BlocProvider<AppLocaleCubit>.value(
        value: appLocaleCubit,
      ),
    ];
  }
}

// ──────────────────────────────────────────────
// BlocsFactory — Creates and wires all app-level cubits.
// ──────────────────────────────────────────────

final class BlocsFactory {
  BlocsFactory._();

  static final MentorXLogger _logger = MentorXLogger('BlocsFactory');

  static Future<AppBlocs> initBlocs({
    required ParentEntity? user,
    required String languageCode,
    required AppRepositories repositories,
    required List<LocalizedClient> localizedClients,
  }) async {
    _logger.info('Initializing app-level cubits...');

    final appAuthenticationCubit = AppAuthenticationCubit(initialUser: user);

    final appLocaleCubit = AppLocaleCubit(
      initialLanguageCode: languageCode,
      cacheRepository: repositories.cacheRepository,
      localizedClients: localizedClients,
    );

    _logger.info('App cubits initialized.');

    return AppBlocs._(
      appAuthenticationCubit: appAuthenticationCubit,
      appLocaleCubit: appLocaleCubit,
    );
  }
}
