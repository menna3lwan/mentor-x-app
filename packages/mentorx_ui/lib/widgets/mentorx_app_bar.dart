part of '../mentorx_ui.dart';

class MentorXAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MentorXAppBar({
    super.key,
    this.title,
    this.titleText,
    this.leading,
    this.actions,
    this.backgroundColor,
    this.centerTitle = true,
    this.showBackButton = true,
    this.elevation = 0,
    this.bottom,
  });

  final Widget? title;
  final String? titleText;
  final Widget? leading;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final bool centerTitle;
  final bool showBackButton;
  final double elevation;
  final PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title ??
          (titleText != null
              ? Text(
                  titleText!,
                  style: context.titleH2Style.copyWith(
                    color: backgroundColor == context.brandPrimaryColor
                        ? Colors.white
                        : context.textPrimaryColor,
                    fontWeight: FontWeight.w900,
                  ),
                )
              : null),
      leading: leading ??
          (showBackButton && Navigator.canPop(context)
              ? MentorXBackButton(
                  color: backgroundColor == context.brandPrimaryColor
                      ? Colors.white
                      : context.brandPrimaryColor,
                )
              : null),
      actions: actions,
      backgroundColor: backgroundColor ?? Colors.transparent,
      centerTitle: centerTitle,
      elevation: elevation,
      surfaceTintColor: Colors.transparent,
      bottom: bottom,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (bottom?.preferredSize.height ?? 0),
      );
}
