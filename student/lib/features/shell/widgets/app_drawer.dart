import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:gap/gap.dart';

final class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key, required this.onTabSelected});

  final ValueChanged<int> onTabSelected;

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final session = context.watch<AppSessionCubit>().state;
    final name = session.studentName;

    return Drawer(
      backgroundColor: context.backgroundPrimaryColor,
      child: Stack(
        children: [
          const _BackgroundDecorations(),
          Column(
            children: [
              // Header
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(
                  24,
                  MediaQuery.paddingOf(context).top + 40,
                  24,
                  32,
                ),
                decoration: BoxDecoration(
                  color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(32),
                  ),
                  border: Border(
                    bottom: BorderSide(
                      color: context.borderPrimaryColor.withValues(alpha: 0.1),
                    ),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    bottom: Radius.circular(32),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                context.brandPrimaryColor,
                                context.brandSecondaryColor,
                              ],
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: context.backgroundPrimaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: context.backgroundSecondaryColor,
                              child: Icon(
                                Icons.person_rounded,
                                color: context.brandPrimaryColor,
                                size: 32,
                              ),
                            ),
                          ),
                        ),
                        const Gap(20),
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            color: context.textPrimaryColor,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const Gap(4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: context.brandPrimaryColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            session.studentCode,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w900,
                              color: context.brandPrimaryColor,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // Menu Items
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _DrawerItem(
                      icon: Icons.home_rounded,
                      label: t['navHome']!,
                      onTap: () {
                        Navigator.pop(context);
                        onTabSelected(0);
                      },
                    ),
                    _DrawerItem(
                      icon: Icons.menu_book_rounded,
                      label: t['navCourses']!,
                      onTap: () {
                        Navigator.pop(context);
                        onTabSelected(1);
                      },
                    ),
                    _DrawerItem(
                      icon: Icons.quiz_rounded,
                      label: t['navQuizzes']!,
                      onTap: () {
                        Navigator.pop(context);
                        onTabSelected(2);
                      },
                    ),
                    _DrawerItem(
                      icon: Icons.assignment_rounded,
                      label: t['assignment']!,
                      onTap: () {
                        Navigator.pop(context);
                        context.push('/assignment-detail');
                      },
                    ),
                    _DrawerItem(
                      icon: Icons.qr_code_scanner_rounded,
                      label: t['attendance']!,
                      onTap: () {
                        Navigator.pop(context);
                        context.push('/attendance-qr');
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: Divider(
                        color: context.borderPrimaryColor.withValues(alpha: 0.1),
                        height: 1,
                      ),
                    ),
                    _DrawerItem(
                      icon: Icons.account_balance_wallet_rounded,
                      label: t['wallet']!,
                      onTap: () {
                        Navigator.pop(context);
                        onTabSelected(3);
                      },
                    ),
                    _DrawerItem(
                      icon: Icons.store_rounded,
                      label: t['store']!,
                      onTap: () {
                        Navigator.pop(context);
                        context.push('/marketplace');
                      },
                    ),
                    _DrawerItem(
                      icon: Icons.smart_toy_rounded,
                      label: t['aiChat']!,
                      onTap: () {
                        Navigator.pop(context);
                        context.push('/ai-chat');
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      child: Divider(
                        color: context.borderPrimaryColor.withValues(alpha: 0.1),
                        height: 1,
                      ),
                    ),
                    _DrawerItem(
                      icon: Icons.person_rounded,
                      label: t['profileTitle']!,
                      onTap: () {
                        Navigator.pop(context);
                        onTabSelected(4);
                      },
                    ),
                    _DrawerItem(
                      icon: Icons.settings_rounded,
                      label: t['settingsTitle']!,
                      onTap: () {
                        Navigator.pop(context);
                        context.push('/settings');
                      },
                    ),
                    const Gap(32),
                    _DrawerItem(
                      icon: Icons.logout_rounded,
                      label: t['logoutSetting']!,
                      isDestructive: true,
                      onTap: () {
                        Navigator.pop(context);
                        context.read<AppAuthenticationCubit>().logout();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

final class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final color = isDestructive
        ? context.statusDangerColor
        : context.textPrimaryColor;
    final iconColor = isDestructive
        ? context.statusDangerColor
        : context.brandPrimaryColor;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                iconColor.withValues(alpha: 0.15),
                iconColor.withValues(alpha: 0.05),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: iconColor.withValues(alpha: 0.1),
            ),
          ),
          child: Icon(icon, size: 22, color: iconColor),
        ),
        title: Text(
          label,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: color,
            letterSpacing: -0.2,
          ),
        ),
        onTap: onTap,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
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
          right: -50,
          child: _BlurredBlob(
            color: context.brandPrimaryColor.withValues(alpha: 0.08),
            size: 300,
          ),
        ),
        Positioned(
          bottom: -50,
          left: -100,
          child: _BlurredBlob(
            color: context.brandSecondaryColor.withValues(alpha: 0.05),
            size: 250,
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
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
        child: const SizedBox.expand(),
      ),
    );
  }
}
