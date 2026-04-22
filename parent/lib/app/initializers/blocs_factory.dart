import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/core.dart';

final class AppBlocs {
  final AppAuthenticationCubit appAuthenticationCubit;
  final AppLocaleCubit appLocaleCubit;

  const AppBlocs._({
    required this.appAuthenticationCubit,
    required this.appLocaleCubit,
  });

  List<BlocProvider> toProviders() {
    return [
      BlocProvider<AppAuthenticationCubit>.value(value: appAuthenticationCubit),
      BlocProvider<AppLocaleCubit>.value(value: appLocaleCubit),
    ];
  }
}

final class BlocsFactory {
  BlocsFactory._();

  static Future<AppBlocs> initBlocs({
    required ParentEntity? user,
    required String languageCode,
    required CacheRepository cacheRepository,
    required List<LocalizedClient> localizedClients,
  }) async {
    final authenticationCubit = AppAuthenticationCubit(initialUser: user);
    final localeCubit = AppLocaleCubit(
      initialLanguageCode: languageCode,
      cacheRepository: cacheRepository,
      localizedClients: localizedClients,
    );

    return AppBlocs._(
      appAuthenticationCubit: authenticationCubit,
      appLocaleCubit: localeCubit,
    );
  }
}
