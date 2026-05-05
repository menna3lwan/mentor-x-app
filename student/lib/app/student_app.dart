import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import 'app.dart';
import 'student_requirements.dart';

final EventBus appEventBus = EventBus();
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final class StudentApp extends StatelessWidget {
  final StudentRequirements requirements;

  const StudentApp({super.key, required this.requirements});

  @override
  Widget build(BuildContext context) {
    final darkMixTheme = MentorXThemes.dark;
    final lightMixTheme = MentorXThemes.light;

    return MultiRepositoryProvider(
      providers: requirements.repositories.toProviders(),
      child: MultiBlocProvider(
        providers: requirements.blocs.toProviders(),
        child: MentorXTranslationProvider(
          child: MentorXThemeProvider(
            // Do not uncomment the 'brightness' line below.
            // The dark theme is not yet supported.
            // brightness: requirements.brightness,
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
                  routerConfig: requirements.routerConfig,
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
