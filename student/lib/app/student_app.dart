import 'dart:async';

import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:go_router/go_router.dart';

import 'app.dart';
import 'student_requirements.dart';
import '../core/core.dart';

final EventBus appEventBus = EventBus();
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final class StudentApp extends StatefulWidget {
  final StudentRequirements requirements;

  static final MentorXLogger _logger = MentorXLogger('StudentApp');

  const StudentApp({super.key, required this.requirements});

  @override
  State<StudentApp> createState() => _StudentAppState();
}

class _StudentAppState extends State<StudentApp> {
  late final StreamSubscription<AppAuthenticationLogoutEvent> _logoutSubscription;

  @override
  void initState() {
    super.initState();
    _logoutSubscription = appEventBus.on<AppAuthenticationLogoutEvent>().listen((event) {
      StudentApp._logger.info('Global auth event: Session cleared, redirecting to login');
      rootNavigatorKey.currentContext?.go('/login');
    });
  }

  @override
  void dispose() {
    _logoutSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final darkMixTheme = MentorXThemes.dark;
    final lightMixTheme = MentorXThemes.light;

    return MultiRepositoryProvider(
      providers: widget.requirements.repositories.toProviders(),
      child: MultiBlocProvider(
        providers: widget.requirements.blocs.toProviders(),
        child: MentorXTranslationProvider(
          child: MentorXThemeProvider(
            lightTheme: lightMixTheme,
            darkTheme: darkMixTheme,
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
                  supportedLocales: LocaleSettings.instance.supportedLocales,
                  localizationsDelegates: [
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
    );
  }
}
