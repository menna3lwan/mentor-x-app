import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

class ProfileViewPage extends StatelessWidget {
  const ProfileViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final session = context.watch<AppSessionCubit>().state;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(
                top: 20,
                bottom: 24,
                left: 20,
                right: 20,
              ),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.primaryLight, AppColors.primary],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(28),
                  bottomRight: Radius.circular(28),
                ),
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.white24,
                    child: Icon(Icons.person, size: 36, color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    isAr ? session.studentNameAr : session.studentName,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    session.studentCode,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                    textDirection: TextDirection.ltr,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Personal Data
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t['personalData']!,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _ProfileItem(
                    icon: Icons.person_outline,
                    iconBgColor: AppColors.primary.withValues(alpha: 0.12),
                    iconColor: AppColors.primary,
                    label: t['name']!,
                    value: isAr ? session.studentNameAr : session.studentName,
                  ),
                  _ProfileItem(
                    icon: Icons.phone_outlined,
                    iconBgColor: AppColors.primary.withValues(alpha: 0.12),
                    iconColor: AppColors.primary,
                    label: t['phone']!,
                    value: session.phone,
                    isLtr: true,
                  ),
                  _ProfileItem(
                    icon: Icons.menu_book_outlined,
                    iconBgColor: AppColors.background,
                    iconColor: AppColors.accent,
                    label: t['grade']!,
                    value: isAr ? session.gradeAr : session.grade,
                  ),
                  _ProfileItem(
                    icon: Icons.location_on_outlined,
                    iconBgColor: AppColors.success.withValues(alpha: 0.12),
                    iconColor: AppColors.success,
                    label: t['center']!,
                    value: isAr ? session.centerAr : session.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Action Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => context.push('/edit-profile'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(t['editRequest']!),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => context.push('/settings'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: const BorderSide(color: AppColors.primary),
                      ),
                      child: Text(t['settingsTitle']!),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _ProfileItem extends StatelessWidget {
  const _ProfileItem({
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    required this.label,
    required this.value,
    this.isLtr = false,
  });
  final IconData icon;
  final Color iconBgColor, iconColor;
  final String label, value;
  final bool isLtr;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 4),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, size: 18, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontSize: 10, color: AppColors.greyDark),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                  textDirection: isLtr ? TextDirection.ltr : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
