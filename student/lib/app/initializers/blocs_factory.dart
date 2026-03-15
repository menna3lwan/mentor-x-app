import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/core.dart';

final class AppBlocs {
  final AppAuthenticationCubit appAuthenticationCubit;
  final AppSessionCubit appSessionCubit;

  const AppBlocs._({
    required this.appAuthenticationCubit,
    required this.appSessionCubit,
  });

  List<BlocProvider> toProviders() {
    return [
      BlocProvider<AppAuthenticationCubit>.value(value: appAuthenticationCubit),
      BlocProvider<AppSessionCubit>.value(value: appSessionCubit),
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
  }) async {
    final authenticationCubit = AppAuthenticationCubit(initialUser: user);
    final sessionCubit = AppSessionCubit();
    return AppBlocs._(
      appAuthenticationCubit: authenticationCubit,
      appSessionCubit: sessionCubit,
    );
  }
}
