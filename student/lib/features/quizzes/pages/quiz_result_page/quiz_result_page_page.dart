import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import '../../widgets/quiz_ui.dart';

class QuizResultPage extends StatelessWidget {
  const QuizResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    const total = 20;
    const correct = 18;
    const wrong = total - correct;
    const timeTaken = '5:25';
    const percent = correct / total;
    final resultLabel = percent >= 0.85
        ? t['excellent']!
        : (percent >= 0.60 ? t['veryGood']! : t['fail']!);

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Column(
        children: [
          QuizHeader(
            title: t['quizResult']!,
            showBack: false,
            centerTitle: true,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
              child: Column(
                children: [
                  QuizResultCircle(
                    correct: correct,
                    total: total,
                    label: resultLabel,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    t['greatResult']!,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${(percent * 100).toInt()}% - $resultLabel',
                    style: TextStyle(fontSize: 13, color: AppColors.greyDark),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      _StatBox(
                        value: '$correct',
                        label: t['correctAnswers']!,
                        color: AppColors.green,
                      ),
                      const SizedBox(width: 12),
                      _StatBox(
                        value: '$wrong',
                        label: t['wrongAnswers']!,
                        color: AppColors.red,
                      ),
                      const SizedBox(width: 12),
                      _StatBox(
                        value: timeTaken,
                        label: t['timeTaken']!,
                        color: AppColors.accent,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  QuizGradientButton(
                    label: t['reviewAnswers']!,
                    onPressed: () => context.push('/quiz-answers-review'),
                  ),
                  if (percent >= 0.85) ...[
                    const SizedBox(height: 10),
                    QuizGradientButton(
                      label: t['claimReward']!,
                      gradient: QuizUi.tealGradient,
                      onPressed: () => context.push('/quiz-rewards'),
                    ),
                  ],
                  const SizedBox(height: 10),
                  QuizOutlineButton(
                    label: t['commonBack']!,
                    onPressed: () => context.go('/'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  const _StatBox({
    required this.value,
    required this.label,
    required this.color,
  });
  final String value, label;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(QuizUi.radiusSm),
          boxShadow: QuizUi.shadowSm,
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: color,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.greyDark,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
