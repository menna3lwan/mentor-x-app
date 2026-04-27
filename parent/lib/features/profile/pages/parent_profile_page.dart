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
    final palette = MentorXThemeColorPalette.light;

    return BlocProvider(
      create: (context) => ProfileBloc()..add(ProfileStarted()),
      child: Scaffold(
        backgroundColor: palette.backgroundPrimary,
        body: const ParentProfileView(),
      ),
    );
  }
}

class ParentProfileView extends StatelessWidget {
  const ParentProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;
    final t = Translations.of(context).parent;

    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state.status == ProfileStatus.loading) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(palette.brandPrimary),
            ),
          );
        }

        if (state.status == ProfileStatus.failure) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ZoomIn(
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: palette.statusDanger.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.error_outline_rounded, size: 48, color: palette.statusDanger),
                    ),
                  ),
                  const Gap(24),
                  Text(
                    state.errorMessage ?? t.unableToLoad,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: palette.textPrimary, fontWeight: FontWeight.w900, fontSize: 18),
                  ),
                  const Gap(24),
                  MentorXButton(
                    onPressed: () => context.read<ProfileBloc>().add(ProfileStarted()),
                    label: t.retry,
                    size: MentorXButtonSize.small,
                  ),
                ],
              ),
            ),
          );
        }

        final profile = state.profileData;
        
        return Column(
          children: [
            // Premium Header
            FadeInDown(
              duration: const Duration(milliseconds: 600),
              child: _BuildHeader(palette: palette, name: profile?.fullName ?? 'Parent User'),
            ),
            
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                children: [
                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 100),
                    child: _ProfileSection(
                      title: t.accountInfo,
                      children: [
                        _ProfileTile(
                          icon: Icons.person_rounded,
                          label: 'Full Name',
                          value: profile?.fullName ?? '-',
                          palette: palette,
                        ),
                        _ProfileTile(
                          icon: Icons.phone_android_rounded,
                          label: 'Phone Number',
                          value: profile?.phoneNumber ?? '-',
                          palette: palette,
                        ),
                        _ProfileTile(
                          icon: Icons.email_rounded,
                          label: 'Email Address',
                          value: 'parent@example.com',
                          palette: palette,
                        ),
                      ],
                    ),
                  ),
                  const Gap(32),
                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 200),
                    child: _ProfileSection(
                      title: t.appSettings,
                      children: [
                        _ProfileTile(
                          icon: Icons.notifications_rounded,
                          label: t.notifications,
                          value: 'Enabled',
                          onTap: () {},
                          palette: palette,
                        ),
                        _ProfileTile(
                          icon: Icons.security_rounded,
                          label: t.security,
                          value: 'Password & Biometrics',
                          onTap: () {},
                          palette: palette,
                        ),
                      ],
                    ),
                  ),
                  const Gap(48),
                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 300),
                    child: MentorXButton(
                      onPressed: () {
                        // Logout logic
                      },
                      label: t.signOut,
                      style: Style(
                        $box.color(palette.statusDanger.withValues(alpha: 0.1)),
                        $text.color(palette.statusDanger),
                      ),
                    ),
                  ),
                  const Gap(40),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class _BuildHeader extends StatelessWidget {
  final MentorXThemeColorPalette palette;
  final String name;
  const _BuildHeader({required this.palette, required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10,
        bottom: 40,
        left: 12,
        right: 12,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [palette.brandPrimary, palette.brandPrimary.withValues(alpha: 0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(40)),
        boxShadow: [
          BoxShadow(
            color: palette.brandPrimary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
              ),
              Expanded(
                child: Text(
                  Translations.of(context).parent.myProfile,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.edit_note_rounded, color: Colors.white, size: 24),
              ),
            ],
          ),
          const Gap(24),
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 1.5),
                ),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    radius: 48,
                    backgroundColor: palette.backgroundSecondary,
                    child: Icon(Icons.person_rounded, size: 56, color: palette.brandPrimary),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: palette.statusSuccess,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                ),
                child: const Icon(Icons.camera_alt_rounded, size: 16, color: Colors.white),
              ),
            ],
          ),
          const Gap(16),
          Text(
            name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: Colors.white,
              letterSpacing: -0.5,
            ),
          ),
          const Gap(4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Verified Account',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                color: Colors.white.withValues(alpha: 0.9),
                letterSpacing: 0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileSection extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const _ProfileSection({required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 16),
          child: Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              color: palette.textTertiary,
              letterSpacing: 1.2,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
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
  final MentorXThemeColorPalette palette;

  const _ProfileTile({
    required this.icon,
    required this.label,
    required this.value,
    this.onTap,
    required this.palette,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(32),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: palette.brandPrimary.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: palette.brandPrimary, size: 22),
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
                      color: palette.textTertiary,
                    ),
                  ),
                  const Gap(4),
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                      color: palette.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
            if (onTap != null)
              Icon(Icons.arrow_forward_ios_rounded, color: palette.textTertiary, size: 14),
          ],
        ),
      ),
    );
  }
}
