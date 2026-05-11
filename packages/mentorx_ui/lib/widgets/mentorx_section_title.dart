part of '../mentorx_ui.dart';

class MentorXSectionTitle extends StatelessWidget {
  const MentorXSectionTitle({
    super.key,
    required this.title,
    this.subtitle,
    this.onViewAll,
    this.viewAllText,
    this.padding,
  });

  final String title;
  final String? subtitle;
  final VoidCallback? onViewAll;
  final String? viewAllText;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.fromLTRB(20, 24, 20, 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: context.titleH2Style.copyWith(
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.5,
                  ),
                ),
                if (subtitle != null) ...[
                  const Gap(4),
                  Text(
                    subtitle!,
                    style: context.smallTextStyle.copyWith(
                      color: context.textSecondaryColor,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (onViewAll != null)
            MentorXSectionViewAllButton(
              onPressed: onViewAll!,
              text: viewAllText,
            ),
        ],
      ),
    );
  }
}

class MentorXSectionViewAllButton extends StatelessWidget {
  const MentorXSectionViewAllButton({
    super.key,
    required this.onPressed,
    this.text,
  });

  final VoidCallback onPressed;
  final String? text;

  @override
  Widget build(BuildContext context) {
    return PressableBox(
      onPress: onPressed,
      style: Style(
        $box.padding.vertical(6),
        $box.padding.horizontal(12),
        $box.borderRadius(10),
        $box.color(context.brandPrimaryColor.withValues(alpha: 0.05)),
        $on.hover($box.color(context.brandPrimaryColor.withValues(alpha: 0.1))),
      ),
      child: Text(
        text ?? 'View All',
        style: context.smallTextStyle.copyWith(
          color: context.brandPrimaryColor,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}
