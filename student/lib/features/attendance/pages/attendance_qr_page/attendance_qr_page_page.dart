import 'dart:ui';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_student/core/core.dart';

final class AttendanceQrPage extends StatelessWidget {
  const AttendanceQrPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;

    return BlocBuilder<AppSessionCubit, AppSessionState>(
      builder: (context, state) {
        final code = state.studentCode.isNotEmpty ? state.studentCode : 'NO-CODE';

        return Scaffold(
          backgroundColor: context.backgroundPrimaryColor,
          body: Stack(
            children: [
              const _BackgroundDecorations(),
              Column(
                children: [
                  _BuildHeader(t: t),
                  Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FadeInDown(
                              duration: const Duration(milliseconds: 600),
                              child: _InfoCard(
                                t: t,
                                code: code,
                              ),
                            ),
                            const Gap(32),
                            ZoomIn(
                              duration: const Duration(milliseconds: 600),
                              delay: const Duration(milliseconds: 200),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
                                  borderRadius: BorderRadius.circular(40),
                                  border: Border.all(
                                    color: context.borderPrimaryColor.withValues(alpha: 0.1),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withValues(alpha: 0.05),
                                      blurRadius: 30,
                                      offset: const Offset(0, 15),
                                    ),
                                    BoxShadow(
                                      color: context.brandPrimaryColor.withValues(alpha: 0.05),
                                      blurRadius: 40,
                                      spreadRadius: -10,
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                    child: Padding(
                                      padding: const EdgeInsets.all(32),
                                      child: Column(
                                        children: [
                                          QrImageView(
                                            data: code,
                                            version: QrVersions.auto,
                                            size: 240,
                                            gapless: false,
                                            eyeStyle: QrEyeStyle(
                                              eyeShape: QrEyeShape.square,
                                              color: context.brandPrimaryColor,
                                            ),
                                            dataModuleStyle: QrDataModuleStyle(
                                              dataModuleShape: QrDataModuleShape.square,
                                              color: context.brandPrimaryColor.withValues(alpha: 0.9),
                                            ),
                                          ),
                                          const Gap(24),
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 24,
                                              vertical: 12,
                                            ),
                                            decoration: BoxDecoration(
                                              color: context.backgroundPrimaryColor.withValues(alpha: 0.4),
                                              borderRadius: BorderRadius.circular(16),
                                              border: Border.all(
                                                color: context.borderPrimaryColor.withValues(alpha: 0.1),
                                              ),
                                            ),
                                            child: Text(
                                              code,
                                              style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.w900,
                                                color: context.brandPrimaryColor,
                                                letterSpacing: 3,
                                              ),
                                              textDirection: TextDirection.ltr,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Gap(40),
                            FadeInUp(
                              duration: const Duration(milliseconds: 600),
                              delay: const Duration(milliseconds: 400),
                              child: _InstructionCard(t: t),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

final class _BuildHeader extends StatelessWidget {
  final dynamic t;

  const _BuildHeader({required this.t});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        24,
        MediaQuery.paddingOf(context).top + 16,
        24,
        24,
      ),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
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
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: context.textPrimaryColor,
                  size: 20,
                ),
              ),
              Expanded(
                child: Center(
                  child: Text(
                    t['registerAttendance']!,
                    style: TextStyle(
                      color: context.textPrimaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
              ),
              const Gap(48),
            ],
          ),
        ),
      ),
    );
  }
}

final class _InfoCard extends StatelessWidget {
  final dynamic t;
  final String code;

  const _InfoCard({
    required this.t,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      decoration: BoxDecoration(
        color: context.brandPrimaryColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: context.brandPrimaryColor.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: context.brandPrimaryColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.qr_code_scanner_rounded,
              color: context.brandPrimaryColor,
              size: 28,
            ),
          ),
          const Gap(16),
          Text(
            t['yourAttendanceCode']!,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: context.brandPrimaryColor,
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
    );
  }
}

final class _InstructionCard extends StatelessWidget {
  final dynamic t;

  const _InstructionCard({required this.t});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            t['showCodeInstruction']!,
            style: TextStyle(
              fontSize: 15,
              color: context.textSecondaryColor,
              fontWeight: FontWeight.w600,
              height: 1.6,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const Gap(24),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          decoration: BoxDecoration(
            color: context.statusWarningColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: context.statusWarningColor.withValues(alpha: 0.2)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.timer_outlined, color: context.statusWarningColor, size: 18),
              const Gap(10),
              Text(
                t['codeValidFor']!,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w800,
                  color: context.statusWarningColor,
                ),
              ),
            ],
          ),
        ),
      ],
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
            color: context.brandPrimaryColor.withValues(alpha: 0.12),
            size: 350,
          ),
        ),
        Positioned(
          top: 300,
          left: -150,
          child: _BlurredBlob(
            color: context.brandSecondaryColor.withValues(alpha: 0.08),
            size: 400,
          ),
        ),
        Positioned(
          bottom: -50,
          right: -100,
          child: _BlurredBlob(
            color: context.brandPrimaryColor.withValues(alpha: 0.1),
            size: 300,
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
