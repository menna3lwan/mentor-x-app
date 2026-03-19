import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: AppColors.primary,
        title: Text(
          t['aboutTitle'] ?? 'About',
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // App logo with gradient ring
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [AppColors.accent, AppColors.primary],
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(22),
                  decoration: const BoxDecoration(
                    color: AppColors.backgroundLight,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.school_rounded,
                    size: 44,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'MentorX',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: AppColors.primary,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.accent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Student Edition',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.accent,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                t['aboutDesc'] ?? 'Your learning companion',
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.greyDark,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),

              // Info card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _InfoRow(
                      icon: Icons.tag_rounded,
                      label: t['version'] ?? 'Version',
                      value: '1.0.0',
                    ),
                    Divider(
                      height: 24,
                      color: AppColors.greyLight.withValues(alpha: 0.5),
                    ),
                    _InfoRow(
                      icon: Icons.update_rounded,
                      label: t['lastUpdate'] ?? 'Last Update',
                      value: 'Mar 2025',
                    ),
                    Divider(
                      height: 24,
                      color: AppColors.greyLight.withValues(alpha: 0.5),
                    ),
                    _InfoRow(
                      icon: Icons.verified_rounded,
                      label: 'Build',
                      value: '2025.03.19',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              Text(
                '© 2025 MentorX. All rights reserved.',
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.grey.withValues(alpha: 0.7),
                ),
                textDirection: TextDirection.ltr,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });
  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.primary.withValues(alpha: 0.5)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.greyDark,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
          textDirection: TextDirection.ltr,
        ),
      ],
    );
  }
}
