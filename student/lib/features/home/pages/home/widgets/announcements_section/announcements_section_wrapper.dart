import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_student/core/core.dart';
import '../../bloc/home_bloc.dart';
import 'announcements_section_widget.dart';

final class AnnouncementsSectionWrapper extends StatelessWidget {
  const AnnouncementsSectionWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final section = context
        .select<HomeBloc, HomeAsyncSection<List<AnnouncementEntity>>>(
          (bloc) => bloc.state.announcementsSection,
        );

    return AnnouncementsSectionWidget(
      announcements: section.data,
      isLoading: section.isLoading,
      hasFailedWithEmptyData:
          section.isFailure && (section.data?.isEmpty ?? true),
      onRetry: () => context.read<HomeBloc>().add(
        const HomeRetrySectionEvent(HomeSection.announcements),
      ),
    );
  }
}
