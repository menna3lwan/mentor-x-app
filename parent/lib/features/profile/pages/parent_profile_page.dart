import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:mentorx_core/mentorx_core.dart';
import '../bloc/profile_bloc.dart';

final class ParentProfilePage extends StatelessWidget {
  final ProfileStatus status;
  final ParentEntity? profileData;
  final String? errorMessage;
  final VoidCallback onRefresh;
  final VoidCallback onRetry;
  final VoidCallback onLogout;
  final VoidCallback onSettingsTap;

  const ParentProfilePage({
    super.key,
    required this.status,
    required this.profileData,
    required this.errorMessage,
    required this.onRefresh,
    required this.onRetry,
    required this.onLogout,
    required this.onSettingsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: Stack(
        children: [
          const _BackgroundDecorations(),
          _buildContent(context),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    final t = Translations.of(context).parent;

    if (status == ProfileStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (status == ProfileStatus.failure) {
      return AppErrorView(
        message: errorMessage ?? t.unableToLoad,
        onRetry: onRetry,
      );
    }

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Gap(MediaQuery.paddingOf(context).top + 20),
                _buildHeader(context, t),
                const Gap(40),
                
                // Avatar and Name
                FadeInDown(
                  duration: const Duration(milliseconds: 800),
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: context.brandPrimaryColor.withValues(alpha: 0.1), 
                                width: 4,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 60,
                              backgroundColor: context.backgroundSecondaryColor.withValues(alpha: 0.6),
                              child: AppDynamicImage(
                                profileData?.profileImageUrl ?? '',
                                width: 120,
                                height: 120,
                                borderRadius: BorderRadius.circular(60),
                                errorWidget: Icon(
                                  Icons.person_rounded,
                                  size: 70,
                                  color: context.brandPrimaryColor,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: context.brandPrimaryColor,
                              shape: BoxShape.circle,
                              border: Border.all(color: context.backgroundPrimaryColor, width: 3),
                              boxShadow: [
                                BoxShadow(
                                  color: context.brandPrimaryColor.withValues(alpha: 0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Icon(Icons.camera_alt_rounded, size: 18, color: Colors.white),
                          ),
                        ],
                      ),
                      const Gap(24),
                      Text(
                        profileData?.fullName ?? 'Parent User',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          color: context.textPrimaryColor,
                          letterSpacing: -0.5,
                        ),
                      ),
                      const Gap(6),
                      StatusBadge(
                        label: 'Verified Account',
                        color: context.statusSuccessColor,
                        isSmall: true,
                      ),
                    ],
                  ),
                ),
                const Gap(48),

                FadeInUp(
                  duration: const Duration(milliseconds: 600),
                  delay: const Duration(milliseconds: 200),
                  child: _ProfileSection(
                    title: t.accountInfo,
                    children: [
                      _ProfileTile(
                        icon: Icons.person_rounded,
                        label: 'Full Name',
                        value: profileData?.fullName ?? '-',
                      ),
                      _ProfileTile(
                        icon: Icons.phone_android_rounded,
                        label: 'Phone Number',
                        value: profileData?.phoneNumber ?? '-',
                      ),
                      _ProfileTile(
                        icon: Icons.email_rounded,
                        label: 'Email Address',
                        value: profileData?.email ?? '-',
                      ),
                    ],
                  ),
                ),
                const Gap(32),
                
                FadeInUp(
                  duration: const Duration(milliseconds: 600),
                  delay: const Duration(milliseconds: 400),
                  child: _ProfileSection(
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
                ),
                const Gap(48),
                
                FadeInUp(
                  duration: const Duration(milliseconds: 600),
                  delay: const Duration(milliseconds: 600),
                  child: MentorXButton(
                    onPressed: onLogout,
                    label: t.signOut,
                    style: Style(
                      $box.color(context.statusDangerColor.withValues(alpha: 0.1)),
                      $text.color(context.statusDangerColor),
                      $box.borderRadius(16),
                      $box.padding.vertical(16),
                    ),
                  ),
                ),
                const Gap(100),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, dynamic t) {
    return FadeInDown(
      duration: const Duration(milliseconds: 600),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            t.myProfile,
            style: TextStyle(
              color: context.textPrimaryColor,
              fontSize: 28,
              fontWeight: FontWeight.w900,
              letterSpacing: -1.0,
            ),
          ),
          IconButton(
            onPressed: onSettingsTap,
            icon: const Icon(Icons.settings_suggest_rounded),
            style: IconButton.styleFrom(
              backgroundColor: context.backgroundSecondaryColor.withValues(alpha: 0.6),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
            color: context.backgroundSecondaryColor.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: context.borderPrimaryColor.withValues(alpha: 0.1)),
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
      borderRadius: BorderRadius.circular(28),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: context.brandPrimaryColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(18),
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
                      fontWeight: FontWeight.w900,
                      color: context.textPrimaryColor,
                      letterSpacing: -0.2,
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

class _BackgroundDecorations extends StatelessWidget {
  const _BackgroundDecorations();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -100,
          left: -100,
          child: _BlurredBlob(
            color: context.brandPrimaryColor.withValues(alpha: 0.1),
            size: 400,
          ),
        ),
        Positioned(
          bottom: 100,
          right: -150,
          child: _BlurredBlob(
            color: context.brandSecondaryColor.withValues(alpha: 0.08),
            size: 450,
          ),
        ),
      ],
    );
  }
}

class _BlurredBlob extends StatelessWidget {
  final Color color;
  final double size;

  const _BlurredBlob({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}
