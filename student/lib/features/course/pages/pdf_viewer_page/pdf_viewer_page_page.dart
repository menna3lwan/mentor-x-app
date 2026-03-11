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

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          if (isReady && !isCompleted)
            TextButton(
              onPressed: onMarkComplete,
              child: Text(context.t.course.pdf.markComplete),
            ),
          if (isCompleted)
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Icon(
                Icons.check_circle,
                color: palette.statusSuccess,
              ),
            ),
        ],
      ),
      body: _buildBody(context, palette),
    );
  }

  Widget _buildBody(BuildContext context, MentorXThemeColorPalette palette) {
    if (errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: palette.statusDanger),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                errorMessage!,
                style: TextStyle(color: palette.statusDanger),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      );
    }

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    // PDF viewer placeholder — integrate a real PDF viewer package for production
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.picture_as_pdf,
              size: 80,
              color: Colors.red.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              context.t.course.pdf.title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: palette.textSecondary),
              textAlign: TextAlign.center,
            ),
            if (contentUrl != null) ...[
              const SizedBox(height: 16),
              Text(
                contentUrl!,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: palette.textSecondary,
                ),
                textAlign: TextAlign.center,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            if (isCompleted) ...[
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: palette.statusSuccess,
                    size: 20,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    context.t.course.pdf.completed,
                    style: TextStyle(color: palette.statusSuccess),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
