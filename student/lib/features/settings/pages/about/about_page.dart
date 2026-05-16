import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';

import 'package:mentorx_student/core/core.dart';

final class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.settings;

    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: Column(
        children: [
          _buildHeader(context, t),
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
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
                            colors: [
                              context.brandSecondaryColor,
                              context.brandPrimaryColor,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: context.brandPrimaryColor.withValues(alpha: 0.2),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(28),
                          decoration: BoxDecoration(
                            color: context.backgroundSecondaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.school_rounded,
                            size: 56,
                            color: context.brandPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                    const Gap(32),
                    FadeInUp(
                      duration: const Duration(milliseconds: 500),
                      delay: const Duration(milliseconds: 200),
                      child: Column(
                        children: [
                          Text(
                            'MentorX',
                            style: context.titleH1Style.copyWith(
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -1,
                            ),
                          ),
                          const Gap(8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: context.brandPrimaryColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: context.brandPrimaryColor.withValues(
                                  alpha: 0.2,
                                ),
                              ),
                            ),
                            child: Text(
                              t.tEditionPro,
                              style: context.bodySecondaryStyle.copyWith(
                                fontSize: 13,
                                fontWeight: FontWeight.w900,
                                color: context.brandPrimaryColor,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(24),
                    FadeInUp(
                      duration: const Duration(milliseconds: 500),
                      delay: const Duration(milliseconds: 300),
                      child: Text(
                        t.aboutDesc,
                        style: context.bodyPrimaryStyle.copyWith(
                          fontSize: 15,
                          color: context.textSecondaryColor,
                          height: 1.6,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const Gap(40),

                    // Info card
                    FadeInUp(
                      duration: const Duration(milliseconds: 600),
                      delay: const Duration(milliseconds: 400),
                      child: MentorXGlassCard(
                        style: Style(
                          $box.padding.all(24),
                          $box.borderRadius(32),
                        ),
                        child: Column(
                          children: [
                            _InfoRow(
                              icon: Icons.tag_rounded,
                              label: t.version,
                              value: '2.0.0',
                            ),
                            Divider(
                              height: 40,
                              color: context.borderPrimaryColor.withValues(
                                alpha: 0.05,
                              ),
                              thickness: 1,
                            ),
                            _InfoRow(
                              icon: Icons.update_rounded,
                              label: t.lastUpdate,
                              value: 'May 2026',
                            ),
                            Divider(
                              height: 40,
                              color: context.borderPrimaryColor.withValues(
                                alpha: 0.05,
                              ),
                              thickness: 1,
                            ),
                            _InfoRow(
                              icon: Icons.verified_user_rounded,
                              label: t.buildLabel,
                              value: '2026.05.08',
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Gap(48),
                    FadeInUp(
                      duration: const Duration(milliseconds: 500),
                      delay: const Duration(milliseconds: 500),
                      child: Text(
                        t.allRightsReserved,
                        style: context.bodySecondaryStyle.copyWith(
                          fontSize: 12,
                          color: context.textTertiaryColor,
                          fontWeight: FontWeight.w800,
                        ),
                        textDirection: TextDirection.ltr,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, dynamic t) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        12,
        MediaQuery.paddingOf(context).top + 8,
        12,
        16,
      ),
      decoration: BoxDecoration(
        color: context.backgroundPrimaryColor.withValues(alpha: 0.8),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        border: Border(
          bottom: BorderSide(
            color: context.borderPrimaryColor.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Row(
            children: [
              MentorXIconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: Icons.arrow_back_ios_new_rounded,
                variant: MentorXIconButtonVariant.outline,
                size: MentorXIconButtonSize.small,
              ),
              const Gap(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.appInfoLabel,
                      style: context.bodySecondaryStyle.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: context.brandPrimaryColor,
                        letterSpacing: 2.0,
                      ),
                    ),
                    const Gap(2),
                    Text(
                      t.aboutSetting,
                      style: context.titleH1Style.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1.0,
                        height: 1.1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final class _InfoRow extends StatelessWidget {
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
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: context.brandPrimaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 20, color: context.brandPrimaryColor),
        ),
        const Gap(16),
        Expanded(
          child: Text(
            label,
            style: context.bodySecondaryStyle.copyWith(
              fontSize: 14,
              color: context.textSecondaryColor,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Text(
          value,
          style: context.bodyPrimaryStyle.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w900,
          ),
          textDirection: TextDirection.ltr,
        ),
      ],
    );
  }
}
