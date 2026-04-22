import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import 'parent_requirements.dart';

final EventBus appEventBus = EventBus();

final class ParentApp extends StatelessWidget {
  final ParentRequirements requirements;

  const ParentApp({super.key, required this.requirements});

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
            // brightness: requirements.brightness,
            lightTheme: lightMixTheme,
            darkTheme: darkMixTheme,
            child: Builder(
              builder: (context) {
                final String currentLanguageCode = TranslationProvider.of(
                  context,
                ).flutterLocale.languageCode;
                final appKey = ValueKey(currentLanguageCode);
                
                return MaterialApp.router(
                  key: appKey,
                  title: 'MentorX Parent',
                  debugShowCheckedModeBanner: false,
                  routerConfig: requirements.routerConfig,
                  locale: TranslationProvider.of(context).flutterLocale,
                  supportedLocales: LocaleSettings.instance.supportedLocales,
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
    );
  }
}
