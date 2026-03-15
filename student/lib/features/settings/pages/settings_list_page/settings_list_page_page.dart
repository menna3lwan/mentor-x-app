import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

class SettingsListPage extends StatelessWidget {
  const SettingsListPage({super.key});
  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final items = [
      (
        Icons.lock_outline,
        t['changePasswordSetting']!,
        () => context.push('/change-password'),
        AppColors.primary,
      ),
      (
        Icons.notifications_outlined,
        t['notificationsSetting']!,
        () => context.push('/notifications'),
        AppColors.accent,
      ),
      (
        Icons.headset_mic_outlined,
        t['supportSetting']!,
        () => context.push('/support'),
        AppColors.success,
      ),
      (
        Icons.info_outline,
        t['aboutSetting']!,
        () => context.push('/about'),
        AppColors.primary,
      ),
      (
        Icons.logout,
        t['logoutSetting']!,
        () => context.go('/login'),
        AppColors.red,
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: Text(
          t['settingsTitle']!,
          style: const TextStyle(fontSize: 15),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        separatorBuilder: (_, _) => const SizedBox(height: 8),
        itemBuilder: (context, i) {
          final (icon, label, _, color) = items[i];
          final isLogout = i == items.length - 1;
          return Material(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            child: InkWell(
              onTap: () => items[i].$3(),
              borderRadius: BorderRadius.circular(10),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(icon, size: 20, color: color),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        label,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isLogout ? AppColors.red : AppColors.primary,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: AppColors.greyDark,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
