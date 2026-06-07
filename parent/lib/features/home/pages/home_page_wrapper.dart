import 'package:analytics_service/analytics_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import '../bloc/home_bloc.dart';
import 'home_page.dart';

final class HomePageWrapper extends StatelessWidget {
  const HomePageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        childrenRepository: context.read<ParentChildrenRepository>(),
        homeRepository: context.read<ParentHomeRepository>(),
        cacheRepository: context.read<CacheRepository>(),
        analyticsService: context.read<AnalyticsService>(),
      )..add(HomeStarted()),
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: context.statusDangerColor,
              ),
            );
          }
        },
        child: Builder(
          builder: (context) {
            final status = context.select<HomeBloc, HomeStatus>(
              (bloc) => bloc.state.status,
            );
            final children = context.select<HomeBloc, List<ParentChildEntity>>(
              (bloc) => bloc.state.children,
            );
            final selectedChild = context.select<HomeBloc, ParentChildEntity?>(
              (bloc) => bloc.state.selectedChild,
            );
            final summary = context.select<HomeBloc, ParentHomeSummaryEntity?>(
              (bloc) => bloc.state.summary,
            );
            final recentActivity = context.select<HomeBloc, List<ParentRecentActivityEntity>>(
              (bloc) => bloc.state.recentActivity,
            );
            final announcements = context.select<HomeBloc, List<AnnouncementEntity>>(
              (bloc) => bloc.state.announcements,
            );
            final errorMessage = context.select<HomeBloc, String?>(
              (bloc) => bloc.state.errorMessage,
            );

            return HomePagePage(
              status: status,
              children: children,
              selectedChild: selectedChild,
              summary: summary,
              recentActivity: recentActivity,
              announcements: announcements,
              errorMessage: errorMessage,
              onRefresh: () {
                final bloc = context.read<HomeBloc>();
                bloc.add(HomeRefreshRequested());
              },
              onRetry: () {
                final bloc = context.read<HomeBloc>();
                bloc.add(HomeStarted());
              },
              onChildSwitched: (child) {
                final bloc = context.read<HomeBloc>();
                bloc.add(HomeChildSwitched(child));
              },
            );
          },
        ),
      ),
    );
  }
}
