import 'package:flutter/material.dart';

import 'package:mentorx_core/mentorx_core.dart';
import '../../bloc/home_page_bloc.dart';
import 'announcements_section_widget.dart';

final class AnnouncementsSection extends StatelessWidget {
  final HomeAsyncSection<List<AnnouncementEntity>> section;
  final VoidCallback onRetry;

  const AnnouncementsSection({
    super.key,
    required this.section,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return AnnouncementsSectionWidget(
      announcements: section.data,
      isLoading: section.isLoading,
      hasFailedWithEmptyData:
          section.isFailure && (section.data?.isEmpty ?? true),
      onRetry: onRetry,
    );
  }
}
