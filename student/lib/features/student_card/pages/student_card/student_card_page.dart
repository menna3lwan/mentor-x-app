import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

final class StudentCardPage extends StatelessWidget {
  final Widget appBar;
  final Widget content;

  const StudentCardPage({
    super.key,
    required this.appBar,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          appBar,
          SliverLayoutBuilder(
            builder: (context, constraints) {
              return SliverFillRemaining(
                hasScrollBody: true,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.remainingPaintExtent,
                  ),
                  child: content,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
