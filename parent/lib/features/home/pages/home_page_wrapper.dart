import 'package:analytics_service/analytics_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import '../bloc/home_bloc.dart';
import 'home_page.dart';

class HomePageWrapper extends StatelessWidget {
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
        child: const HomePage(),
      ),
    );
  }
}
