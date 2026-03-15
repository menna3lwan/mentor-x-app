import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import '../../widgets/quiz_ui.dart';

class QuizReviewPage extends StatelessWidget {
  const QuizReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    const timerText = '24:35';
    final answered = <int>{
      0,
      1,
      2,
      3,
      4,
      5,
      6,
      7,
      8,
      9,
      10,
      12,
      13,
      15,
      17,
      19,
    };
    const total = 20;
    const current = 7;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Column(
        children: [
          QuizHeader(
            title: t['reviewAnswers']!,
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                timerText,
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  QuizCard(
                    margin: EdgeInsets.zero,
                    padding: const EdgeInsets.all(16),
                    shadow: QuizCardShadow.sm,
                    borderRadius: QuizUi.radiusMd,
                    child: Column(
                      children: [
                        Text(
                          t['answeredCount']!,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.greyDark,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text.rich(
                          TextSpan(
                            text: '${answered.length} ',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primary,
                            ),
                            children: [
                              TextSpan(
                                text: '/ $total',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.grey,
                                ),
                              ),
                            ],
                          ),
                          textDirection: TextDirection.ltr,
                        ),
                        const SizedBox(height: 4),
                        if (total - answered.length > 0)
                          Text(
                            t
                                ['unansweredNote']!
                                .replaceAll('%s', '${total - answered.length}'),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.accent,
                            ),
                            textAlign: TextAlign.center,
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    t['jumpToQuestion']!,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 5,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 1,
                        ),
                    itemCount: total,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, i) {
                      final isCurrent = i == current;
                      final isAnswered = answered.contains(i);
                      final bg = isCurrent
                          ? AppColors.primary
                          : (isAnswered
                                ? AppColors.accent
                                : AppColors.greyLight);
                      final fg = isCurrent || isAnswered
                          ? Colors.white
                          : AppColors.greyDark;
                      return Container(
                        decoration: BoxDecoration(
                          color: bg,
                          borderRadius: BorderRadius.circular(QuizUi.radiusSm),
                        ),
                        child: Center(
                          child: Text(
                            '${i + 1}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: fg,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  QuizGradientButton(
                    label: t['submitQuiz']!,
                    onPressed: () => context.push('/quiz-result'),
                  ),
                  const SizedBox(height: 10),
                  QuizOutlineButton(
                    label: t['backToQuestions']!,
                    onPressed: () => Navigator.pop(context),
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
