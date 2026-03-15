import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import '../../widgets/quiz_ui.dart';

class QuizIntroPage extends StatelessWidget {
  const QuizIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Column(
        children: [
          QuizHeader(title: t['quizUnitTitle']!),
          Expanded(
            child: SingleChildScrollView(
              child: QuizCard(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        color: AppColors.background,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.fact_check_outlined,
                        size: 40,
                        color: AppColors.accent,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      t['quizTitle']!,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      t['quizSubtitle']!,
                      style: TextStyle(fontSize: 13, color: AppColors.greyDark),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: 2.1,
                      children: [
                        _InfoItem(value: '20', label: t['questionCount']!),
                        _InfoItem(
                          value: '30 ${t['minutesShort']!}',
                          label: t['duration']!,
                        ),
                        _InfoItem(value: '60%', label: t['passGrade']!),
                        _InfoItem(value: '3', label: t['attempts']!),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(QuizUi.radiusSm),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            t['instructions']!,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.accent,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '• ${t['instructionRead']!}\n'
                            '• ${t['instructionReview']!}\n'
                            '• ${t['instructionNoReturn']!}',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.greyDark,
                              height: 1.8,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    QuizGradientButton(
                      label: t['startQuiz']!,
                      onPressed: () => context.push('/quiz-taking'),
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
}

class _InfoItem extends StatelessWidget {
  const _InfoItem({required this.value, required this.label});
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundLight,
        borderRadius: BorderRadius.circular(QuizUi.radiusSm),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: AppColors.primary,
            ),
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
    );
  }
}
