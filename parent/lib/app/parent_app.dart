import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:push_notification_service/push_notification_service.dart';

import '../core/core.dart';
import '../features/push_notifications/push_notifications.dart';
import 'parent_requirements.dart';

// NOTE: the global `appEventBus` lives in `core/events/app_global_events.dart`.
// Importing from anywhere else previously created a second EventBus instance
// that silently swallowed every event — this declaration was removed to
// prevent that bug from ever returning.

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
        providers: [
          ...requirements.blocs.toProviders(),
          BlocProvider<NotificationsBadgeCubit>(
            create: (context) => NotificationsBadgeCubit(
              notificationRepository: context.read<NotificationRepository>(),
            )..load(),
          ),
          BlocProvider<PushNotificationsCubit>(
            // Bootstrap immediately so token discovery and stream wiring
            // run in parallel with the rest of the app startup.
            create: (context) => PushNotificationsCubit(
              service: context.read<PushNotificationService>(),
              notificationRepository: context.read<NotificationRepository>(),
            )..bootstrap(),
          ),
        ],
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

                    return PushNotificationAuthListener(
                      child: MaterialApp.router(
                        key: appKey,
                        // Use a simple app title string to avoid relying on
                        // a potentially missing generated translation getter.
                        title: 'MentorX Parent',
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
                        // Wrap every routed page with the banner listener so
                        // foreground pushes are surfaced regardless of which
                        // screen is on top.
                        builder: (context, child) {
                          if (child == null) return const SizedBox.shrink();
                          return PushNotificationBannerListener(
                            child: child,
                          );
                        },
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
