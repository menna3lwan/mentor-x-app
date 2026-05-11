part of '../mentorx_ui.dart';

class MentorXBottomSheet extends StatelessWidget {
  const MentorXBottomSheet({
    super.key,
    required this.child,
    this.title,
    this.showCloseButton = true,
    this.padding,
  });

  final Widget child;
  final String? title;
  final bool showCloseButton;
  final EdgeInsetsGeometry? padding;

  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    bool showCloseButton = true,
    EdgeInsetsGeometry? padding,
    bool isScrollControlled = true,
    bool useRootNavigator = false,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: isScrollControlled,
      useRootNavigator: useRootNavigator,
      backgroundColor: Colors.transparent,
      builder: (context) => MentorXBottomSheet(
        title: title,
        showCloseButton: showCloseButton,
        padding: padding,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      padding: padding ?? const EdgeInsets.fromLTRB(24, 12, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 24),
            decoration: BoxDecoration(
              color: context.textTertiaryColor.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          if (title != null || showCloseButton) ...[
            Row(
              children: [
                if (title != null)
                  Expanded(
                    child: Text(
                      title!,
                      style: context.titleH2Style.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                if (showCloseButton) const MentorXCloseButton(),
              ],
            ),
            const Gap(16),
          ],
          Flexible(child: child),
        ],
      ),
    );
  }
}

class MentorXBottomSheetTile extends StatelessWidget {
  const MentorXBottomSheetTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.color,
    this.isDestructive = false,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final Color? color;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = isDestructive 
        ? context.statusDangerColor 
        : (color ?? context.textPrimaryColor);

    return PressableBox(
      onPress: onTap,
      style: Style(
        $box.padding.vertical(12),
        $box.padding.horizontal(16),
        $box.borderRadius(16),
        $box.color(Colors.transparent),
        $on.hover($box.color(context.backgroundTertiaryColor.withValues(alpha: 0.5))),
      ),
      child: Row(
        children: [
          if (leading != null) ...[
            IconTheme(
              data: IconThemeData(color: effectiveColor, size: 24),
              child: leading!,
            ),
            const Gap(16),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: context.bodyPrimaryStyle.copyWith(
                    fontWeight: FontWeight.w700,
                    color: effectiveColor,
                  ),
                ),
                if (subtitle != null)
                  Text(
                    subtitle!,
                    style: context.smallTextStyle.copyWith(
                      color: isDestructive 
                          ? context.statusDangerColor.withValues(alpha: 0.7)
                          : context.textSecondaryColor,
                    ),
                  ),
              ],
            ),
          ),
          if (trailing != null) ...[
            const Gap(16),
            IconTheme(
              data: IconThemeData(color: effectiveColor, size: 20),
              child: trailing!,
            ),
          ],
        ],
      ),
    );
  }
}
