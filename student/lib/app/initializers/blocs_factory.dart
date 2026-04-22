import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/core.dart';
import '../../features/products/cubit/cart_cubit.dart';

final class AppBlocs {
  final AppAuthenticationCubit appAuthenticationCubit;
  final AppSessionCubit appSessionCubit;
  final AppLocaleCubit appLocaleCubit;
  final CartCubit cartCubit;

  const AppBlocs._({
    required this.appAuthenticationCubit,
    required this.appSessionCubit,
    required this.appLocaleCubit,
    required this.cartCubit,
  });

  List<BlocProvider> toProviders() {
    return [
      BlocProvider<AppAuthenticationCubit>.value(value: appAuthenticationCubit),
      BlocProvider<AppSessionCubit>.value(value: appSessionCubit),
      BlocProvider<AppLocaleCubit>.value(value: appLocaleCubit),
      BlocProvider<CartCubit>.value(value: cartCubit),
    ];
  }
}

final class BlocsFactory {
  BlocsFactory._();

  static Future<AppBlocs> initBlocs({
    required StudentEntity? user,
    required String languageCode,
    required Brightness brightness,
    required CacheRepository cacheRepository,
    required List<LocalizedClient> localizedClients,
  }) async {
    final authenticationCubit = AppAuthenticationCubit(initialUser: user);
    final sessionCubit = AppSessionCubit();
    final localeCubit = AppLocaleCubit(
      initialLanguageCode: languageCode,
      cacheRepository: cacheRepository,
      localizedClients: localizedClients,
    );
    final cartCubit = CartCubit();

    return AppBlocs._(
      appAuthenticationCubit: authenticationCubit,
      appSessionCubit: sessionCubit,
      appLocaleCubit: localeCubit,
      cartCubit: cartCubit,
    );
  }
}
