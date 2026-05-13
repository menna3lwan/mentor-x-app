part of '../mentorx_ui.dart';

/// A utility widget that conditionally wraps a [child] with another widget.
class MentorXConditionalWrapper extends StatelessWidget {
  const MentorXConditionalWrapper({
    super.key,
    required this.condition,
    required this.wrapper,
    required this.child,
  });

  final bool condition;
  final Widget Function(Widget child) wrapper;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return condition ? wrapper(child) : child;
  }
}
