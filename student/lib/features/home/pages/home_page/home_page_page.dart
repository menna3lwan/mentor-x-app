import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

final class HomePagePage extends StatelessWidget {
  final Color backgroundColor;
  final Widget appBar;
  final Widget content;
  final Future<void> Function() onRefresh;

  const HomePagePage({
    super.key,
    required this.backgroundColor,
    required this.appBar,
    required this.content,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: onRefresh,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                appBar,
                const Gap(16),
                content,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
