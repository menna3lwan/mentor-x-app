import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../../bloc/home_page_bloc.dart';
import 'home_header_widget.dart';

final class HomeHeaderWrapper extends StatelessWidget {
  const HomeHeaderWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final studentName = context.select<HomePageBloc, String>(
      (bloc) => bloc.state.studentName,
    );
    final unreadCount = context.select<HomePageBloc, int>(
      (bloc) => bloc.state.unreadCountSection.data ?? 0,
    );
    final avatarUrl = context.select<HomePageBloc, String?>(
      (bloc) => bloc.state.avatarUrl,
    );

    final hour = DateTime.now().hour;
    final greeting = (hour >= 5 && hour < 12)
        ? context.t.home.dashboard.greetingMorning
        : context.t.home.dashboard.greetingEvening;

    return HomeHeaderWidget(
      studentName: studentName,
      greetingText: greeting,
      unreadCount: unreadCount,
      avatarUrl: avatarUrl,
    );
  }
}
