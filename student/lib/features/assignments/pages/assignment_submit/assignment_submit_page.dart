import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:mentorx_student/core/core.dart';
import 'bloc/assignment_submit_page_bloc.dart';

final class AssignmentSubmitPage extends StatefulWidget {
  const AssignmentSubmitPage({super.key});
  @override
  State<AssignmentSubmitPage> createState() => _AssignmentSubmitPageState();
}

final class _AssignmentSubmitPageState extends State<AssignmentSubmitPage> {
  @override
  Widget build(BuildContext context) {
    final t = context.t.assignments;

    return BlocConsumer<AssignmentSubmitPageBloc, AssignmentSubmitPageState>(
      listener: (context, state) {
        if (state.isSuccess) {
          context.pop();
          MentorXUI.showToast(
            message: t.submitted,
          );
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
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: List.generate(
                        4,
                        (index) => const Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: MentorXSkeleton(height: 80, borderRadius: 24),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        if (state.errorMessage != null) {
          return Scaffold(
            backgroundColor: context.backgroundPrimaryColor,
            body: AppErrorView(
              message: state.errorMessage!,
              onRetry: () => context.read<AssignmentSubmitPageBloc>().add(
                const AssignmentSubmitPageLoadEvent(),
              ),
            ),
          );
        }

        if (state.assignment == null) {
          return Scaffold(
            backgroundColor: context.backgroundPrimaryColor,
            body: AppEmptyView(
              title: t.notFound,
              message: 'Try again later',
            ),
          );
        }

        final q = state.currentQuestion;
        final totalQuestions = state.questions.length;
        final currentQuestionIndex = state.currentQuestionIndex;
        final progress = totalQuestions > 0
            ? (currentQuestionIndex + 1) / totalQuestions
            : 1.0;

        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: PopScope(
            canPop: false,
            child: Scaffold(
              backgroundColor: context.backgroundPrimaryColor,
              body: Column(
                children: [
                  _BuildHeader(
                    title: state.assignment!.title,
                    progress: progress,
                    current: totalQuestions > 0 ? currentQuestionIndex + 1 : 1,
                    total: totalQuestions > 0 ? totalQuestions : 1,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.fromLTRB(24, 32, 24, 120),
                      child: totalQuestions > 0
                          ? FadeInRight(
                              key: ValueKey(
                                'question_$currentQuestionIndex',
                              ),
                              duration: const Duration(milliseconds: 400),
                              child: _QuestionCard(
                                q: q!,
                                current: (state.currentQuestionIndex + 1),
                                total: state.questions.length,
                                selectedAnswer: state.answers[q.id],
                              ),
                            )
                          : Column(
                              children: [
                                FadeInUp(
                                  duration: const Duration(
                                    milliseconds: 600,
                                  ),
                                  child: _EssayCard(
                                    initialValue: state.contentText ?? '',
                                    onChanged: (val) => context
                                        .read<AssignmentSubmitPageBloc>()
                                        .add(
                                          AssignmentSubmitPageContentChanged(
                                            val,
                                          ),
                                        ),
                                  ),
                                ),
                                const Gap(32),
                                FadeInUp(
                                  duration: const Duration(
                                    milliseconds: 600,
                                  ),
                                  delay: const Duration(milliseconds: 200),
                                  child: _FileUploadCard(
                                    filePaths: state.filePaths,
                                    onAdd: () async {
                                      final result = await FilePicker.platform
                                          .pickFiles(allowMultiple: true);
                                      if (!context.mounted) return;
                                      if (result != null &&
                                          result.files.isNotEmpty) {
                                        for (final file in result.files) {
                                          if (file.path != null) {
                                            context
                                                .read<
                                                  AssignmentSubmitPageBloc
                                                >()
                                                .add(
                                                  AssignmentSubmitPageFileAdded(
                                                    file.path!,
                                                  ),
                                                );
                                          }
                                        }
                                      }
                                    },
                                    onRemove: (path) => context
                                        .read<AssignmentSubmitPageBloc>()
                                        .add(
                                          AssignmentSubmitPageFileRemoved(
                                            path,
                                          ),
                                        ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                  _BuildNavigation(
                    isFirst: totalQuestions > 0
                        ? currentQuestionIndex == 0
                        : true,
                    isLast: totalQuestions > 0
                        ? currentQuestionIndex == totalQuestions - 1
                        : true,
                    isSubmitting: state.isSubmitting,
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
  final double progress;
  final int current;
  final int total;

  const _BuildHeader({
    required this.title,
    required this.progress,
    required this.current,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return MentorXGlassCard(
      borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
      style: Style(
        $box.color(context.backgroundSecondaryColor.withValues(alpha: 0.45)),
        $box.border.bottom.color(
          context.borderPrimaryColor.withValues(alpha: 0.1),
        ),
        $box.padding.only(
          left: 16,
          top: MediaQuery.paddingOf(context).top + 16,
          right: 16,
          bottom: 32,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              MentorXIconButton(
                onPressed: () => _showExitDialog(context),
                icon: Icons.close_rounded,
                color: context.textPrimaryColor,
                size: MentorXIconButtonSize.small,
              ),
              const Gap(8),
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
              const Gap(12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: context.brandPrimaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: context.brandPrimaryColor.withValues(alpha: 0.1),
                  ),
                ),
                child: Text(
                  '$current / $total',
                  style: context.smallTextStyle.copyWith(
                    fontWeight: FontWeight.w900,
                    color: context.brandPrimaryColor,
                  ),
                ),
              ),
            ],
          ),
          const Gap(24),
          Stack(
            children: [
              Container(
                height: 10,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: context.borderPrimaryColor.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              AnimatedFractionallySizedBox(
                duration: const Duration(milliseconds: 300),
                widthFactor: progress.clamp(0.0, 1.0),
                child: Container(
                  height: 10,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        context.brandPrimaryColor,
                        context.brandSecondaryColor,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: [
                      BoxShadow(
                        color: context.brandPrimaryColor.withValues(alpha: 0.3),
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

  void _showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: context.backgroundSecondaryColor.withValues(
          alpha: 0.9,
        ),
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
          side: BorderSide(
            color: context.borderPrimaryColor.withValues(alpha: 0.1),
          ),
        ),
        title: Text(
          context.t.assignments.exitTitle,
          style: TextStyle(
            color: context.textPrimaryColor,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
          ),
        ),
        content: Text(
          context.t.assignments.exitDesc,
          style: TextStyle(
            color: context.textSecondaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              context.t.assignments.cancel,
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
              label: context.t.assignments.exit,
              size: MentorXButtonSize.small,
            ),
          ),
        ],
      ),
    );
  }
}

final class _BuildNavigation extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isSubmitting;

  const _BuildNavigation({
    required this.isFirst,
    required this.isLast,
    required this.isSubmitting,
  });

  @override
  Widget build(BuildContext context) {
    return MentorXGlassCard(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      style: Style(
        $box.color(context.backgroundSecondaryColor.withValues(alpha: 0.45)),
        $box.border.top.color(
          context.borderPrimaryColor.withValues(alpha: 0.1),
        ),
        $box.padding.only(
          left: 16,
          top: 20,
          right: 16,
          bottom: MediaQuery.paddingOf(context).bottom + 20,
        ),
      ),
      child: Row(
        children: [
          if (!isFirst)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 12),
                child: MentorXButton(
                  onPressed: () => context.read<AssignmentSubmitPageBloc>().add(
                    const AssignmentSubmitPagePreviousQuestion(),
                  ),
                  label: context.t.assignments.previous,
                  variant: MentorXButtonVariant.outline,
                ),
              ),
            ),
          Expanded(
            flex: 2,
            child: MentorXButton(
              onPressed: isSubmitting
                  ? null
                  : () {
                      if (isLast) {
                        context.read<AssignmentSubmitPageBloc>().add(
                          const AssignmentSubmitPageSubmit(),
                        );
                      } else {
                        context.read<AssignmentSubmitPageBloc>().add(
                          const AssignmentSubmitPageNextQuestion(),
                        );
                      }
                    },
              label: isLast
                  ? context.t.assignments.submit
                  : context.t.assignments.next,
              loading: isSubmitting,
            ),
          ),
        ],
      ),
    );
  }
}

final class _EssayCard extends StatefulWidget {
  final String? initialValue;
  final ValueChanged<String> onChanged;

  const _EssayCard({
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<_EssayCard> createState() => _EssayCardState();
}

final class _EssayCardState extends State<_EssayCard> {
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
    return MentorXGlassCard(
      borderRadius: BorderRadius.circular(32),
      style: Style(
        $box.color(context.backgroundSecondaryColor.withValues(alpha: 0.45)),
        $box.border.all.color(
          context.borderPrimaryColor.withValues(alpha: 0.1),
        ),
        $box.shadows(context.softShadow),
        $box.padding.all(32),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.t.assignments.yourResponse,
            style: context.titleH3Style.copyWith(
              fontWeight: FontWeight.w900,
              letterSpacing: -0.5,
            ),
          ),
          const Gap(24),
          MentorXTextFormField(
            controller: _controller,
            prefixIcon: Icons.description_rounded,
            label: context.t.assignments.writeResponse,
            hintText: context.t.assignments.responseHint,
            maxLines: 12,
            onChanged: widget.onChanged,
          ),
        ],
      ),
    );
  }
}

final class _FileUploadCard extends StatelessWidget {
  final List<String> filePaths;
  final VoidCallback onAdd;
  final ValueChanged<String> onRemove;

  const _FileUploadCard({
    required this.filePaths,
    required this.onAdd,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return MentorXGlassCard(
      borderRadius: BorderRadius.circular(32),
      style: Style(
        $box.color(context.backgroundSecondaryColor.withValues(alpha: 0.45)),
        $box.border.all.color(
          context.borderPrimaryColor.withValues(alpha: 0.1),
        ),
        $box.shadows(context.softShadow),
        $box.padding.all(32),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.t.assignments.attachments,
                style: context.titleH3Style.copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                ),
              ),
              MentorXIconButton(
                onPressed: onAdd,
                icon: Icons.add_circle_outline_rounded,
                color: context.brandPrimaryColor,
              ),
            ],
          ),
          const Gap(24),
          if (filePaths.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Column(
                  children: [
                    Icon(
                      Icons.cloud_upload_outlined,
                      size: 64,
                      color: context.textTertiaryColor.withValues(alpha: 0.2),
                    ),
                    const Gap(20),
                    Text(
                      context.t.assignments.noFiles,
                      style: context.bodyPrimaryStyle.copyWith(
                        color: context.textTertiaryColor,
                        fontWeight: FontWeight.w700,
                      ),
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
              separatorBuilder: (context, index) => const Gap(16),
              itemBuilder: (context, index) {
                final path = filePaths[index];
                final fileName = path.split('/').last;
                return FadeInLeft(
                  duration: const Duration(milliseconds: 400),
                  child: MentorXGlassCard(
                    borderRadius: BorderRadius.circular(20),
                    style: Style(
                      $box.color(
                        context.backgroundPrimaryColor.withValues(alpha: 0.4),
                      ),
                      $box.border.all.color(
                        context.borderPrimaryColor.withValues(alpha: 0.1),
                      ),
                      $box.padding.all(16),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: context.brandPrimaryColor.withValues(
                              alpha: 0.1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.insert_drive_file_rounded,
                            color: context.brandPrimaryColor,
                            size: 22,
                          ),
                        ),
                        const Gap(16),
                        Expanded(
                          child: Text(
                            fileName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.bodyPrimaryStyle.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        MentorXIconButton(
                          onPressed: () => onRemove(path),
                          icon: Icons.close_rounded,
                          color: context.statusDangerColor,
                          size: MentorXIconButtonSize.small,
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

final class _QuestionCard extends StatelessWidget {
  final dynamic q;
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MentorXGlassCard(
          borderRadius: BorderRadius.circular(32),
          style: Style(
            $box.color(
              context.backgroundSecondaryColor.withValues(alpha: 0.45),
            ),
            $box.border.all.color(
              context.borderPrimaryColor.withValues(alpha: 0.1),
            ),
            $box.shadows(context.softShadow),
            $box.padding.all(32),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: context.brandPrimaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${context.t.assignments.questionLabel} $current',
                  style: context.smallTextStyle.copyWith(
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    color: context.brandPrimaryColor,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              const Gap(24),
              Text(
                q.text,
                style: context.titleH2Style.copyWith(
                  fontWeight: FontWeight.w900,
                  height: 1.4,
                  letterSpacing: -0.5,
                ),
              ),
              if (q.imageUrl != null) ...[
                const Gap(24),
                ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: AppDynamicImage(
                    q.imageUrl!,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ],
          ),
        ),
        const Gap(40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(
            context.t.assignments.chooseCorrect,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: context.textPrimaryColor,
              letterSpacing: -0.5,
            ),
          ),
        ),
        const Gap(20),
        ...q.options.asMap().entries.map((entry) {
          final optionIndex = entry.key;
          final optionText = entry.value;
          final labels = ['A', 'B', 'C', 'D', 'E', 'F'];
          final label = optionIndex < labels.length
              ? labels[optionIndex]
              : (optionIndex + 1).toString();
          final isSelected = selectedAnswer == optionText;

          return FadeInUp(
            duration: const Duration(milliseconds: 400),
            delay: Duration(milliseconds: 100 * (optionIndex as int)),
            child: _OptionTile(
              label: label,
              text: optionText,
              isSelected: isSelected,
              onTap: () => context.read<AssignmentSubmitPageBloc>().add(
                AssignmentSubmitPageAnswerSelected(
                  questionId: q.id,
                  selectedAnswer: optionText,
                ),
              ),
            ),
          );
        }),
      ],
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
            color: isSelected
                ? null
                : context.backgroundSecondaryColor.withValues(alpha: 0.45),
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
