import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:mentorx_student/core/core.dart';

final class PdfViewerPage extends StatelessWidget {
  final String title;
  final String? contentUrl;
  final bool isLoading;
  final bool isReady;
  final bool isCompleted;
  final String? errorMessage;
  final String? watermarkText;
  final VoidCallback onMarkComplete;
  final VoidCallback? onDownloadTap;

  const PdfViewerPage({
    super.key,
    required this.title,
    required this.contentUrl,
    required this.isLoading,
    required this.isReady,
    required this.isCompleted,
    required this.errorMessage,
    required this.onMarkComplete,
    this.watermarkText,
    this.onDownloadTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: Column(
        children: [
          Gap(MediaQuery.paddingOf(context).top + 20),
          _buildHeader(context),
          Expanded(child: _buildBody(context)),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: Row(
        children: [
          MentorXIconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icons.arrow_back_ios_new_rounded,
            variant: MentorXIconButtonVariant.outline,
            size: MentorXIconButtonSize.small,
          ),
          const Gap(20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInLeft(
                  duration: const Duration(milliseconds: 600),
                  child: Text(
                    'DOCUMENT',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: context.brandPrimaryColor,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
                const Gap(4),
                FadeInLeft(
                  duration: const Duration(milliseconds: 800),
                  delay: const Duration(milliseconds: 100),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: context.textPrimaryColor,
                      letterSpacing: -0.5,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
          if (!isCompleted && isReady)
            FadeInRight(
              duration: const Duration(milliseconds: 600),
              child: MentorXButton(
                onPressed: onMarkComplete,
                label: context.t.course.markAsDone,
                size: MentorXButtonSize.small,
                width: 100,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (errorMessage != null) {
      return AppErrorView(
        message: errorMessage!,
      );
    }

    if (isLoading) {
      return const Padding(
        padding: EdgeInsets.all(20),
        child: MentorXShimmer(
          child: MentorXSkeleton(
            height: double.infinity,
            width: double.infinity,
            borderRadius: 16,
          ),
        ),
      );
    }

    if (contentUrl == null || contentUrl!.isEmpty) {
      return Center(
        child: Text(
          'No document available',
          style: TextStyle(color: context.textSecondaryColor),
        ),
      );
    }

    return FadeInUp(
      duration: const Duration(milliseconds: 600),
      child: MentorXSecuredMediaWrapper(
        watermarkText: watermarkText,
        child: SfPdfViewer.network(
          contentUrl!,
        ),
      ),
    );
  }
}
