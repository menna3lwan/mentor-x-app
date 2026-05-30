import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../core/blocs/app_brightness_cubit/app_brightness_cubit.dart';
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
      providers: [
        ...requirements.services.toProviders(),
        ...requirements.repositories.toProviders(),
      ],
      child: MultiBlocProvider(
        providers: requirements.blocs.toProviders(),
        child: MentorXTranslationProvider(
          // Re-build the theme provider tree when brightness changes so the
          // Mix theme (and any descendant tokens) flips between light/dark.
          child: BlocBuilder<AppBrightnessCubit, AppBrightnessState>(
            builder: (context, brightnessState) {
              final brightness = brightnessState.effectiveBrightness;

              return MentorXThemeProvider(
                brightness: brightness,
                lightTheme: lightMixTheme,
                darkTheme: darkMixTheme,
                child: Builder(
                  builder: (context) {
                    final String currentLanguageCode = TranslationProvider.of(
                      context,
                    ).flutterLocale.languageCode;
                    // Key includes brightness so MaterialApp rebuilds cleanly.
                    final appKey = ValueKey(
                      '$currentLanguageCode:${brightness.name}',
                    );

                    return MaterialApp.router(
                      key: appKey,
                      title: Translations.of(context).parent.app.title,
                      debugShowCheckedModeBanner: false,
                      routerConfig: requirements.routerConfig,
                      locale: TranslationProvider.of(context).flutterLocale,
                      supportedLocales:
                          LocaleSettings.instance.supportedLocales,
                      localizationsDelegates: const [
                        ...GlobalMaterialLocalizations.delegates,
                      ],
                      themeMode: brightness == Brightness.dark
                          ? ThemeMode.dark
                          : ThemeMode.light,
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
              );
            },
          ),
        ),
      ),
    );
  }
}
