part of '../mentorx_ui.dart';

class MentorXRadioButton<T> extends StatelessWidget {
  const MentorXRadioButton({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.activeColor,
  });

  final T value;
  final T? groupValue;
  final ValueChanged<T?> onChanged;
  final Color? activeColor;

  @override
  Widget build(BuildContext context) {
    return Radio<T>(
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      activeColor: activeColor ?? context.brandPrimaryColor,
      visualDensity: VisualDensity.compact,
    );
  }
}
