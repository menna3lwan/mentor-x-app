import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';

final class PdfViewerPagePage extends StatelessWidget {
  final String title;
  final String? contentUrl;
  final bool isLoading;
  final bool isReady;
  final bool isCompleted;
  final String? errorMessage;
  final VoidCallback onMarkComplete;

  const PdfViewerPagePage({
    super.key,
    required this.title,
    required this.contentUrl,
    required this.isLoading,
    required this.isReady,
    required this.isCompleted,
    required this.errorMessage,
    required this.onMarkComplete,
  });

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;

    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
            color: context.backgroundSecondaryColor,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(24),
            ),
            border: Border(
              bottom: BorderSide(
                color: context.borderPrimaryColor.withValues(alpha: 0.05),
              ),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            foregroundColor: context.textPrimaryColor,
            centerTitle: true,
            title: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                letterSpacing: -0.5,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            actions: [
              if (isReady && !isCompleted)
                IconButton(
                  onPressed: onMarkComplete,
                  icon: const Icon(
                    Icons.check_circle_outline_rounded,
                    size: 22,
                  ),
                  tooltip: context.t.course.pdf.markComplete,
                ),
              if (isCompleted)
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Icon(
                    Icons.check_circle_rounded,
                    color: context.statusSuccessColor,
                    size: 22,
                  ),
                ),
            ],
          ),
        ),
      ),
      body: _buildBody(context, t),
    );
  }

  Widget _buildBody(
    BuildContext context,
    dynamic t,
  ) {
    if (errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeInDown(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: context.statusDangerColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.error_outline_rounded,
                    size: 64,
                    color: context.statusDangerColor,
                  ),
                ),
              ),
              const Gap(32),
              FadeInUp(
                child: Text(
                  errorMessage!,
                  style: TextStyle(
                    color: context.textPrimaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Center(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeInDown(
              duration: const Duration(milliseconds: 600),
              child: Container(
                padding: const EdgeInsets.all(48),
                decoration: BoxDecoration(
                  color: context.statusDangerColor.withValues(alpha: 0.05),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: context.statusDangerColor.withValues(alpha: 0.1),
                  ),
                ),
                child: Icon(
                  Icons.picture_as_pdf_rounded,
                  size: 110,
                  color: context.statusDangerColor,
                ),
              ),
            ),
            const Gap(40),
            FadeInUp(
              duration: const Duration(milliseconds: 600),
              child: Column(
                children: [
                  Text(
                    context.t.course.pdf.title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: context.textPrimaryColor,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const Gap(12),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      color: context.textSecondaryColor,
                      fontWeight: FontWeight.w700,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            if (contentUrl != null) ...[
              const Gap(32),
              FadeInUp(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 200),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: context.backgroundSecondaryColor,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: context.borderPrimaryColor.withValues(alpha: 0.05),
                    ),
                  ),
                  child: Text(
                    contentUrl!,
                    style: TextStyle(
                      fontSize: 12,
                      color: context.textTertiaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
            if (isCompleted) ...[
              const Gap(40),
              FadeInUp(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 400),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: context.statusSuccessColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: context.statusSuccessColor.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.verified_rounded,
                        color: context.statusSuccessColor,
                        size: 20,
                      ),
                      const Gap(10),
                      Text(
                        context.t.course.pdf.completed.toUpperCase(),
                        style: TextStyle(
                          color: context.statusSuccessColor,
                          fontWeight: FontWeight.w900,
                          fontSize: 12,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ] else if (isReady) ...[
              const Gap(48),
              FadeInUp(
                duration: const Duration(milliseconds: 600),
                delay: const Duration(milliseconds: 400),
                child: MentorXButton(
                  onPressed: onMarkComplete,
                  label: context.t.course.pdf.markComplete,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
