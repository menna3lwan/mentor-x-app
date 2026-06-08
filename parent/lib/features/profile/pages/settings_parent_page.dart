import 'package:device_info_service/device_info_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/blocs/app_brightness_cubit/app_brightness_cubit.dart';
import '../../../core/blocs/app_locale_cubit/app_locale_cubit.dart';
import '../../../core/routing/app_routes.dart';
import '../../push_notifications/push_notifications.dart';
import '../../settings/bloc/settings_cubit.dart';
import '../widgets/widgets.dart';

/// Configurable app preferences for the parent — push notifications,
/// theme mode, language, help links. Language is wired through the existing
/// [AppLocaleCubit].
class SettingsParentPage extends StatelessWidget {
  const SettingsParentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SettingsCubit(
        cacheRepository: context.read<CacheRepository>(),
      ),
      child: const _SettingsView(),
    );
  }
}

class _SettingsView extends StatefulWidget {
  const _SettingsView();

  @override
  State<_SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<_SettingsView> {
  String _appVersion = '0.0.1';

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    final version = await context.read<DeviceInfoService>().getAppVersion();
    if (mounted) setState(() => _appVersion = version);
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;

    return AppDashboardScaffold(
      title: t.profile.settingsTitle,
      body: ListView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: [
          ProfileSection(
            title: t.profile.appConfigurationSection,
            children: [
              BlocBuilder<SettingsCubit, SettingsState>(
                buildWhen: (a, b) =>
                    a.pushNotificationsEnabled !=
                    b.pushNotificationsEnabled,
                builder: (context, state) {
                  return ProfileToggleTileWidget(
                    icon: Icons.notifications_active_rounded,
                    label: t.profile.pushNotifications,
                    value: state.pushNotificationsEnabled,
                    onChanged: (val) => _togglePushNotifications(context, val),
                  );
                },
              ),
            ],
          ),
          const Gap(24),
          BlocBuilder<AppLocaleCubit, AppLocaleState>(
            buildWhen: (a, b) => a.languageCode != b.languageCode,
            builder: (context, localeState) {
              final isArabic = localeState.languageCode == 'ar';
              return ProfileSection(
                title: t.profile.preferencesSection,
                children: [
                  BlocBuilder<AppBrightnessCubit, AppBrightnessState>(
                    buildWhen: (a, b) => a.preference != b.preference,
                    builder: (context, brightnessState) {
                      return ProfileTileWidget(
                        icon: Icons.palette_rounded,
                        label: t.profile.themeMode,
                        value: _themeLabel(t, brightnessState.preference),
                        onTap: () => _openThemePicker(
                          context,
                          t,
                          brightnessState.preference,
                        ),
                      );
                    },
                  ),
                  ProfileTileWidget(
                    icon: Icons.language_rounded,
                    label: t.profile.appLanguage,
                    value: isArabic
                        ? t.profile.languageArabic
                        : t.profile.languageEnglish,
                    onTap: () => _openLanguagePicker(context, t, isArabic),
                  ),
                ],
              );
            },
          ),
          const Gap(24),
          ProfileSection(
            title: t.security,
            children: [
              ProfileTileWidget(
                icon: Icons.lock_reset_rounded,
                label: t.profile.changePasswordTitle,
                value: t.profile.securityChangePassword,
                onTap: () => const ChangePasswordRoute().go(context),
              ),
              ProfileTileWidget(
                icon: Icons.devices_rounded,
                label: t.devices.pageTitle,
                value: t.devices.settingsSubtitle,
                onTap: () => const DevicesRoute().go(context),
              ),
              ProfileTileWidget(
                icon: Icons.delete_forever_rounded,
                label: t.deleteAccount.settingsTileLabel,
                value: t.deleteAccount.settingsTileSubtitle,
                onTap: () => const DeleteAccountRoute().go(context),
              ),
            ],
          ),
          const Gap(24),
          ProfileSection(
            title: t.profile.supportSection,
            children: [
              ProfileTileWidget(
                icon: Icons.help_outline_rounded,
                label: t.profile.helpCenter,
                value: t.profile.helpCenterValue,
                onTap: () => _openHelpCenter(context, t),
              ),
              ProfileTileWidget(
                icon: Icons.info_outline_rounded,
                label: t.profile.aboutTitle,
                value: t.profile.aboutVersion(
                  version: _appVersion.isEmpty ? '...' : _appVersion,
                ),
                onTap: () => _openAbout(context, t),
              ),
            ],
          ),
          const Gap(40),
        ],
      ),
    );
  }

  /// Bridges the Settings toggle to the [PushNotificationsCubit]:
  /// - turning ON requests system permission and registers the token,
  /// - turning OFF unregisters the device.
  /// Persistence happens via [SettingsCubit] in both cases.
  Future<void> _togglePushNotifications(
    BuildContext context,
    bool enabled,
  ) async {
    final t = Translations.of(context).parent;
    final settings = context.read<SettingsCubit>();
    final push = context.read<PushNotificationsCubit>();

    // Optimistic UI: persist the toggle immediately so the switch animates
    // and the choice survives even if the permission prompt is cancelled.
    await settings.setPushNotificationsEnabled(enabled);
    if (!enabled) {
      await push.disable();
      return;
    }
    final permission = await push.enable();
    if (!context.mounted) return;
    if (!permission.isGranted) {
      // Roll the toggle back if the user denied the system prompt so the
      // UI stays in sync with reality.
      await settings.setPushNotificationsEnabled(false);
      if (!context.mounted) return;
      MentorXUI.showToast(
        message: t.pushNotifications.permissionDeniedMessage,
        isError: true,
      );
    }
  }

  Future<void> _openHelpCenter(
    BuildContext context,
    TranslationsParentEn t,
  ) async {
    final uri = Uri.tryParse(t.profile.settingsHelpUrl);
    if (uri == null) return;
    final canOpen = await canLaunchUrl(uri);
    if (!context.mounted) return;
    if (!canOpen) {
      MentorXUI.showToast(message: t.unableToLoad, isError: true);
      return;
    }
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _openAbout(
    BuildContext context,
    TranslationsParentEn t,
  ) async {
    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: dialogContext.backgroundSecondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: Text(t.profile.settingsAboutTitle),
          content: Text(
            t.profile.settingsAboutBody(
              version: _appVersion.isEmpty ? '...' : _appVersion,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(),
              child: Text(t.profile.signOutCancel),
            ),
          ],
        );
      },
    );
  }

  String _themeLabel(TranslationsParentEn t, AppThemePreference pref) {
    return switch (pref) {
      AppThemePreference.system => t.profile.themeSystem,
      AppThemePreference.light => t.profile.themeLight,
      AppThemePreference.dark => t.profile.themeDark,
    };
  }

  Future<void> _openThemePicker(
    BuildContext context,
    TranslationsParentEn t,
    AppThemePreference current,
  ) async {
    final cubit = context.read<AppBrightnessCubit>();
    final selected = await showModalBottomSheet<AppThemePreference>(
      context: context,
      backgroundColor: context.backgroundSecondaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: ctx.textTertiaryColor.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const Gap(16),
                _ThemeOption(
                  label: t.profile.themeSystem,
                  icon: Icons.brightness_auto_rounded,
                  isSelected: current == AppThemePreference.system,
                  onTap: () => Navigator.of(ctx).pop(AppThemePreference.system),
                ),
                _ThemeOption(
                  label: t.profile.themeLight,
                  icon: Icons.light_mode_rounded,
                  isSelected: current == AppThemePreference.light,
                  onTap: () => Navigator.of(ctx).pop(AppThemePreference.light),
                ),
                _ThemeOption(
                  label: t.profile.themeDark,
                  icon: Icons.dark_mode_rounded,
                  isSelected: current == AppThemePreference.dark,
                  onTap: () => Navigator.of(ctx).pop(AppThemePreference.dark),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (selected != null && selected != current) {
      await cubit.setPreference(selected);
    }
  }

  Future<void> _openLanguagePicker(
    BuildContext context,
    TranslationsParentEn t,
    bool isArabic,
  ) async {
    final cubit = context.read<AppLocaleCubit>();
    final selected = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: context.backgroundSecondaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: ctx.textTertiaryColor.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const Gap(16),
                _LanguageOption(
                  label: t.profile.languageEnglish,
                  code: 'en',
                  isSelected: !isArabic,
                  onTap: () => Navigator.of(ctx).pop('en'),
                ),
                _LanguageOption(
                  label: t.profile.languageArabic,
                  code: 'ar',
                  isSelected: isArabic,
                  onTap: () => Navigator.of(ctx).pop('ar'),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (selected != null && selected != cubit.state.languageCode) {
      await cubit.setLocale(selected);
    }
  }
}

class _ThemeOption extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _ThemeOption({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: context.brandPrimaryColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: context.brandPrimaryColor, size: 20),
      ),
      title: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w800,
          color: context.textPrimaryColor,
        ),
      ),
      trailing: isSelected
          ? Icon(
              Icons.check_circle_rounded,
              color: context.brandPrimaryColor,
            )
          : null,
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String label;
  final String code;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.label,
    required this.code,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: context.brandPrimaryColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          code.toUpperCase(),
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w900,
            color: context.brandPrimaryColor,
          ),
        ),
      ),
      title: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w800,
          color: context.textPrimaryColor,
        ),
      ),
      trailing: isSelected
          ? Icon(
              Icons.check_circle_rounded,
              color: context.brandPrimaryColor,
            )
          : null,
    );
  }
}
