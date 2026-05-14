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
    this.systemOverlayStyle,
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
  final SystemUiOverlayStyle? systemOverlayStyle;

  @override
  Widget build(BuildContext context) {
    final isDarkBackground = backgroundColor == context.brandPrimaryColor;
    final isTransparent =
        backgroundColor == null || backgroundColor == Colors.transparent;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return AppBar(
      title: title ??
          (titleText != null
              ? Text(
                  titleText!,
                  style: context.titleH2Style.copyWith(
                    color: isDarkBackground
                        ? Colors.white
                        : context.textPrimaryColor,
                    fontWeight: FontWeight.w900,
                    fontSize: 22,
                    letterSpacing: -0.5,
                  ),
                )
              : null),
      leading: leading ??
          (showBackButton && Navigator.canPop(context)
              ? MentorXBackButton(
                  color: isDarkBackground ? Colors.white : null,
                )
              : null),
      actions: actions,
      backgroundColor: backgroundColor ?? Colors.transparent,
      centerTitle: centerTitle,
      elevation: elevation,
      surfaceTintColor: Colors.transparent,
      bottom: bottom,
      systemOverlayStyle: systemOverlayStyle ??
          (isTransparent
              ? (isDarkMode
                  ? SystemUiOverlayStyle.light
                  : SystemUiOverlayStyle.dark)
              : null),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (bottom?.preferredSize.height ?? 0),
      );
}
