part of '../mentorx_ui.dart';

class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    super.key,
    this.appBarLeading,
    this.title,
    this.subtitle,
    this.header,
    this.progressIndicator,
    required this.body,
    this.footer,
    this.primaryButton,
    this.secondaryButton,
    this.backgroundColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 24),
    this.resizeToAvoidBottomInset = true,
    this.extendBodyBehindAppBar = false,
  });

  final Widget? appBarLeading;
  final Widget? title;
  final Widget? subtitle;
  final Widget? header;
  final Widget? progressIndicator;
  final Widget body;
  final Widget? footer;
  final Widget? primaryButton;
  final Widget? secondaryButton;
  final Color? backgroundColor;
  final EdgeInsetsGeometry padding;
  final bool resizeToAvoidBottomInset;
  final bool extendBodyBehindAppBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? context.backgroundPrimaryColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      appBar: appBarLeading != null
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              scrolledUnderElevation: 0,
              leading: appBarLeading,
            )
          : null,
      body: SafeArea(
        top: !extendBodyBehindAppBar,
        bottom: true,
        child: Padding(
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (appBarLeading == null && !extendBodyBehindAppBar) const SizedBox(height: 20),
              if (header != null) ...[
                header!,
                const SizedBox(height: 24),
              ],
              if (title != null) ...[
                DefaultTextStyle(
                  style: context.titleH1Style.copyWith(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1.0,
                    color: context.textPrimaryColor,
                  ),
                  child: title!,
                ),
                const SizedBox(height: 8),
              ],
              if (subtitle != null) ...[
                DefaultTextStyle(
                  style: context.bodySecondaryStyle.copyWith(
                    fontSize: 15,
                    color: context.textSecondaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                  child: subtitle!,
                ),
                const SizedBox(height: 24),
              ],
              if (progressIndicator != null) ...[
                progressIndicator!,
                const SizedBox(height: 16),
              ],
              Expanded(child: body),
              const SizedBox(height: 16),
              if (primaryButton != null) ...[
                primaryButton!,
                const SizedBox(height: 12),
              ],
              if (secondaryButton != null) ...[
                secondaryButton!,
                const SizedBox(height: 8),
              ],
              if (footer != null) footer!,
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
