import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../../../core/blocs/app_brightness_cubit/app_brightness_cubit.dart';
import '../../../core/blocs/app_locale_cubit/app_locale_cubit.dart';
import '../widgets/widgets.dart';

/// Configurable app preferences for the parent — push notifications,
/// theme mode, language, help links. Language is wired through the existing
/// [AppLocaleCubit].
class SettingsParentPage extends StatefulWidget {
  const SettingsParentPage({super.key});

  @override
  State<SettingsParentPage> createState() => _SettingsParentPageState();
}

class _SettingsParentPageState extends State<SettingsParentPage> {
  bool _pushNotifications = true;

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
              ProfileToggleTileWidget(
                icon: Icons.notifications_active_rounded,
                label: t.profile.pushNotifications,
                value: _pushNotifications,
                onChanged: (val) =>
                    setState(() => _pushNotifications = val),
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
            title: t.profile.supportSection,
            children: [
              ProfileTileWidget(
                icon: Icons.help_outline_rounded,
                label: t.profile.helpCenter,
                value: t.profile.helpCenterValue,
                onTap: () {},
              ),
              ProfileTileWidget(
                icon: Icons.info_outline_rounded,
                label: t.profile.aboutTitle,
                value: t.profile.aboutVersion(version: '1.0.0'),
                onTap: () {},
              ),
            ],
          ),
          const Gap(40),
        ],
      ),
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
                  onTap: () =>
                      Navigator.of(ctx).pop(AppThemePreference.system),
                ),
                _ThemeOption(
                  label: t.profile.themeLight,
                  icon: Icons.light_mode_rounded,
                  isSelected: current == AppThemePreference.light,
                  onTap: () =>
                      Navigator.of(ctx).pop(AppThemePreference.light),
                ),
                _ThemeOption(
                  label: t.profile.themeDark,
                  icon: Icons.dark_mode_rounded,
                  isSelected: current == AppThemePreference.dark,
                  onTap: () =>
                      Navigator.of(ctx).pop(AppThemePreference.dark),
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
