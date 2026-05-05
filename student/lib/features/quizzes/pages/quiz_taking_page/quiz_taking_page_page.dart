import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_student/core/core.dart';
import 'bloc/quiz_taking_page_bloc.dart';

class QuizTakingPage extends StatefulWidget {
  const QuizTakingPage({super.key});
  @override
  State<QuizTakingPage> createState() => _QuizTakingPageState();
}

class _QuizTakingPageState extends State<QuizTakingPage> {
  int _remainingSeconds = 0;
  Timer? _timer;
  bool _timerInitialized = false;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer(int minutes) {
    if (_timerInitialized) return;
    _remainingSeconds = minutes * 60;
    _timerInitialized = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      if (_remainingSeconds <= 0) {
        _timer?.cancel();
        context.read<QuizTakingPageBloc>().add(const QuizTakingPageSubmit());
        return;
      }
      setState(() => _remainingSeconds--);
    });
  }

  String get _timerText {
    final m = _remainingSeconds ~/ 60;
    final s = _remainingSeconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;
    final t = context.t.student;

    return BlocConsumer<QuizTakingPageBloc, QuizTakingPageState>(
      listener: (context, state) {
        if (state.quiz != null && state.quiz!.timeRestricted) {
          _startTimer(state.quiz!.durationMinutes);
        }
        if (state.isSuccess && state.result != null) {
          QuizResultPageRoute(attemptId: state.result!.id).go(context);
        }
      },
      builder: (context, state) {
        if (state.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state.errorMessage != null) {
          return Scaffold(
            backgroundColor: palette.backgroundSecondary,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline_rounded,
                      size: 64,
                      color: palette.statusDanger.withOpacity(0.5),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      state.errorMessage!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: palette.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 32),
                    MentorXButton(
                      text: t['commonBack']!,
                      onPressed: () => context.pop(),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        if (state.quiz == null) {
          return Scaffold(
            backgroundColor: palette.backgroundSecondary,
            body: Center(child: Text(t['quizNotFound'] ?? 'Quiz not found')),
          );
        }

        final q = state.currentQuestion;
        final totalQuestions = state.questions.length;
        final currentQuestionIndex = state.currentQuestionIndex;
        final progress = totalQuestions > 0
            ? (currentQuestionIndex + 1) / totalQuestions
            : 0.0;

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light.copyWith(
            statusBarColor: palette.brandPrimary,
            statusBarIconBrightness: Brightness.light,
          ),
          child: PopScope(
            canPop: false,
            child: Scaffold(
              backgroundColor: palette.backgroundSecondary,
              body: Column(
                children: [
                  _BuildHeader(
                    title: state.quiz!.title,
                    timerText: _timerText,
                    showTimer: state.quiz!.timeRestricted,
                    progress: progress,
                    current: currentQuestionIndex + 1,
                    total: totalQuestions,
                    palette: palette,
                    t: t,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
                      child: q != null
                          ? _QuestionCard(
                              q: q,
                              current: currentQuestionIndex + 1,
                              total: totalQuestions,
                              selectedAnswer: state.answers[q.id],
                              palette: palette,
                              t: t,
                            )
                          : Center(
                              child: Text(
                                t['noQuestions'] ?? 'No questions available',
                                style: TextStyle(color: palette.textTertiary),
                              ),
                            ),
                    ),
                  ),
                  _BuildNavigation(
                    isFirst: currentQuestionIndex == 0,
                    isLast: currentQuestionIndex == totalQuestions - 1,
                    isSubmitting: state.isSubmitting,
                    palette: palette,
                    t: t,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _BuildHeader extends StatelessWidget {
  final String title;
  final String timerText;
  final bool showTimer;
  final double progress;
  final int current;
  final int total;
  final MentorXThemeColorPalette palette;
  final dynamic t;

  const _BuildHeader({
    required this.title,
    required this.timerText,
    required this.showTimer,
    required this.progress,
    required this.current,
    required this.total,
    required this.palette,
    required this.t,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        20,
        MediaQuery.paddingOf(context).top + 16,
        20,
        24,
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
                onPressed: () => _showExitDialog(context, t, palette),
                icon: const Icon(Icons.close_rounded, color: Colors.white),
              ),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              if (showTimer) ...[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.timer_outlined,
                        color: Colors.white,
                        size: 14,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        timerText,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
              ],
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '$current / $total',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Stack(
            children: [
              Container(
                height: 8,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              AnimatedFractionallySizedBox(
                duration: const Duration(milliseconds: 300),
                widthFactor: progress.clamp(0.0, 1.0),
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.3),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showExitDialog(
    BuildContext context,
    dynamic t,
    MentorXThemeColorPalette palette,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(
          t['exitQuizTitle'] ?? 'Exit Quiz?',
          style: const TextStyle(fontWeight: FontWeight.w900),
        ),
        content: Text(
          t['exitQuizDesc'] ??
              'Your progress will not be saved. Are you sure you want to exit?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(t['cancel'] ?? 'Cancel'),
          ),
          SizedBox(
            width: 100,
            child: MentorXButton(
              onPressed: () {
                Navigator.pop(ctx);
                Navigator.pop(context);
              },
              text: t['exit'] ?? 'Exit',
            ),
          ),
        ],
      ),
    );
  }
}

class _QuestionCard extends StatelessWidget {
  final QuizQuestionEntity q;
  final int current;
  final int total;
  final String? selectedAnswer;
  final MentorXThemeColorPalette palette;
  final dynamic t;

  const _QuestionCard({
    required this.q,
    required this.current,
    required this.total,
    required this.selectedAnswer,
    required this.palette,
    required this.t,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: palette.brandPrimary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'QUESTION $current',
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: palette.brandPrimary,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                q.text,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: palette.textPrimary,
                  height: 1.6,
                ),
              ),
              if (q.imageUrl != null) ...[
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    q.imageUrl!,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 32),
        Text(
          t['chooseCorrect'] ?? 'Choose the correct answer:',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w900,
            color: palette.textSecondary,
          ),
        ),
        const SizedBox(height: 16),
        if (q.type == QuizQuestionType.multipleChoice ||
            q.type == QuizQuestionType.trueFalse)
          ...q.options.asMap().entries.map((entry) {
            final optionIndex = entry.key;
            final optionText = entry.value;
            final labels = ['A', 'B', 'C', 'D', 'E', 'F'];
            final label = optionIndex < labels.length
                ? labels[optionIndex]
                : (optionIndex + 1).toString();
            final isSelected = selectedAnswer == optionText;

            return _OptionTile(
              label: label,
              text: optionText,
              isSelected: isSelected,
              palette: palette,
              onTap: () => context.read<QuizTakingPageBloc>().add(
                QuizTakingPageAnswerSelected(
                  questionId: q.id,
                  selectedAnswer: optionText,
                ),
              ),
            );
          })
        else if (q.type == QuizQuestionType.shortAnswer ||
            q.type == QuizQuestionType.essay)
          _TextAnswerField(
            questionId: q.id,
            initialValue: selectedAnswer,
            isLong: q.type == QuizQuestionType.essay,
            palette: palette,
            t: t,
          ),
      ],
    );
  }
}

class _TextAnswerField extends StatefulWidget {
  final String questionId;
  final String? initialValue;
  final bool isLong;
  final MentorXThemeColorPalette palette;
  final dynamic t;

  const _TextAnswerField({
    required this.questionId,
    required this.initialValue,
    required this.isLong,
    required this.palette,
    required this.t,
  });

  @override
  State<_TextAnswerField> createState() => _TextAnswerFieldState();
}

class _TextAnswerFieldState extends State<_TextAnswerField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void didUpdateWidget(_TextAnswerField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.questionId != widget.questionId) {
      _controller.text = widget.initialValue ?? '';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: MentorXTextFormField(
        controller: _controller,
        icon: Icons.edit_note_rounded,
        label: widget.t['yourAnswer'] ?? 'Your Answer',
        hint: widget.t['typeAnswerHere'] ?? 'Type your answer here...',
        maxLines: widget.isLong ? 6 : 1,
        onChanged: (value) {
          context.read<QuizTakingPageBloc>().add(
            QuizTakingPageAnswerSelected(
              questionId: widget.questionId,
              selectedAnswer: value,
            ),
          );
        },
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  final String label;
  final String text;
  final bool isSelected;
  final MentorXThemeColorPalette palette;
  final VoidCallback onTap;

  const _OptionTile({
    required this.label,
    required this.text,
    required this.isSelected,
    required this.palette,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected
                  ? palette.brandPrimary.withOpacity(0.05)
                  : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected ? palette.brandPrimary : Colors.transparent,
                width: 2,
              ),
              boxShadow: [
                if (!isSelected)
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? palette.brandPrimary
                        : palette.backgroundSecondary,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w900,
                        color: isSelected
                            ? Colors.white
                            : palette.textSecondary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: isSelected
                          ? FontWeight.w800
                          : FontWeight.w600,
                      color: isSelected
                          ? palette.brandPrimary
                          : palette.textPrimary,
                    ),
                  ),
                ),
                if (isSelected)
                  Icon(
                    Icons.check_circle_rounded,
                    color: palette.brandPrimary,
                    size: 24,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BuildNavigation extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isSubmitting;
  final MentorXThemeColorPalette palette;
  final dynamic t;

  const _BuildNavigation({
    required this.isFirst,
    required this.isLast,
    required this.isSubmitting,
    required this.palette,
    required this.t,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          if (!isFirst) ...[
            Expanded(
              flex: 1,
              child: MentorXButton(
                onPressed: () => context.read<QuizTakingPageBloc>().add(
                  const QuizTakingPagePreviousQuestion(),
                ),
                text: t['commonPrevious']!,
              ),
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            flex: 2,
            child: MentorXButton(
              loading: isSubmitting,
              onPressed: () {
                if (!isLast) {
                  context.read<QuizTakingPageBloc>().add(
                    const QuizTakingPageNextQuestion(),
                  );
                } else {
                  context.read<QuizTakingPageBloc>().add(
                    const QuizTakingPageSubmit(),
                  );
                }
              },
              text: isLast ? t['review']! : t['commonNext']!,
            ),
          ),
        ],
      ),
    );
  }
}
