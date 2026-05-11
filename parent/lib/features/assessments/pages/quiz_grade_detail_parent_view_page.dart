import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import '../bloc/assessments_bloc.dart';

final class QuizGradeDetailParentViewPage extends StatelessWidget {
  final String assessmentId;

  const QuizGradeDetailParentViewPage({
    super.key,
    required this.assessmentId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssessmentsBloc, AssessmentsState>(
      builder: (context, state) {
        QuizAttemptEntity? attempt;
        for (final item in state.assessments) {
          if (item.id == assessmentId) {
            attempt = item;
            break;
          }
        }
        if (attempt == null) {
          return const AppDashboardScaffold(
            title: 'Quiz Detail',
            body: Center(child: Text('Quiz attempt not found.')),
          );
        }

        return AppDashboardScaffold(
          title: 'Quiz Detail',
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInDown(
                  duration: const Duration(milliseconds: 600),
                  child: AppHeroCard(
                    title: 'QUIZ SCORE',
                    icon: Icons.quiz_rounded,
                    stats: [
                      AppHeroStatItem(
                        label: 'Score',
                        value: '${attempt.score}/${attempt.totalMarks}',
                        onTap: () {},
                      ),
                      AppHeroStatItem(
                        label: 'Percentage',
                        value: '${attempt.percentage.toInt()}%',
                        onTap: () {},
                      ),
                      AppHeroStatItem(
                        label: 'Result',
                        value: attempt.passed ? 'PASS' : 'FAIL',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                const Gap(32),
                
                FadeInLeft(
                  duration: const Duration(milliseconds: 500),
                  child: const AppSectionHeader(title: 'Question Breakdown'),
                ),
                const Gap(16),
                
                ...List.generate(6, (index) {
                  final isCorrect = index.isEven;
                  final color = isCorrect ? context.statusSuccessColor : context.statusDangerColor;
                  
                  return FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    delay: Duration(milliseconds: 50 * index),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: context.backgroundSecondaryColor,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: context.textTertiaryColor.withValues(alpha: 0.1)),
                      ),
                      child: ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: color.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isCorrect ? Icons.check_rounded : Icons.close_rounded,
                            color: color,
                            size: 16,
                          ),
                        ),
                        title: Text(
                          'Question ${index + 1}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: context.textPrimaryColor,
                          ),
                        ),
                        subtitle: Text(
                          isCorrect ? 'Correct Answer' : 'Incorrect Answer',
                          style: TextStyle(
                            fontSize: 12,
                            color: context.textSecondaryColor,
                          ),
                        ),
                        trailing: Text(
                          isCorrect ? '+1.0' : '0.0',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: color,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
                
                const Gap(40),
              ],
            ),
          ),
        );
      },
    );
  }
}
