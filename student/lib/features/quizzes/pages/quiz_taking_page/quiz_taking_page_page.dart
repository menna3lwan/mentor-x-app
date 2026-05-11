import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:gap/gap.dart';
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
          return Scaffold(
            backgroundColor: context.backgroundPrimaryColor,
            body: const Center(child: CircularProgressIndicator()),
          );
        }

        if (state.errorMessage != null) {
          return Scaffold(
            backgroundColor: context.backgroundPrimaryColor,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline_rounded,
                      size: 64,
                      color: context.statusDangerColor.withValues(alpha: 0.5),
                    ),
                    const Gap(24),
                    Text(
                      state.errorMessage!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: context.textSecondaryColor,
                      ),
                    ),
                    const Gap(32),
                    SizedBox(
                      width: 140,
                      child: MentorXButton(
                        label: t['commonBack']!,
                        onPressed: () => context.pop(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        if (state.quiz == null) {
          return Scaffold(
            backgroundColor: context.backgroundPrimaryColor,
            body: Center(
              child: Text(
                t['quizNotFound'] ?? 'Quiz not found',
                style: TextStyle(
                  color: context.textPrimaryColor,
                  fontWeight: FontWeight.w900,
                ),
              ),
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
              body: Stack(
                children: [
                  const _BackgroundDecorations(),
                  Column(
                    children: [
                      _BuildHeader(
                        title: state.quiz!.title,
                        timerText: _timerText,
                        showTimer: state.quiz!.timeRestricted,
                        progress: progress,
                        current: currentQuestionIndex + 1,
                        total: totalQuestions,
                        t: t,
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
                                  t: t,
                                )
                              : Center(
                                  child: Text(
                                    t['noQuestions'] ??
                                        'No questions available',
                                    style: TextStyle(
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
                        t: t,
                      ),
                    ],
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

final class _BuildHeader extends StatelessWidget {
  final String title;
  final String timerText;
  final bool showTimer;
  final double progress;
  final int current;
  final int total;
  final dynamic t;

  const _BuildHeader({
    required this.title,
    required this.timerText,
    required this.showTimer,
    required this.progress,
    required this.current,
    required this.total,
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
        color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
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
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => _showExitDialog(context, t),
                    icon: Icon(
                      Icons.close_rounded,
                      color: context.textPrimaryColor,
                    ),
                  ),
                  const Gap(4),
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: context.textPrimaryColor,
                        fontSize: 18,
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
                        color: context.backgroundPrimaryColor
                            .withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color:
                              context.borderPrimaryColor.withValues(alpha: 0.1),
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
                            style: TextStyle(
                              fontSize: 13,
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
                      color:
                          context.backgroundPrimaryColor.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color:
                            context.borderPrimaryColor.withValues(alpha: 0.1),
                      ),
                    ),
                    child: Text(
                      '$current / $total',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        color: context.textPrimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(24),
              Stack(
                children: [
                  Container(
                    height: 8,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color:
                          context.backgroundPrimaryColor.withValues(alpha: 0.5),
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
                            color:
                                context.brandPrimaryColor.withValues(alpha: 0.3),
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
        ),
      ),
    );
  }

  void _showExitDialog(
    BuildContext context,
    dynamic t,
  ) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: context.backgroundSecondaryColor.withValues(alpha: 0.9),
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(
          t['exitQuizTitle'] ?? 'Exit Quiz?',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            color: context.textPrimaryColor,
            letterSpacing: -0.5,
          ),
        ),
        content: Text(
          t['exitQuizDesc'] ??
              'Your progress will not be saved. Are you sure you want to exit?',
          style: TextStyle(
            color: context.textSecondaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              t['cancel'] ?? 'Cancel',
              style: TextStyle(
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
              label: t['exit'] ?? 'Exit',
            ),
          ),
        ],
      ),
    );
  }
}

final class _QuestionCard extends StatelessWidget {
  final QuizQuestionEntity q;
  final int current;
  final int total;
  final String? selectedAnswer;
  final dynamic t;

  const _QuestionCard({
    required this.q,
    required this.current,
    required this.total,
    required this.selectedAnswer,
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
            color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: context.borderPrimaryColor.withValues(alpha: 0.1),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(28),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
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
                          color:
                              context.brandPrimaryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${t['questionLabel'] ?? 'QUESTION'} $current',
                          style: TextStyle(
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
                    q.text,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: context.textPrimaryColor,
                      height: 1.6,
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
          ),
        ),
        const Gap(32),
        Text(
          t['chooseCorrect'] ?? 'Choose the correct answer:',
          style: TextStyle(
            fontSize: 14,
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
            t: t,
          ),
      ],
    );
  }
}

final class _TextAnswerField extends StatefulWidget {
  final String questionId;
  final String? initialValue;
  final bool isLong;
  final dynamic t;

  const _TextAnswerField({
    required this.questionId,
    required this.initialValue,
    required this.isLong,
    required this.t,
  });

  @override
  State<_TextAnswerField> createState() => _TextAnswerFieldState();
}

final class _TextAnswerFieldState extends State<_TextAnswerField> {
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
        color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: MentorXTextFormField(
            controller: _controller,
            prefixIcon: Icons.edit_note_rounded,
            label: widget.t['yourAnswer'] ?? 'Your Answer',
            hintText: widget.t['typeAnswerHere'] ?? 'Type your answer here...',
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
        ),
      ),
    );
  }
}

final class _OptionTile extends StatelessWidget {
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
            color: isSelected ? null : context.backgroundSecondaryColor.withValues(alpha: 0.45),
            gradient: isSelected
                ? LinearGradient(
                    colors: [
                      context.brandPrimaryColor,
                      context.brandSecondaryColor.withValues(alpha: 0.8),
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
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: context.brandPrimaryColor.withValues(alpha: 0.25),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
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
                            : context.backgroundPrimaryColor.withValues(alpha: 0.5),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? Colors.white.withValues(alpha: 0.4)
                              : context.borderPrimaryColor.withValues(alpha: 0.1),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          label,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                            color: isSelected ? Colors.white : context.textPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                    const Gap(16),
                    Expanded(
                      child: Text(
                        text,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700,
                          color: isSelected ? Colors.white : context.textPrimaryColor,
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

final class _BuildNavigation extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isSubmitting;
  final dynamic t;

  const _BuildNavigation({
    required this.isFirst,
    required this.isLast,
    required this.isSubmitting,
    required this.t,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        20,
        16,
        20,
        MediaQuery.of(context).padding.bottom + 16,
      ),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        border: Border(
          top: BorderSide(
            color: context.borderPrimaryColor.withValues(alpha: 0.1),
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Row(
            children: [
              if (!isFirst) ...[
                Expanded(
                  flex: 1,
                  child: MentorXButton(
                    onPressed: () => context.read<QuizTakingPageBloc>().add(
                          const QuizTakingPagePreviousQuestion(),
                        ),
                    label: t['commonPrevious']!,
                    color: context.backgroundPrimaryColor,
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
                      context.read<QuizTakingPageBloc>().add(
                            const QuizTakingPageSubmit(),
                          );
                    }
                  },
                  label: isLast ? t['review']! : t['commonNext']!,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BackgroundDecorations extends StatelessWidget {
  const _BackgroundDecorations();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -100,
          right: -50,
          child: _BlurredBlob(
            color: context.brandPrimaryColor.withValues(alpha: 0.12),
            size: 350,
          ),
        ),
        Positioned(
          top: 300,
          left: -150,
          child: _BlurredBlob(
            color: context.brandSecondaryColor.withValues(alpha: 0.08),
            size: 400,
          ),
        ),
        Positioned(
          bottom: -50,
          right: -100,
          child: _BlurredBlob(
            color: context.brandPrimaryColor.withValues(alpha: 0.1),
            size: 300,
          ),
        ),
      ],
    );
  }
}

class _BlurredBlob extends StatelessWidget {
  final Color color;
  final double size;

  const _BlurredBlob({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
        child: const SizedBox.expand(),
      ),
    );
  }
}
