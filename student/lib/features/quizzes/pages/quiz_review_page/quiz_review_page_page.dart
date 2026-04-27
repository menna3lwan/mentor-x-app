import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

class QuizReviewPage extends StatelessWidget {
  const QuizReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final palette = MentorXThemeColorPalette.light;
    
    // Mock data for UI demonstration
    const timerText = '24:35';
    final answered = List.generate(16, (i) => i);
    const total = 20;

    return Scaffold(
      backgroundColor: palette.backgroundSecondary,
      body: Column(
        children: [
          // Premium Header
          _BuildHeader(palette: palette, t: t, timerText: timerText),
          
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Progress Overview Card
                  _BuildProgressOverview(
                    palette: palette, 
                    t: t, 
                    answeredCount: answered.length, 
                    totalCount: total,
                  ),
                  
                  const SizedBox(height: 32),
                  
                  Text(
                    t['jumpToQuestion'] ?? 'Jump to Question',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: palette.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Question Grid
                  GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 1,
                    ),
                    itemCount: total,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, i) {
                      final isAnswered = answered.contains(i);
                      return _QuestionStatusBox(
                        index: i + 1,
                        isAnswered: isAnswered,
                        palette: palette,
                      );
                    },
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Actions
                  MentorXButton(
                    onPressed: () => context.push('/quiz-result'),
                    text: t['submitQuiz'] ?? 'Submit Quiz',
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        side: BorderSide(color: palette.brandPrimary.withOpacity(0.2)),
                      ),
                      child: Text(
                        t['backToQuestions'] ?? 'Back to Questions',
                        style: TextStyle(
                          color: palette.brandPrimary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
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

class _BuildHeader extends StatelessWidget {
  final MentorXThemeColorPalette palette;
  final dynamic t;
  final String timerText;

  const _BuildHeader({
    required this.palette,
    required this.t,
    required this.timerText,
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
            icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white, size: 20),
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.white.withOpacity(0.2)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.timer_outlined, color: Colors.white, size: 14),
                const SizedBox(width: 6),
                Text(
                  timerText,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
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

class _BuildProgressOverview extends StatelessWidget {
  final MentorXThemeColorPalette palette;
  final dynamic t;
  final int answeredCount;
  final int totalCount;

  const _BuildProgressOverview({
    required this.palette,
    required this.t,
    required this.answeredCount,
    required this.totalCount,
  });

  @override
  Widget build(BuildContext context) {
    final unansweredCount = totalCount - answeredCount;
    
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            t['answeredCount'] ?? 'Answered Questions',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: palette.textTertiary,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '$answeredCount',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.w900,
                  color: palette.brandPrimary,
                ),
              ),
              Text(
                ' / $totalCount',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: palette.textTertiary.withOpacity(0.5),
                ),
              ),
            ],
          ),
          if (unansweredCount > 0) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: palette.statusWarning.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.warning_amber_rounded, size: 16, color: palette.statusWarning),
                  const SizedBox(width: 8),
                  Text(
                    t['unansweredNote']?.replaceAll('%s', '$unansweredCount') ?? '$unansweredCount questions left',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: palette.statusWarning,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _QuestionStatusBox extends StatelessWidget {
  final int index;
  final bool isAnswered;
  final MentorXThemeColorPalette palette;

  const _QuestionStatusBox({
    required this.index,
    required this.isAnswered,
    required this.palette,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isAnswered ? palette.brandPrimary : palette.backgroundPrimary,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isAnswered ? palette.brandPrimary : palette.textTertiary.withOpacity(0.1),
          width: 1.5,
        ),
        boxShadow: isAnswered ? [
          BoxShadow(
            color: palette.brandPrimary.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ] : null,
      ),
      child: Center(
        child: Text(
          '$index',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: isAnswered ? Colors.white : palette.textTertiary,
          ),
        ),
      ),
    );
  }
}
