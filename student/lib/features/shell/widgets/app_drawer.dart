import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key, required this.onTabSelected});

  final ValueChanged<int> onTabSelected;

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final session = context.watch<AppSessionCubit>().state;
    final name = session.studentName;

    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 52, 16, 16),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.primary, AppColors.primaryGradientEnd],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.2),
                    ),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                Text(
                  session.studentCode,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
          // Menu Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _DrawerItem(
                  icon: Icons.home_outlined,
                  label: t['navHome']!,
                  onTap: () {
                    Navigator.pop(context);
                    onTabSelected(0);
                  },
                ),
                _DrawerItem(
                  icon: Icons.menu_book_outlined,
                  label: t['navCourses']!,
                  onTap: () {
                    Navigator.pop(context);
                    onTabSelected(1);
                  },
                ),
                _DrawerItem(
                  icon: Icons.quiz_outlined,
                  label: t['navQuizzes']!,
                  onTap: () {
                    Navigator.pop(context);
                    onTabSelected(2);
                  },
                ),
                _DrawerItem(
                  icon: Icons.assignment_outlined,
                  label: t['assignment']!,
                  onTap: () {
                    Navigator.pop(context);
                    context.push('/assignment-detail');
                  },
                ),
                _DrawerItem(
                  icon: Icons.qr_code_scanner,
                  label: t['attendance']!,
                  onTap: () {
                    Navigator.pop(context);
                    context.push('/attendance-qr');
                  },
                ),
                const Divider(height: 1),
                _DrawerItem(
                  icon: Icons.account_balance_wallet_outlined,
                  label: t['wallet']!,
                  onTap: () {
                    Navigator.pop(context);
                    onTabSelected(3);
                  },
                ),
                _DrawerItem(
                  icon: Icons.store_outlined,
                  label: t['store']!,
                  onTap: () {
                    Navigator.pop(context);
                    context.push('/products');
                  },
                ),
                _DrawerItem(
                  icon: Icons.smart_toy_outlined,
                  label: t['aiChat']!,
                  onTap: () {
                    Navigator.pop(context);
                    context.push('/ai-chat');
                  },
                ),
                const Divider(height: 1),
                _DrawerItem(
                  icon: Icons.person_outline,
                  label: t['profileTitle']!,
                  onTap: () {
                    Navigator.pop(context);
                    onTabSelected(4);
                  },
                ),
                _DrawerItem(
                  icon: Icons.settings_outlined,
                  label: t['settingsTitle']!,
                  onTap: () {
                    Navigator.pop(context);
                    context.push('/settings');
                  },
                ),
                _DrawerItem(
                  icon: Icons.logout,
                  label: t['logoutSetting']!,
                  color: AppColors.red,
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
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.color,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 20, color: color ?? AppColors.primary),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: color ?? AppColors.primary,
        ),
      ),
      onTap: onTap,
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }
}
