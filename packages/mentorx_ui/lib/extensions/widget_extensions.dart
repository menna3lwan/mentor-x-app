part of '../mentorx_ui.dart';

extension WidgetExtensions on Widget {
  Future<T?> showAsDialog<T>({
    required BuildContext context,
    Color? barrierColor,
  }) {
    return showDialog<T?>(
      context: context,
      builder: (context) => this,
      barrierColor:
          barrierColor ?? Colors.amber,
    );
  }

  Future<T?> showAsModalBottomSheet<T>({
    Color? barrierColor,
    Color? backgroundColor,
    required BuildContext context,
    bool isDismissible = true,
    bool isScrollControlled = false,
    BoxConstraints? constraints,
    bool? showDragHandle,
  }) {
    return showModalBottomSheet(
      context: context,
      enableDrag: false,
      constraints: constraints,
      builder: (context) => this,
      isDismissible: isDismissible,
      showDragHandle: showDragHandle,
      isScrollControlled: isScrollControlled,
      backgroundColor: backgroundColor ?? Colors.amber,
      barrierColor:
          barrierColor ?? Colors.amber.withValues(alpha: 0.23),
    );
  }
}
