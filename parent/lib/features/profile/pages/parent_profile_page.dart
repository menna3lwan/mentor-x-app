import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import 'package:mix/mix.dart';
import '../bloc/profile_bloc.dart';

class ParentProfilePage extends StatelessWidget {
  const ParentProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;

    return BlocProvider(
      create: (context) => ProfileBloc()..add(ProfileStarted()),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          return AppDashboardScaffold(
            title: t.myProfile,
            body: const ParentProfileView(),
          );
        },
      ),
    );
  }
}

class ParentProfileView extends StatelessWidget {
  const ParentProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;

    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state.status == ProfileStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.status == ProfileStatus.failure) {
          return AppErrorView(
            message: state.errorMessage ?? t.unableToLoad,
            onRetry: () => context.read<ProfileBloc>().add(ProfileStarted()),
          );
        }

        final profile = state.profileData;
        
        return ListView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          children: [
            // Avatar and Name
            Center(
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: context.brandPrimaryColor.withValues(alpha: 0.1), width: 4),
                        ),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: context.backgroundSecondaryColor,
                          child: Icon(Icons.person_rounded, size: 60, color: context.brandPrimaryColor),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: context.brandPrimaryColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: context.backgroundPrimaryColor, width: 3),
                        ),
                        child: const Icon(Icons.camera_alt_rounded, size: 16, color: Colors.white),
                      ),
                    ],
                  ),
                  const Gap(16),
                  Text(
                    profile?.fullName ?? 'Parent User',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: context.textPrimaryColor,
                    ),
                  ),
                  const Gap(4),
                  StatusBadge(
                    label: 'Verified Account',
                    color: context.statusSuccessColor,
                    isSmall: true,
                  ),
                ],
              ),
            ),
            const Gap(40),

            _ProfileSection(
              title: t.accountInfo,
              children: [
                _ProfileTile(
                  icon: Icons.person_rounded,
                  label: 'Full Name',
                  value: profile?.fullName ?? '-',
                ),
                _ProfileTile(
                  icon: Icons.phone_android_rounded,
                  label: 'Phone Number',
                  value: profile?.phoneNumber ?? '-',
                ),
                _ProfileTile(
                  icon: Icons.email_rounded,
                  label: 'Email Address',
                  value: profile?.email ?? '-',
                ),
              ],
            ),
            const Gap(32),
            _ProfileSection(
              title: t.appSettings,
              children: [
                _ProfileTile(
                  icon: Icons.notifications_rounded,
                  label: t.notifications,
                  value: 'Enabled',
                  onTap: () {},
                ),
                _ProfileTile(
                  icon: Icons.security_rounded,
                  label: t.security,
                  value: 'Password & Biometrics',
                  onTap: () {},
                ),
              ],
            ),
            const Gap(48),
            MentorXButton(
              onPressed: () {
                // Logout logic
              },
              label: t.signOut,
              style: Style(
                $box.color(context.statusDangerColor.withValues(alpha: 0.1)),
                $text.color(context.statusDangerColor),
              ),
            ),
            const Gap(40),
          ],
        );
      },
    );
  }
}

// Removed _BuildHeader in favor of AppDashboardScaffold

class _ProfileSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _ProfileSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 12),
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              color: context.textTertiaryColor,
              letterSpacing: 1.2,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: context.backgroundSecondaryColor,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: context.textTertiaryColor.withValues(alpha: 0.1)),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback? onTap;

  const _ProfileTile({
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: context.brandPrimaryColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: context.brandPrimaryColor, size: 22),
            ),
            const Gap(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w800,
                      color: context.textTertiaryColor,
                    ),
                  ),
                  const Gap(4),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: context.textPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),
            if (onTap != null)
              Icon(Icons.arrow_forward_ios_rounded, color: context.textTertiaryColor, size: 14),
          ],
        ),
      ),
    );
  }
}
