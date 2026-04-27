import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final palette = MentorXThemeColorPalette.light;
    return Scaffold(
      backgroundColor: palette.backgroundSecondary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: FadeInDown(
          duration: const Duration(milliseconds: 500),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            foregroundColor: palette.brandPrimary,
            title: Text(
              t['aboutTitle'] ?? 'About',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: palette.textPrimary,
                letterSpacing: -0.5,
              ),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // App logo with gradient ring
              ZoomIn(
                duration: const Duration(milliseconds: 600),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [palette.brandSecondary, palette.brandPrimary],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: palette.brandPrimary.withValues(alpha: 0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(28),
                    decoration: BoxDecoration(
                      color: palette.backgroundPrimary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.school_rounded,
                      size: 56,
                      color: palette.brandPrimary,
                    ),
                  ),
                ),
              ),
              const Gap(24),
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 200),
                child: Column(
                  children: [
                    Text(
                      'MentorX',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w900,
                        color: palette.textPrimary,
                        letterSpacing: -0.8,
                      ),
                    ),
                    const Gap(8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: palette.brandPrimary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: palette.brandPrimary.withValues(alpha: 0.2)),
                      ),
                      child: Text(
                        'Student Edition',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w800,
                          color: palette.brandPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(20),
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 300),
                child: Text(
                  t['aboutDesc'] ?? 'Your learning companion',
                  style: TextStyle(
                    fontSize: 15,
                    color: palette.textSecondary,
                    height: 1.6,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Gap(32),

              // Info card
              FadeInUp(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 400),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: palette.backgroundPrimary,
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      _InfoRow(
                        icon: Icons.tag_rounded,
                        label: t['version'] ?? 'Version',
                        value: '1.0.0',
                        palette: palette,
                      ),
                      Divider(
                        height: 32,
                        color: palette.backgroundSecondary,
                        thickness: 1.5,
                      ),
                      _InfoRow(
                        icon: Icons.update_rounded,
                        label: t['lastUpdate'] ?? 'Last Update',
                        value: 'April 2025',
                        palette: palette,
                      ),
                      Divider(
                        height: 32,
                        color: palette.backgroundSecondary,
                        thickness: 1.5,
                      ),
                      _InfoRow(
                        icon: Icons.verified_user_rounded,
                        label: 'Build',
                        value: '2025.04.27',
                        palette: palette,
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(40),
              FadeInUp(
                duration: const Duration(milliseconds: 500),
                delay: const Duration(milliseconds: 500),
                child: Text(
                  '© 2025 MentorX. All rights reserved.',
                  style: TextStyle(
                    fontSize: 12,
                    color: palette.textTertiary.withValues(alpha: 0.8),
                    fontWeight: FontWeight.w600,
                  ),
                  textDirection: TextDirection.ltr,
                ),
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
    required this.palette,
  });
  final IconData icon;
  final String label;
  final String value;
  final MentorXThemeColorPalette palette;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: palette.brandPrimary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 18, color: palette.brandPrimary),
        ),
        const Gap(14),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: palette.textSecondary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w900,
            color: palette.textPrimary,
          ),
          textDirection: TextDirection.ltr,
        ),
      ],
    );
  }
}
