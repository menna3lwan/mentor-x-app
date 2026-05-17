import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

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
                  ProfileTileWidget(
                    icon: Icons.palette_rounded,
                    label: t.profile.themeMode,
                    value: t.profile.themeSystem,
                    onTap: () {},
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
