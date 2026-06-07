import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import 'bloc/home_bloc.dart';
import 'home_page.dart';

final class HomePageWrapper extends StatelessWidget {
  const HomePageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final isRefreshing = context.select<HomeBloc, bool>(
      (bloc) => bloc.state.isRefreshing,
    );
    final lastUpdatedAt = context.select<HomeBloc, DateTime?>(
      (bloc) => bloc.state.lastUpdatedAt,
    );
    final hasAnnouncements = context.select<HomeBloc, bool>(
      (bloc) {
        final section = bloc.state.announcementsSection;
        return (section.data?.isNotEmpty ?? false) ||
            section.isLoading ||
            section.isFailure;
      },
    );

    return BlocPresentationListener<HomeBloc, HomePresentationEvent>(
      listener: (context, event) {
        switch (event) {
          case HomeFailurePresentationEvent(:final message):
            MentorXUI.showToast(message: message);
        }
      },
      child: HomePage(
        isRefreshing: isRefreshing,
        lastUpdatedAt: lastUpdatedAt,
        hasAnnouncements: hasAnnouncements,
        onRefresh: () {
          final bloc = context.read<HomeBloc>();
          bloc.add(const HomeRefreshedEvent());
        },
      ),
    );
  }
}
