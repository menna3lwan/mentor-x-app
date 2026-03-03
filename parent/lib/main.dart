import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:parent/app/parent_app.dart';
import 'package:parent/app/initializers/repositories_factory.dart';
import 'package:parent/core/blocs/app_authentication_cubit/app_authentication_cubit.dart';
import 'package:parent/core/blocs/app_locale_cubit/app_locale_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Repositories
  final appRepos = await RepositoriesFactory.initRepositories();

  final initialUser = await appRepos.authenticationRepository.getCachedUser();

  runApp(
    MultiRepositoryProvider(
      providers: appRepos.toProviders(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                AppAuthenticationCubit(initialUser: initialUser),
          ),
          BlocProvider(
            create: (context) => AppLocaleCubit(
              initialLanguageCode: RepositoriesFactory.initialLanguageCode,
              cacheRepository: appRepos.cacheRepository,
            ),
          ),
        ],
        child: const ParentApp(),
      ),
    ),
  );
}
