import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_student/core/core.dart';

class AttendanceQrPage extends StatelessWidget {
  const AttendanceQrPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final palette = MentorXThemeColorPalette.light;
    
    return BlocBuilder<AppSessionCubit, AppSessionState>(
      builder: (context, state) {
        final code = state.studentCode.isNotEmpty ? state.studentCode : 'NO-CODE';

        return Scaffold(
          backgroundColor: palette.backgroundSecondary,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [palette.brandPrimary, palette.brandPrimary.withOpacity(0.8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: palette.brandPrimary.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                foregroundColor: Colors.white,
                centerTitle: true,
                title: Text(
                  t['registerAttendance']!,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ),
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _InfoCard(
                    palette: palette,
                    t: t,
                    code: code,
                  ),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        QrImageView(
                          data: code,
                          version: QrVersions.auto,
                          size: 220,
                          gapless: false,
                          eyeStyle: QrEyeStyle(
                            eyeShape: QrEyeShape.square,
                            color: palette.brandPrimary,
                          ),
                          dataModuleStyle: QrDataModuleStyle(
                            dataModuleShape: QrDataModuleShape.square,
                            color: palette.brandPrimary.withOpacity(0.8),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: palette.backgroundSecondary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            code,
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w900,
                              color: palette.brandPrimary,
                              letterSpacing: 2,
                            ),
                            textDirection: TextDirection.ltr,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  _InstructionCard(palette: palette, t: t),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _InfoCard extends StatelessWidget {
  final MentorXThemeColorPalette palette;
  final dynamic t;
  final String code;

  const _InfoCard({
    required this.palette,
    required this.t,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: palette.brandPrimary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: palette.brandPrimary.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Icon(Icons.qr_code_scanner_rounded, color: palette.brandPrimary, size: 32),
          const SizedBox(height: 12),
          Text(
            t['yourAttendanceCode']!,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: palette.brandPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _InstructionCard extends StatelessWidget {
  final MentorXThemeColorPalette palette;
  final dynamic t;

  const _InstructionCard({required this.palette, required this.t});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          t['showCodeInstruction']!,
          style: TextStyle(
            fontSize: 14,
            color: palette.textSecondary,
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.amber.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.amber.withOpacity(0.2)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.timer_outlined, color: Colors.amber, size: 18),
              const SizedBox(width: 8),
              Text(
                t['codeValidFor']!,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.amber,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
