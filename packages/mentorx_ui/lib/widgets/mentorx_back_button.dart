part of '../mentorx_ui.dart';

class MentorXBackButton extends StatelessWidget {
  const MentorXBackButton({
    super.key,
    this.onPressed,
    this.color,
  });

  final VoidCallback? onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return MentorXIconButton(
      icon: Icons.arrow_back_ios_new_rounded,
      onPressed: onPressed ?? () => Navigator.maybePop(context),
      color: color,
      variant: MentorXIconButtonVariant.ghost,
      size: MentorXIconButtonSize.medium,
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
    );
  }
}
