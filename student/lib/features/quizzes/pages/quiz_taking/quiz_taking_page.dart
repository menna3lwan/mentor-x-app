import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:animate_do/animate_do.dart';
import 'bloc/quiz_taking_page_bloc.dart';

final class QuizTakingPage extends StatefulWidget {
  const QuizTakingPage({super.key});
  @override
  State<QuizTakingPage> createState() => _QuizTakingPageState();
}

final class _QuizTakingPageState extends State<QuizTakingPage> {
  int _remainingSeconds = 0;
  Timer? _timer;
  bool _timerInitialized = false;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer(int seconds) {
    if (_timerInitialized) return;
    _remainingSeconds = seconds;
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
    final t = context.t.quizzes;

    return BlocConsumer<QuizTakingPageBloc, QuizTakingPageState>(
      listener: (context, state) {
        if (state.remainingSeconds != null && !_timerInitialized) {
          _startTimer(state.remainingSeconds!);
        }
        if (state.isSuccess && state.result != null) {
          QuizResultPageRoute(attemptId: state.result!.id).go(context);
        }
      },

      builder: (context, state) {
        if (state.isLoading) {
          return Scaffold(
            backgroundColor: context.backgroundPrimaryColor,
            body: Column(
              children: [
                const MentorXSkeleton(height: 150, borderRadius: 32),
                const Gap(32),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const MentorXSkeleton(height: 200, borderRadius: 28),
                        const Gap(32),
                        ...List.generate(
                          3,
                          (index) => const Padding(
                            padding: EdgeInsets.only(bottom: 12),
                            child: MentorXSkeleton(
                              height: 72,
                              borderRadius: 24,
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

        if (state.errorMessage != null) {
          final isAlreadyAttempted = state.errorMessage == 'alreadyAttempted';
          return Scaffold(
            backgroundColor: context.backgroundPrimaryColor,
            body: isAlreadyAttempted
                ? AppEmptyView(
                    title: t.alreadyAttempted,
                    message: t.alreadyAttemptedDesc,
                    icon: Icons.check_circle_outline_rounded,
                    actionLabel: t.commonBack,
                    onAction: () => Navigator.of(context).pop(),
                  )
                : AppErrorView(
                    message: state.errorMessage!,
                    onRetry: () => context.read<QuizTakingPageBloc>().add(
                      const QuizTakingPageLoadEvent(),
                    ),
                  ),
          );
        }

        if (state.quiz == null) {
          return Scaffold(
            backgroundColor: context.backgroundPrimaryColor,
            body: AppEmptyView(
              title: t.quizNotFound,
              message: 'Try again later',
            ),
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
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
          ),
          child: PopScope(
            canPop: false,
            child: Scaffold(
              backgroundColor: context.backgroundPrimaryColor,
              body: Column(
                children: [
                  _BuildHeader(
                    title: state.quiz!.title,
                    timerText: _timerText,
                    showTimer: state.quiz!.timeRestricted,
                    progress: progress,
                    current: currentQuestionIndex + 1,
                    total: totalQuestions,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
                      child: q != null
                          ? _QuestionCard(
                              q: q,
                              current: currentQuestionIndex + 1,
                              total: totalQuestions,
                              selectedAnswer: state.answers[q.id],
                            )
                          : Center(
                              child: Text(
                                t.noQuestions,
                                style: context.bodySecondaryStyle.copyWith(
                                  color: context.textTertiaryColor,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                    ),
                  ),
                  _BuildNavigation(
                    isFirst: currentQuestionIndex == 0,
                    isLast: currentQuestionIndex == totalQuestions - 1,
                    isSubmitting: state.isSubmitting,
                    quizId: state.quizId,
                    attemptId: state.attemptId,
                    answers: state.answers,
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

  const _BuildHeader({
    required this.title,
    required this.timerText,
    required this.showTimer,
    required this.progress,
    required this.current,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        12,
        MediaQuery.paddingOf(context).top + 8,
        12,
        24,
      ),
      decoration: BoxDecoration(
        color: context.backgroundPrimaryColor.withValues(alpha: 0.8),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        border: Border(
          bottom: BorderSide(
            color: context.borderPrimaryColor.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
          child: Column(
            children: [
              Row(
                children: [
                  MentorXIconButton(
                    onPressed: () => showExitDialog(context),
                    icon: Icons.close_rounded,
                    variant: MentorXIconButtonVariant.outline,
                    size: MentorXIconButtonSize.small,
                  ),
                  const Gap(16),
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.titleH3Style.copyWith(
                        fontWeight: FontWeight.w900,
                        letterSpacing: -0.5,
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
                        color: context.backgroundPrimaryColor.withValues(
                          alpha: 0.4,
                        ),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: context.borderPrimaryColor.withValues(
                            alpha: 0.1,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.timer_outlined,
                            color: context.brandPrimaryColor,
                            size: 14,
                          ),
                          const Gap(6),
                          Text(
                            timerText,
                            style: context.bodySecondaryStyle.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                              color: context.textPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(12),
                  ],
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: context.backgroundPrimaryColor.withValues(
                        alpha: 0.4,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: context.borderPrimaryColor.withValues(
                          alpha: 0.1,
                        ),
                      ),
                    ),
                    child: Text(
                      '$current / $total',
                      style: context.bodySecondaryStyle.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        color: context.textPrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Stack(
                  children: [
                    Container(
                      height: 8,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: context.backgroundPrimaryColor.withValues(
                          alpha: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    AnimatedFractionallySizedBox(
                      duration: const Duration(milliseconds: 300),
                      widthFactor: progress.clamp(0.0, 1.0),
                      child: Container(
                        height: 8,
                        decoration: BoxDecoration(
                          color: context.brandPrimaryColor,
                          borderRadius: BorderRadius.circular(4),
                          boxShadow: [
                            BoxShadow(
                              color: context.brandPrimaryColor.withValues(
                                alpha: 0.3,
                              ),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showExitDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: context.backgroundSecondaryColor.withValues(
          alpha: 0.9,
        ),
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(
          context.t.quizzes.exitQuizTitle,
          style: context.titleH3Style.copyWith(
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
          ),
        ),
        content: Text(
          context.t.quizzes.exitQuizDesc,
          style: context.bodySecondaryStyle.copyWith(
            color: context.textSecondaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),

        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              context.t.quizzes.cancel,
              style: context.bodySecondaryStyle.copyWith(
                color: context.textTertiaryColor,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          SizedBox(
            width: 120,
            child: MentorXButton(
              onPressed: () {
                Navigator.pop(ctx);
                Navigator.pop(context);
              },
              label: context.t.quizzes.exit,
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

  const _QuestionCard({
    required this.q,
    required this.current,
    required this.total,
    required this.selectedAnswer,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.t.quizzes;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MentorXGlassCard(
          style: Style(
            $box.padding.all(24),
            $box.borderRadius(28),
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
                      color: context.brandPrimaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${t.questionLabel} $current',
                      style: context.bodySecondaryStyle.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.w900,
                        color: context.brandPrimaryColor,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(20),
              Text(
                q.description,
                style: context.titleH3Style.copyWith(
                  fontWeight: FontWeight.w900,
                  height: 1.5,
                  letterSpacing: -0.2,
                ),
              ),
              if (q.imageUrl != null) ...[
                const Gap(24),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: AppDynamicImage(
                    q.imageUrl!,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ],
          ),
        ),
        const Gap(32),
        Text(
          t.chooseCorrect,
          style: context.bodyPrimaryStyle.copyWith(
            fontWeight: FontWeight.w900,
            color: context.textSecondaryColor,
            letterSpacing: -0.2,
          ),
        ),
        const Gap(16),
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
          ),
      ],
    );
  }
}

class _TextAnswerField extends StatefulWidget {
  final String questionId;
  final String? initialValue;
  final bool isLong;

  const _TextAnswerField({
    required this.questionId,
    required this.initialValue,
    required this.isLong,
  });

  @override
  State<_TextAnswerField> createState() => _TextAnswerFieldState();
}

class _TextAnswerFieldState extends State<_TextAnswerField> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void didUpdateWidget(_TextAnswerField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.questionId != widget.questionId) {
      controller.text = widget.initialValue ?? '';
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MentorXGlassCard(
      style: Style(
        $box.borderRadius(28),
      ),
      child: MentorXTextFormField(
        controller: controller,
        prefixIcon: Icons.edit_note_rounded,
        label: context.t.quizzes.yourAnswer,
        hintText: context.t.quizzes.typeAnswerHere,
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
  final VoidCallback onTap;

  const _OptionTile({
    required this.label,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            color: isSelected
                ? null
                : context.backgroundSecondaryColor.withValues(alpha: 0.45),
            gradient: isSelected
                ? LinearGradient(
                    colors: [
                      context.brandPrimaryColor,
                      context.brandPrimaryColor.withValues(alpha: 0.8),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: isSelected
                  ? context.brandPrimaryColor.withValues(alpha: 0.5)
                  : context.borderPrimaryColor.withValues(alpha: 0.1),
              width: 1.5,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.white.withValues(alpha: 0.2)
                            : context.backgroundPrimaryColor.withValues(
                                alpha: 0.5,
                              ),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? Colors.white.withValues(alpha: 0.4)
                              : context.borderPrimaryColor.withValues(
                                  alpha: 0.1,
                                ),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          label,
                          style: context.bodyPrimaryStyle.copyWith(
                            fontWeight: FontWeight.w900,
                            color: isSelected
                                ? Colors.white
                                : context.textPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                    const Gap(16),
                    Expanded(
                      child: Text(
                        text,
                        style: context.bodyPrimaryStyle.copyWith(
                          fontWeight: isSelected
                              ? FontWeight.w900
                              : FontWeight.w700,
                          color: isSelected
                              ? Colors.white
                              : context.textPrimaryColor,
                        ),
                      ),
                    ),
                    if (isSelected)
                      FadeInRight(
                        duration: const Duration(milliseconds: 300),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.check_rounded,
                            color: context.brandPrimaryColor,
                            size: 16,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
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
  final String quizId;
  final String? attemptId;
  final Map<String, String> answers;

  const _BuildNavigation({
    required this.isFirst,
    required this.isLast,
    required this.isSubmitting,
    required this.quizId,
    required this.attemptId,
    required this.answers,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.t.quizzes;
    return MentorXGlassCard(
      style: Style(
        $box.borderRadius.top(32),
        $box.padding.only(
          left: 20,
          top: 16,
          right: 20,
          bottom: MediaQuery.paddingOf(context).bottom + 16,
        ),
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
                label: t.commonPrevious,
                variant: MentorXButtonVariant.outline,
              ),
            ),
            const Gap(12),
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
                  if (attemptId != null) {
                    () async {
                      final targetIndex = await QuizReviewPageRoute(
                        quizId: quizId,
                        attemptId: attemptId!,
                        $extra: answers,
                      ).push<int>(context);
                      if (targetIndex != null && context.mounted) {
                        context.read<QuizTakingPageBloc>().add(
                          QuizTakingPageJumpToQuestion(targetIndex),
                        );
                      }
                    }();
                  }
                }
              },
              label: isLast ? t.reviewAnswers : t.commonNext,
              size: MentorXButtonSize.large,
            ),
          ),
        ],
      ),
    );
  }
}
