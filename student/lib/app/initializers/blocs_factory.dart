import 'package:mentorx_core/mentorx_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/core.dart';

final class AppBlocs {
  final AppAuthenticationCubit appAuthenticationCubit;

  const AppBlocs._({
    required this.appAuthenticationCubit,
  });

  List<BlocProvider> toProviders() {
    return [
      BlocProvider<AppAuthenticationCubit>.value(value: appAuthenticationCubit),
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
    return AppBlocs._(
      appAuthenticationCubit: authenticationCubit,
    );
  }
}
