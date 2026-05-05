import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

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
    final palette = MentorXThemeColorPalette.light;
    final t = context.t.student;

    return Scaffold(
      backgroundColor: palette.backgroundSecondary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                palette.brandPrimary,
                palette.brandPrimary.withOpacity(0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(24),
            ),
            boxShadow: [
              BoxShadow(
                color: palette.brandPrimary.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            foregroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            actions: [
              if (isReady && !isCompleted)
                IconButton(
                  onPressed: onMarkComplete,
                  icon: const Icon(Icons.check_circle_outline_rounded),
                  tooltip: context.t.course.pdf.markComplete,
                ),
              if (isCompleted)
                const Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Icon(Icons.check_circle_rounded, color: Colors.white),
                ),
            ],
          ),
        ),
      ),
      body: _buildBody(context, palette, t),
    );
  }

  Widget _buildBody(
    BuildContext context,
    MentorXThemeColorPalette palette,
    dynamic t,
  ) {
    if (errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline_rounded,
                size: 64,
                color: Colors.red.withOpacity(0.3),
              ),
              const SizedBox(height: 24),
              Text(
                errorMessage!,
                style: TextStyle(
                  color: palette.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
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
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.05),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.red.withOpacity(0.1)),
              ),
              child: Icon(
                Icons.picture_as_pdf_rounded,
                size: 100,
                color: Colors.red.shade400,
              ),
            ),
            const SizedBox(height: 32),
            Text(
              context.t.course.pdf.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: palette.textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: palette.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (contentUrl != null) ...[
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: palette.backgroundPrimary,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: palette.brandPrimary.withOpacity(0.1),
                  ),
                ),
                child: Text(
                  contentUrl!,
                  style: TextStyle(fontSize: 11, color: palette.textTertiary),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
            if (isCompleted) ...[
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.verified_rounded,
                      color: Colors.green,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      context.t.course.pdf.completed,
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ] else if (isReady) ...[
              const SizedBox(height: 40),
              MentorXButton(
                onPressed: onMarkComplete,
                text: context.t.course.pdf.markComplete,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
