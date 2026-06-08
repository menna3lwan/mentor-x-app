import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mix/mix.dart';

import '../../../core/blocs/app_authentication_cubit/app_authentication_cubit.dart';
import '../../../core/routing/app_routes.dart';
import '../widgets/widgets.dart';

/// Read-only profile surface for the currently authenticated parent. Pulls
/// user data straight from [AppAuthenticationCubit] — no separate fetch
/// needed because the cubit is already the source of truth.
class ParentProfilePage extends StatelessWidget {
  const ParentProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;

    return AppDashboardScaffold(
      title: t.myProfile,
      body: BlocBuilder<AppAuthenticationCubit, AppAuthenticationState>(
        buildWhen: (a, b) => a.user != b.user,
        builder: (context, authState) {
          final profile = authState.user;

          if (profile == null) {
            return const Center(child: ProfileHeaderSkeleton());
          }

          return ListView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            children: [
              ProfileHeaderWidget(
                name: profile.fullName.isEmpty
                    ? t.profile.fallbackName
                    : profile.fullName,
                avatarUrl: profile.profileImageUrl,
                verifiedLabel: t.profile.verifiedAccount,
                isVerified: profile.status == ParentStatus.active,
                onChangeAvatarPressed: () =>
                    const EditProfileRoute().go(context),
              ),
              const Gap(40),
              ProfileSection(
                title: t.accountInfo,
                children: [
                  ProfileTileWidget(
                    icon: Icons.person_rounded,
                    label: t.profile.fullNameLabel,
                    value: profile.fullName.isEmpty ? '—' : profile.fullName,
                    onTap: () => const EditProfileRoute().go(context),
                  ),
                  ProfileTileWidget(
                    icon: Icons.phone_android_rounded,
                    label: t.profile.phoneNumberLabel,
                    value: profile.phoneNumber.isEmpty
                        ? '—'
                        : profile.phoneNumber,
                  ),
                  ProfileTileWidget(
                    icon: Icons.email_rounded,
                    label: t.profile.emailLabel,
                    value: (profile.email?.isNotEmpty == true)
                        ? profile.email!
                        : '—',
                  ),
                ],
              ),
              const Gap(32),
              ProfileSection(
                title: t.appSettings,
                children: [
                  ProfileTileWidget(
                    icon: Icons.notifications_rounded,
                    label: t.notifications,
                    value: t.profile.notificationsEnabled,
                    onTap: () => const SettingsRoute().go(context),
                  ),
                  ProfileTileWidget(
                    icon: Icons.security_rounded,
                    label: t.security,
                    value: t.profile.securityValue,
                    onTap: () => const SettingsRoute().go(context),
                  ),
                ],
              ),
              const Gap(48),
              _SignOutButton(
                label: t.profile.signOutAction,
                onPressed: () => _confirmSignOut(context, t),
              ),
              const Gap(40),
            ],
          );
        },
      ),
    );
  }

  Future<void> _confirmSignOut(
    BuildContext context,
    TranslationsParentEn t,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          backgroundColor: dialogContext.backgroundSecondaryColor,
          title: Text(t.profile.signOutConfirmTitle),
          content: Text(t.profile.signOutConfirmMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(t.profile.signOutCancel),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: dialogContext.statusDangerColor,
              ),
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(t.profile.signOutAction),
            ),
          ],
        );
      },
    );

    if (confirmed != true || !context.mounted) return;

    try {
      await context.read<AuthenticationRepository<ParentEntity>>().logout();
    } catch (_) {
      // Even if the network call fails, drop the local session.
    }
    if (!context.mounted) return;
    context.read<AppAuthenticationCubit>().logout();
    if (!context.mounted) return;
    const LoginPageRoute().go(context);
  }
}

class _SignOutButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _SignOutButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MentorXButton(
      onPressed: onPressed,
      label: label,
      icon: Icons.logout_rounded,
      style: Style(
        $box.color(context.statusDangerColor.withValues(alpha: 0.1)),
        $text.style.color(context.statusDangerColor),
      ),
    );
  }
}
