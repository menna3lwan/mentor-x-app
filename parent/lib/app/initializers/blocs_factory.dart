import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/core.dart';

final class AppBlocs {
  final AppAuthenticationCubit appAuthenticationCubit;
  final AppLocaleCubit appLocaleCubit;
  final AppBrightnessCubit appBrightnessCubit;

  const AppBlocs._({
    required this.appAuthenticationCubit,
    required this.appLocaleCubit,
    required this.appBrightnessCubit,
  });

  List<BlocProvider> toProviders() {
    return [
      BlocProvider<AppAuthenticationCubit>.value(value: appAuthenticationCubit),
      BlocProvider<AppLocaleCubit>.value(value: appLocaleCubit),
      BlocProvider<AppBrightnessCubit>.value(value: appBrightnessCubit),
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
    final preference = await AppBrightnessCubit.readCachedPreference(
      cacheRepository,
    );
    final brightnessCubit = AppBrightnessCubit(
      cacheRepository: cacheRepository,
      initialPreference: preference,
      systemBrightness: PlatformDispatcher.instance.platformBrightness,
    );

    return AppBlocs._(
      appAuthenticationCubit: authenticationCubit,
      appLocaleCubit: localeCubit,
      appBrightnessCubit: brightnessCubit,
    );
  }
}
