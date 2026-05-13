import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_student/core/core.dart';

final class StudentCardContent extends StatelessWidget {
  final StudentCardEntity card;
  final dynamic t;

  const StudentCardContent({
    super.key,
    required this.card,
    required this.t,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Gap(20),
          FadeInDown(
            duration: const Duration(milliseconds: 800),
            child: _DigitalIdCard(card: card),
          ),
          const Gap(40),
          FadeInUp(
            duration: const Duration(milliseconds: 800),
            delay: const Duration(milliseconds: 200),
            child: _QrSection(qrToken: card.qrToken),
          ),
          const Spacer(),
          FadeInUp(
            duration: const Duration(milliseconds: 800),
            delay: const Duration(milliseconds: 400),
            child: const _SecurityInfo(),
          ),
          const Gap(40),
        ],
      ),
    );
  }
}

final class _DigitalIdCard extends StatelessWidget {
  final StudentCardEntity card;

  const _DigitalIdCard({required this.card});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.586, // ID-1 Card ratio
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: context.brandPrimaryColor.withValues(alpha: 0.3),
              blurRadius: 40,
              offset: const Offset(0, 20),
              spreadRadius: -10,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: Stack(
            children: [
              // Card Background
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        context.brandPrimaryColor,
                        context.brandPrimaryColor.withValues(alpha: 0.8),
                        context.brandSecondaryColor,
                      ],
                    ),
                  ),
                ),
              ),
              // Decorative Patterns
              const Positioned(
                top: -50,
                right: -50,
                child: Opacity(
                  opacity: 0.1,
                  child: Icon(Icons.school_rounded, size: 200, color: Colors.white),
                ),
              ),
              // Card Content
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'STUDENT ID',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.7),
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 2,
                              ),
                            ),
                            const Gap(4),
                            const Text(
                              'MentorX Platform',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.wifi_tethering_rounded, color: Colors.white, size: 20),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                card.studentName,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              const Gap(8),
                              _CardInfoRow(label: 'CODE', value: card.studentCode),
                              const Gap(4),
                              if (card.grade != null)
                                _CardInfoRow(label: 'GRADE', value: card.grade!),
                            ],
                          ),
                        ),
                        Container(
                          width: 60,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
                          ),
                          child: card.profileImageUrl != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(11),
                                  child: AppDynamicImage(
                                    card.profileImageUrl!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const Icon(Icons.person_rounded, color: Colors.white, size: 40),
                        ),
                      ],
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

final class _CardInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _CardInfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.6),
            fontSize: 10,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}

final class _QrSection extends StatelessWidget {
  final String qrToken;

  const _QrSection({required this.qrToken});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'SCAN FOR ATTENDANCE',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w900,
            color: context.textTertiaryColor,
            letterSpacing: 1.5,
          ),
        ),
        const Gap(20),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: context.borderPrimaryColor.withValues(alpha: 0.1)),
          ),
          child: QrImageView(
            data: qrToken,
            version: QrVersions.auto,
            size: 200,
            eyeStyle: QrEyeStyle(
              eyeShape: QrEyeShape.square,
              color: context.brandPrimaryColor,
            ),
            dataModuleStyle: QrDataModuleStyle(
              dataModuleShape: QrDataModuleShape.square,
              color: context.brandPrimaryColor.withValues(alpha: 0.8),
            ),
          ),
        ),
      ],
    );
  }
}

final class _SecurityInfo extends StatelessWidget {
  const _SecurityInfo();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: context.statusSuccessColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.statusSuccessColor.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.verified_user_rounded, color: context.statusSuccessColor, size: 18),
          const Gap(10),
          Text(
            'SECURE DIGITAL ID',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w900,
              color: context.statusSuccessColor,
            ),
          ),
        ],
      ),
    );
  }
}
