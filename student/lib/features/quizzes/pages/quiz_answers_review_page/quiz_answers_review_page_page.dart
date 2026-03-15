import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import '../../widgets/quiz_ui.dart';

class QuizAnswersReviewPage extends StatelessWidget {
  const QuizAnswersReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final answers = List.generate(
      20,
      (i) => (
        i < 18,
        isAr
            ? '${i + 1}. \u0645\u0627 \u0647\u064A \u0648\u062D\u062F\u0629 \u0642\u064A\u0627\u0633 \u0627\u0644\u062A\u0631\u062F\u062F\u061F'
            : '${i + 1}. What is the unit of frequency?',
        'Option ${i % 4 == 0 ? "A" : "B"}',
        'Option A',
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Column(
        children: [
          QuizHeader(title: t['reviewAnswers']!),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemCount: answers.length,
              itemBuilder: (context, i) {
                final (isCorrect, question, userAnswer, correctAnswer) =
                    answers[i];
                return Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(QuizUi.radiusMd),
                    boxShadow: QuizUi.shadowSm,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isCorrect
                                  ? AppColors.greenLight
                                  : AppColors.redLight,
                            ),
                            child: Icon(
                              isCorrect ? Icons.check : Icons.close,
                              size: 16,
                              color: isCorrect
                                  ? AppColors.green
                                  : AppColors.red,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              question,
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: isCorrect
                              ? AppColors.greenLight
                              : AppColors.redLight,
                          borderRadius: BorderRadius.circular(QuizUi.radiusSm),
                        ),
                        child: Text(
                          '${t['yourAnswer']!} $userAnswer ${isCorrect ? '✓' : '✕'}',
                          style: TextStyle(
                            fontSize: 12,
                            color: isCorrect ? AppColors.green : AppColors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      if (!isCorrect) ...[
                        const SizedBox(height: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.greenLight,
                            borderRadius: BorderRadius.circular(
                              QuizUi.radiusSm,
                            ),
                          ),
                          child: Text(
                            '${t['correctAnswer']!} $correctAnswer',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.green,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
