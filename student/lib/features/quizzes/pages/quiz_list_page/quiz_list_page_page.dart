import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import '../../widgets/quiz_ui.dart';

class _QuizItem {
  final String titleEn, titleAr, unitEn, unitAr;
  final int questionCount, durationMin;
  final bool isCompleted;
  final int? score;
  _QuizItem({
    required this.titleEn,
    required this.titleAr,
    required this.unitEn,
    required this.unitAr,
    required this.questionCount,
    required this.durationMin,
    this.isCompleted = false,
    this.score,
  });
}

class QuizListPage extends StatelessWidget {
  const QuizListPage({super.key});

  List<_QuizItem> get _quizzes => [
    _QuizItem(
      titleEn: 'Mechanics Quiz',
      titleAr:
          '\u0643\u0648\u064A\u0632 \u0627\u0644\u0645\u064A\u0643\u0627\u0646\u064A\u0643\u0627',
      unitEn: 'Unit 1',
      unitAr: '\u0627\u0644\u0648\u062D\u062F\u0629 1',
      questionCount: 20,
      durationMin: 30,
      isCompleted: true,
      score: 85,
    ),
    _QuizItem(
      titleEn: 'Electricity Quiz',
      titleAr:
          '\u0643\u0648\u064A\u0632 \u0627\u0644\u0643\u0647\u0631\u0628\u064A\u0629',
      unitEn: 'Unit 2',
      unitAr: '\u0627\u0644\u0648\u062D\u062F\u0629 2',
      questionCount: 20,
      durationMin: 30,
      isCompleted: true,
      score: 70,
    ),
    _QuizItem(
      titleEn: 'Waves Quiz',
      titleAr:
          '\u0643\u0648\u064A\u0632 \u0627\u0644\u0645\u0648\u062C\u0627\u062A',
      unitEn: 'Unit 3',
      unitAr: '\u0627\u0644\u0648\u062D\u062F\u0629 3',
      questionCount: 20,
      durationMin: 30,
    ),
    _QuizItem(
      titleEn: 'Dynamics Quiz',
      titleAr:
          '\u0643\u0648\u064A\u0632 \u0627\u0644\u062F\u064A\u0646\u0627\u0645\u064A\u0643\u0627',
      unitEn: 'Unit 4',
      unitAr: '\u0627\u0644\u0648\u062D\u062F\u0629 4',
      questionCount: 20,
      durationMin: 30,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    return Column(
      children: [
        QuizHeader(
          title: t['navQuizzes']!,
          showBack: false,
          centerTitle: true,
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _quizzes.length,
            itemBuilder: (context, index) {
              final quiz = _quizzes[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      if (quiz.isCompleted) {
                        context.push('/quiz-result');
                      } else {
                        context.push('/quiz-intro');
                      }
                    },
                    borderRadius: BorderRadius.circular(QuizUi.radiusLg),
                    child: Ink(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(QuizUi.radiusLg),
                        boxShadow: QuizUi.shadowSm,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                              color: quiz.isCompleted
                                  ? AppColors.greenLight
                                  : AppColors.accent.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(
                                QuizUi.radiusMd,
                              ),
                            ),
                            child: Icon(
                              quiz.isCompleted
                                  ? Icons.check_circle
                                  : Icons.quiz_outlined,
                              color: quiz.isCompleted
                                  ? AppColors.green
                                  : AppColors.accent,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  isAr ? quiz.titleAr : quiz.titleEn,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primary,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  '${isAr ? quiz.unitAr : quiz.unitEn} - ${quiz.questionCount} ${t['questions']!} - ${quiz.durationMin} ${t['minutesShort']!}',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: AppColors.greyDark,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (quiz.isCompleted && quiz.score != null)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: quiz.score! >= 60
                                    ? AppColors.greenLight
                                    : AppColors.redLight,
                                borderRadius: BorderRadius.circular(
                                  QuizUi.radiusSm,
                                ),
                              ),
                              child: Text(
                                '${quiz.score}%',
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: quiz.score! >= 60
                                      ? AppColors.green
                                      : AppColors.red,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
