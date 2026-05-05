import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

class QuizAnswersReviewPage extends StatelessWidget {
  const QuizAnswersReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final palette = MentorXThemeColorPalette.light;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    // Mock data for UI demonstration
    final answers = List.generate(
      10,
      (i) => (
        i % 3 != 0, // isCorrect
        isAr
            ? '${i + 1}. \u0645\u0627 \u0647\u064A \u0648\u062D\u062F\u0629 \u0642\u064A\u0627\u0633 \u0627\u0644\u062A\u0631\u062F\u062F\u061F'
            : '${i + 1}. What is the unit of frequency?',
        'Option ${i % 2 == 0 ? "A" : "B"}', // userAnswer
        'Option A', // correctAnswer
      ),
    );

    return Scaffold(
      backgroundColor: palette.backgroundSecondary,
      body: Column(
        children: [
          // Premium Header
          _BuildHeader(palette: palette, t: t),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 24),
              itemCount: answers.length,
              itemBuilder: (context, i) {
                final (isCorrect, question, userAnswer, correctAnswer) =
                    answers[i];
                return _AnswerReviewCard(
                  question: question,
                  userAnswer: userAnswer,
                  correctAnswer: correctAnswer,
                  isCorrect: isCorrect,
                  palette: palette,
                  t: t,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _BuildHeader extends StatelessWidget {
  final MentorXThemeColorPalette palette;
  final dynamic t;

  const _BuildHeader({
    required this.palette,
    required this.t,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10,
        bottom: 20,
        left: 20,
        right: 20,
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
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
          Expanded(
            child: Text(
              t['reviewAnswers'] ?? 'Review Answers',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 48), // Spacer for centering
        ],
      ),
    );
  }
}

class _AnswerReviewCard extends StatelessWidget {
  final String question;
  final String userAnswer;
  final String correctAnswer;
  final bool isCorrect;
  final MentorXThemeColorPalette palette;
  final dynamic t;

  const _AnswerReviewCard({
    required this.question,
    required this.userAnswer,
    required this.correctAnswer,
    required this.isCorrect,
    required this.palette,
    required this.t,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(24, 0, 24, 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color:
                      (isCorrect ? palette.statusSuccess : palette.statusDanger)
                          .withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isCorrect ? Icons.check_rounded : Icons.close_rounded,
                  size: 16,
                  color: isCorrect
                      ? palette.statusSuccess
                      : palette.statusDanger,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  question,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: palette.textPrimary,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // User Answer
          _InfoTile(
            label: t['yourAnswer'] ?? 'Your Answer',
            value: userAnswer,
            icon: isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
            color: isCorrect ? palette.statusSuccess : palette.statusDanger,
            palette: palette,
          ),

          if (!isCorrect) ...[
            const SizedBox(height: 12),
            // Correct Answer
            _InfoTile(
              label: t['correctAnswer'] ?? 'Correct Answer',
              value: correctAnswer,
              icon: Icons.check_circle_rounded,
              color: palette.statusSuccess,
              palette: palette,
            ),
          ],
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Color color;
  final MentorXThemeColorPalette palette;

  const _InfoTile({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
    required this.palette,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    color: color.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: color,
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
