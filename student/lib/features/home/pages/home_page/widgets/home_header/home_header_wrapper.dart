import 'package:flutter/material.dart';

import 'home_header_widget.dart';

final class HomeHeader extends StatelessWidget {
  final String studentName;
  final String greetingText;
  final int unreadCount;

  const HomeHeader({
    super.key,
    required this.studentName,
    required this.greetingText,
    required this.unreadCount,
  });

  @override
  Widget build(BuildContext context) {
    return HomeHeaderWidget(
      studentName: studentName,
      greetingText: greetingText,
      unreadCount: unreadCount,
    );
  }
}
