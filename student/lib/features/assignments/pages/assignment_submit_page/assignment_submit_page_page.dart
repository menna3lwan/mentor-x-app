import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'bloc/assignment_submit_page_bloc.dart';

class AssignmentSubmitPage extends StatefulWidget {
  const AssignmentSubmitPage({super.key});
  @override
  State<AssignmentSubmitPage> createState() => _AssignmentSubmitPageState();
}

class _AssignmentSubmitPageState extends State<AssignmentSubmitPage> {
  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;
    final t = context.t.student;

    return BlocConsumer<AssignmentSubmitPageBloc, AssignmentSubmitPageState>(
      listener: (context, state) {
        if (state.isSuccess) {
          context.pop();
          MentorXUI.showToast(message: t['assignmentSubmitted'] ?? 'Assignment submitted successfully');
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
                    FadeInDown(
                      child: Icon(Icons.error_outline_rounded, size: 64, color: palette.statusDanger.withValues(alpha: 0.5)),
                    ),
                    const Gap(24),
                    FadeInUp(
                      child: Text(
                        state.errorMessage!,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: palette.textSecondary),
                      ),
                    ),
                    const Gap(32),
                    FadeInUp(
                      delay: const Duration(milliseconds: 200),
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

        if (state.assignment == null) {
          return Scaffold(
            backgroundColor: palette.backgroundSecondary,
            body: Center(child: Text(t['assignmentNotFound'] ?? 'Assignment not found')),
          );
        }

        final q = state.currentQuestion;
        final totalQuestions = state.questions.length;
        final currentQuestionIndex = state.currentQuestionIndex;
        final progress = totalQuestions > 0 ? (currentQuestionIndex + 1) / totalQuestions : 1.0;

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
                    title: state.assignment!.title,
                    progress: progress,
                    current: totalQuestions > 0 ? currentQuestionIndex + 1 : 1,
                    total: totalQuestions > 0 ? totalQuestions : 1,
                    palette: palette,
                    t: t,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(20, 24, 20, 100),
                      child: totalQuestions > 0
                          ? FadeInRight(
                              key: ValueKey('question_$currentQuestionIndex'),
                              duration: const Duration(milliseconds: 400),
                              child: _QuestionCard(
                                q: q!,
                                current: currentQuestionIndex + 1,
                                total: totalQuestions,
                                selectedAnswer: state.answers[q.id],
                                palette: palette,
                                t: t,
                              ),
                            )
                          : Column(
                              children: [
                                FadeInUp(
                                  duration: const Duration(milliseconds: 600),
                                  child: _EssayCard(
                                    initialValue: state.contentText ?? '',
                                    onChanged: (val) => context.read<AssignmentSubmitPageBloc>().add(AssignmentSubmitPageContentChanged(val)),
                                    palette: palette,
                                    t: t,
                                  ),
                                ),
                                const Gap(24),
                                FadeInUp(
                                  duration: const Duration(milliseconds: 600),
                                  delay: const Duration(milliseconds: 200),
                                  child: _FileUploadCard(
                                    filePaths: state.filePaths,
                                    onAdd: () async {
                                      final result = await FilePicker.platform.pickFiles(allowMultiple: true);
                                      if (!context.mounted) return;
                                      if (result != null && result.files.isNotEmpty) {
                                        for (final file in result.files) {
                                          if (file.path != null) {
                                            context.read<AssignmentSubmitPageBloc>().add(AssignmentSubmitPageFileAdded(file.path!));
                                          }
                                        }
                                      }
                                    },
                                    onRemove: (path) => context.read<AssignmentSubmitPageBloc>().add(AssignmentSubmitPageFileRemoved(path)),
                                    palette: palette,
                                    t: t,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    child: _BuildNavigation(
                      isFirst: totalQuestions > 0 ? currentQuestionIndex == 0 : true,
                      isLast: totalQuestions > 0 ? currentQuestionIndex == totalQuestions - 1 : true,
                      isSubmitting: state.isSubmitting,
                      palette: palette,
                      t: t,
                    ),
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
  final double progress;
  final int current;
  final int total;
  final MentorXThemeColorPalette palette;
  final dynamic t;

  const _BuildHeader({
    required this.title,
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
          colors: [palette.brandPrimary, palette.brandPrimary.withValues(alpha: 0.8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: palette.brandPrimary.withValues(alpha: 0.3),
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
              const Gap(4),
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
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
          const Gap(20),
          Stack(
            children: [
              Container(
                height: 8,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
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
                      BoxShadow(color: Colors.white.withValues(alpha: 0.3), blurRadius: 10),
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

  void _showExitDialog(BuildContext context, dynamic t, MentorXThemeColorPalette palette) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        title: Text(t['exitQuizTitle'] ?? 'Exit Assignment?', style: const TextStyle(fontWeight: FontWeight.w900, letterSpacing: -0.5)),
        content: Text(t['exitQuizDesc'] ?? 'Your progress will not be saved. Are you sure you want to exit?', style: const TextStyle(fontWeight: FontWeight.w500)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(t['cancel'] ?? 'Cancel', style: TextStyle(color: palette.textTertiary, fontWeight: FontWeight.w700)),
          ),
          SizedBox(
            width: 110,
            child: MentorXButton(
              onPressed: () {
                Navigator.pop(ctx);
                Navigator.pop(context);
              },
              label: t['exit'] ?? 'Exit',
              size: MentorXButtonSize.small,
            ),
          ),
        ],
      ),
    );
  }
}

class _EssayCard extends StatefulWidget {
  final String? initialValue;
  final ValueChanged<String> onChanged;
  final MentorXThemeColorPalette palette;
  final dynamic t;

  const _EssayCard({
    required this.initialValue,
    required this.onChanged,
    required this.palette,
    required this.t,
  });

  @override
  State<_EssayCard> createState() => _EssayCardState();
}

class _EssayCardState extends State<_EssayCard> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.t['yourResponse'] ?? 'Your Response',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: widget.palette.textPrimary,
              letterSpacing: -0.3,
            ),
          ),
          const Gap(16),
          MentorXTextFormField(
            controller: _controller,
            prefixIcon: Icons.description_rounded,
            label: widget.t['writeResponse'] ?? 'Write your response here...',
            hintText: widget.t['responseHint'] ?? 'Start typing...',
            maxLines: 10,
            onChanged: widget.onChanged,
          ),
        ],
      ),
    );
  }
}

class _FileUploadCard extends StatelessWidget {
  final List<String> filePaths;
  final VoidCallback onAdd;
  final ValueChanged<String> onRemove;
  final MentorXThemeColorPalette palette;
  final dynamic t;

  const _FileUploadCard({
    required this.filePaths,
    required this.onAdd,
    required this.onRemove,
    required this.palette,
    required this.t,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 20, offset: const Offset(0, 10)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                t['attachments'] ?? 'Attachments',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: palette.textPrimary, letterSpacing: -0.3),
              ),
              IconButton(
                onPressed: onAdd,
                icon: Icon(Icons.add_circle_outline_rounded, color: palette.brandPrimary, size: 28),
              ),
            ],
          ),
          const Gap(16),
          if (filePaths.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Column(
                  children: [
                    Icon(Icons.cloud_upload_outlined, size: 56, color: palette.textTertiary.withValues(alpha: 0.3)),
                    const Gap(16),
                    Text(
                      t['noFiles'] ?? 'No files attached yet',
                      style: TextStyle(color: palette.textTertiary, fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filePaths.length,
              separatorBuilder: (context, index) => const Gap(12),
              itemBuilder: (context, index) {
                final path = filePaths[index];
                final fileName = path.split('/').last;
                return FadeInLeft(
                  duration: const Duration(milliseconds: 400),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: palette.backgroundSecondary,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.insert_drive_file_rounded, color: palette.brandPrimary, size: 22),
                        const Gap(12),
                        Expanded(
                          child: Text(
                            fileName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: palette.textPrimary),
                          ),
                        ),
                        IconButton(
                          onPressed: () => onRemove(path),
                          icon: const Icon(Icons.close_rounded, size: 20, color: Colors.redAccent),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                  ),
                );
              },
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
          padding: const EdgeInsets.all(28),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 25, offset: const Offset(0, 12)),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: palette.brandPrimary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'QUESTION $current',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        color: palette.brandPrimary,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(20),
              Text(
                q.text,
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w900,
                  color: palette.textPrimary,
                  height: 1.6,
                  letterSpacing: -0.3,
                ),
              ),
              if (q.imageUrl != null) ...[
                const Gap(24),
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.network(
                    q.imageUrl!,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ],
          ),
        ),
        const Gap(32),
        if (q.type == QuizQuestionType.multipleChoice || q.type == QuizQuestionType.trueFalse) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Text(
              t['chooseCorrect'] ?? 'Choose the correct answer:',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w900,
                color: palette.textSecondary,
                letterSpacing: -0.3,
              ),
            ),
          ),
          const Gap(16),
          ...q.options.asMap().entries.map((entry) {
            final optionIndex = entry.key;
            final optionText = entry.value;
            final labels = ['A', 'B', 'C', 'D', 'E', 'F'];
            final label = optionIndex < labels.length ? labels[optionIndex] : (optionIndex + 1).toString();
            final isSelected = selectedAnswer == optionText;

            return FadeInUp(
              duration: const Duration(milliseconds: 400),
              delay: Duration(milliseconds: 100 * optionIndex),
              child: _OptionTile(
                label: label,
                text: optionText,
                isSelected: isSelected,
                palette: palette,
                onTap: () => context.read<AssignmentSubmitPageBloc>().add(
                      AssignmentSubmitPageAnswerSelected(
                        questionId: q.id,
                        selectedAnswer: optionText,
                      ),
                    ),
              ),
            );
          }),
        ] else ...[
          _EssayCard(
            initialValue: selectedAnswer ?? '',
            onChanged: (val) => context.read<AssignmentSubmitPageBloc>().add(
                  AssignmentSubmitPageAnswerSelected(
                    questionId: q.id,
                    selectedAnswer: val,
                  ),
                ),
            palette: palette,
            t: t,
          ),
        ],
      ],
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
          borderRadius: BorderRadius.circular(24),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: isSelected ? palette.brandPrimary.withValues(alpha: 0.05) : Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isSelected ? palette.brandPrimary : Colors.transparent,
                width: 2.5,
              ),
              boxShadow: [
                if (!isSelected)
                  BoxShadow(color: Colors.black.withValues(alpha: 0.02), blurRadius: 15, offset: const Offset(0, 8)),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: isSelected ? palette.brandPrimary : palette.backgroundSecondary,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: isSelected ? Colors.white : palette.textSecondary,
                      ),
                    ),
                  ),
                ),
                const Gap(16),
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: isSelected ? FontWeight.w900 : FontWeight.w700,
                      color: isSelected ? palette.brandPrimary : palette.textPrimary,
                    ),
                  ),
                ),
                if (isSelected)
                  FadeIn(
                    child: Icon(Icons.check_circle_rounded, color: palette.brandPrimary, size: 28),
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
          BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 20, offset: const Offset(0, -5)),
        ],
      ),
      child: Row(
        children: [
          if (!isFirst) ...[
            Expanded(
              flex: 1,
              child: MentorXButton(
                onPressed: () => context.read<AssignmentSubmitPageBloc>().add(const AssignmentSubmitPagePreviousQuestion()),
                label: t['commonPrevious']!,
                size: MentorXButtonSize.medium,
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
                  context.read<AssignmentSubmitPageBloc>().add(const AssignmentSubmitPageNextQuestion());
                } else {
                  context.read<AssignmentSubmitPageBloc>().add(const AssignmentSubmitPageSubmit());
                }
              },
              label: isLast ? t['commonSubmit']! : t['commonNext']!,
              size: MentorXButtonSize.medium,
            ),
          ),
        ],
      ),
    );
  }
}
