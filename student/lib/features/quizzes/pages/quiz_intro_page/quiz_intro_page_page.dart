import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:flutter/services.dart';

class QuizIntroPage extends StatelessWidget {
  const QuizIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;
    final t = context.t.student;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: palette.brandPrimary,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: palette.backgroundSecondary,
        body: Column(
          children: [
            _BuildHeader(palette: palette, t: t),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    _BuildContentCard(palette: palette, t: t),
                    const SizedBox(height: 32),
                    MentorXButton(
                      text: t['startQuiz']!,
                      onPressed: () => context.push('/quiz-taking'),
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                      onPressed: () => context.pop(),
                      child: Text(
                        t['commonBack']!,
                        style: TextStyle(
                          color: palette.textTertiary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BuildHeader extends StatelessWidget {
  final MentorXThemeColorPalette palette;
  final dynamic t;

  const _BuildHeader({required this.palette, required this.t});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        24,
        MediaQuery.paddingOf(context).top + 16,
        24,
        32,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [palette.brandPrimary, palette.brandPrimary.withOpacity(0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: palette.brandPrimary.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
              ),
              const Spacer(),
              Text(
                t['quizUnitTitle'] ?? 'Unit Quiz',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const Spacer(),
              const SizedBox(width: 48), // Balance for back button
            ],
          ),
          const SizedBox(height: 24),
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white.withOpacity(0.3), width: 2),
            ),
            child: const Icon(Icons.fact_check_rounded, size: 40, color: Colors.white),
          ),
          const SizedBox(height: 16),
          Text(
            t['quizTitle'] ?? 'Final Assessment',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            t['quizSubtitle'] ?? 'Test your knowledge of this unit',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _BuildContentCard extends StatelessWidget {
  final MentorXThemeColorPalette palette;
  final dynamic t;

  const _BuildContentCard({required this.palette, required this.t});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 20, offset: const Offset(0, 10)),
        ],
      ),
      child: Column(
        children: [
          GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: 2.2,
            children: [
              _InfoItem(value: '20', label: t['questionCount']!, palette: palette),
              _InfoItem(value: '30 ${t['minutesShort']!}', label: t['duration']!, palette: palette),
              _InfoItem(value: '60%', label: t['passGrade']!, palette: palette),
              _InfoItem(value: '3', label: t['attempts']!, palette: palette),
            ],
          ),
          const SizedBox(height: 24),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: palette.backgroundSecondary,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: palette.brandPrimary.withOpacity(0.05)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info_outline_rounded, size: 18, color: palette.brandPrimary),
                    const SizedBox(width: 10),
                    Text(
                      t['instructions'] ?? 'Instructions',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                        color: palette.brandPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  '• ${t['instructionRead']!}\n'
                  '• ${t['instructionReview']!}\n'
                  '• ${t['instructionNoReturn']!}',
                  style: TextStyle(
                    fontSize: 13,
                    color: palette.textSecondary,
                    height: 1.8,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final String value;
  final String label;
  final MentorXThemeColorPalette palette;

  const _InfoItem({required this.value, required this.label, required this.palette});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: palette.backgroundSecondary,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: palette.brandPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: palette.textTertiary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
