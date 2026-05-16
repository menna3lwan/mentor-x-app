import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_student/core/core.dart';
import 'dart:ui' as ui;

final class StudentCardContent extends StatelessWidget {
  final StudentCardEntity card;

  const StudentCardContent({
    super.key,
    required this.card,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const Gap(24),
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
      aspectRatio: 1.586,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: context.brandPrimaryColor.withValues(alpha: 0.35),
              blurRadius: 40,
              offset: const Offset(0, 20),
              spreadRadius: -10,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(32),
          child: Stack(
            children: [
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        context.brandPrimaryColor,
                        context.brandPrimaryColor.withValues(alpha: 0.85),
                        context.brandSecondaryColor,
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: -80,
                right: -40,
                child: Opacity(
                  opacity: 0.08,
                  child: Icon(
                    Icons.fingerprint_rounded,
                    size: 280,
                    color: Colors.white,
                  ),
                ),
              ),
              Positioned.fill(
                child: BackdropFilter(
                  filter: ui.ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: const SizedBox.shrink(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(28),
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
                              context.t.studentcard.digitalId.toUpperCase(),
                              style: context.smallTextStyle.copyWith(
                                color: Colors.white.withValues(alpha: 0.7),
                                fontWeight: FontWeight.w900,
                                letterSpacing: 2,
                                fontSize: 10,
                              ),
                            ),
                            const Gap(4),
                            Text(
                              context.t.studentcard.platformName,
                              style: context.titleH3Style.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w900,
                                letterSpacing: -0.5,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.2),
                            ),
                          ),
                          child: const Icon(
                            Icons.nfc_rounded,
                            color: Colors.white,
                            size: 24,
                          ),
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
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: context.titleH2Style.copyWith(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              const Gap(8),
                              _CardInfoRow(
                                label: context.t.studentcard.codeLabel,
                                value: card.studentCode,
                              ),
                              const Gap(2),
                              if (card.grade != null)
                                _CardInfoRow(
                                  label: context.t.studentcard.gradeLabel,
                                  value: card.grade!,
                                ),
                            ],
                          ),
                        ),
                        Container(
                          width: 64,
                          height: 84,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.3),
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.1),
                                blurRadius: 10,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: card.profileImageUrl != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: AppDynamicImage(
                                    card.profileImageUrl!,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const Icon(
                                  Icons.person_rounded,
                                  color: Colors.white,
                                  size: 36,
                                ),
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
          style: context.smallTextStyle.copyWith(
            color: Colors.white.withValues(alpha: 0.7),
            fontSize: 10,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          value,
          style: context.smallTextStyle.copyWith(
            color: Colors.white,
            fontSize: 11,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.5,
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
          context.t.studentcard.scanForAttendance.toUpperCase(),
          style: context.smallTextStyle.copyWith(
            fontWeight: FontWeight.w900,
            color: context.textTertiaryColor,
            letterSpacing: 2,
            fontSize: 11,
          ),
        ),
        const Gap(24),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
            boxShadow: [
              BoxShadow(
                color: context.brandPrimaryColor.withValues(alpha: 0.08),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
            border: Border.all(
              color: context.brandPrimaryColor.withValues(alpha: 0.1),
              width: 1.5,
            ),
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
              color: context.textPrimaryColor,
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
        borderRadius: BorderRadius.circular(100),
        border: Border.all(
          color: context.statusSuccessColor.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.verified_user_rounded,
            color: context.statusSuccessColor,
            size: 16,
          ),
          const Gap(8),
          Text(
            context.t.studentcard.secureDigitalId,
            style: context.smallTextStyle.copyWith(
              fontWeight: FontWeight.w800,
              color: context.statusSuccessColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
