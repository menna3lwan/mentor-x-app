import 'dart:async';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mentorx_ui/mentorx_ui.dart'
    hide LocaleSettings, TranslationProvider;
import 'package:go_router/go_router.dart';

import 'app.dart';
import 'student_requirements.dart';
import 'package:mentorx_student/core/core.dart';

final EventBus appEventBus = EventBus();
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final class StudentApp extends StatefulWidget {
  final StudentRequirements requirements;

  static final MentorXLogger _logger = MentorXLogger('StudentApp');

  const StudentApp({super.key, required this.requirements});

  @override
  State<StudentApp> createState() => _StudentAppState();
}

class _StudentAppState extends State<StudentApp> with WidgetsBindingObserver {
  late final StreamSubscription<AppAuthenticationLogoutEvent>
  _logoutSubscription;
  late final StreamSubscription<AppAuthenticationUpdateEvent>
  _updateSubscription;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _logoutSubscription = appEventBus.on<AppAuthenticationLogoutEvent>().listen(
      (event) {
        StudentApp._logger.info(
          'Global auth event: Session cleared, redirecting to login',
        );
        rootNavigatorKey.currentContext?.go('/login');
      },
    );

    _updateSubscription = appEventBus.on<AppAuthenticationUpdateEvent>().listen(
      (event) {
        final user = event.user;
        if (user != null) {
          final context = rootNavigatorKey.currentContext;
          if (context != null && context.mounted) {
            StudentApp._logger.info(
              'Global auth update: User status is ${user.status}, resolving redirection',
            );
            switch (user.status) {
              case StudentStatus.active:
                break;
              case StudentStatus.pending:
                context.go('/status-pending');
              case StudentStatus.suspended:
                context.go('/status-blocked');
              case StudentStatus.rejected:
              case StudentStatus.inactive:
                context.go('/status-rejected');
            }
          }
        }
      },
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _logoutSubscription.cancel();
    _updateSubscription.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _checkAccountStatus();
    }
  }

  Future<void> _checkAccountStatus() async {
    final context = rootNavigatorKey.currentContext;
    if (context == null) return;

    try {
      final authCubit = context.read<AppAuthenticationCubit>();
      if (authCubit.state != null) {
        final authRepo = context.read<StudentAuthenticationRepository>();
        StudentApp._logger.info('App resumed: Checking latest account status from backend');
        final updatedUser = await authRepo.getAccountStatus();
        appEventBus.fire(AppAuthenticationUpdateEvent(user: updatedUser));
      }
    } catch (e, s) {
      StudentApp._logger.error('Failed to verify account status on resume', e, s);
    }
  }

  @override
  Widget build(BuildContext context) {
    final darkMixTheme = MentorXThemes.dark;
    final lightMixTheme = MentorXThemes.light;

    return MultiRepositoryProvider(
      providers: widget.requirements.repositories.toProviders(),
      child: MultiBlocProvider(
        providers: widget.requirements.blocs.toProviders(),
        child: TranslationProvider(
          child: MentorXTranslationProvider(
            child: MentorXThemeProvider(
              lightTheme: lightMixTheme,
              darkTheme: darkMixTheme,
              child: MentorXSkeletonProvider(
                child: Builder(
                  builder: (context) {
                    // This key is used to force the app to rebuild when the locale changes
                    final String currentLanguageCode = TranslationProvider.of(
                      context,
                    ).flutterLocale.languageCode;
                    final appKey = ValueKey(currentLanguageCode);
                    return MaterialApp.router(
                      key: appKey,
                      debugShowCheckedModeBanner: false,
                      routerConfig: widget.requirements.routerConfig,
                      locale: TranslationProvider.of(context).flutterLocale,
                      supportedLocales:
                          LocaleSettings.instance.supportedLocales,
                      localizationsDelegates: const [
                        ...GlobalMaterialLocalizations.delegates,
                      ],
                      theme: MentorXThemes.materialThemeDataFromTheme(
                        lightMixTheme,
                        context,
                      ),
                      darkTheme: MentorXThemes.materialThemeDataFromTheme(
                        darkMixTheme,
                        context,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
