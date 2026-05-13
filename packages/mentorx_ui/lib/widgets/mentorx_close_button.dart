part of '../mentorx_ui.dart';

class MentorXCloseButton extends StatelessWidget {
  const MentorXCloseButton({
    super.key,
    this.onPressed,
    this.color,
  });

  final VoidCallback? onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return MentorXIconButton(
      icon: Icons.close_rounded,
      onPressed: onPressed ?? () => Navigator.maybePop(context),
      color: color ?? context.textPrimaryColor,
      variant: MentorXIconButtonVariant.ghost,
      size: MentorXIconButtonSize.small,
      tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
    );
  }
}
