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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? context.backgroundPrimaryColor,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      appBar: appBarLeading != null
          ? AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: appBarLeading,
            )
          : null,
      body: SafeArea(
        child: Padding(
          padding: padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (appBarLeading == null) const SizedBox(height: 20),
              if (header != null) ...[
                header!,
                const SizedBox(height: 24),
              ],
              if (title != null) ...[
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: context.brandPrimaryColor,
                  ),
                  child: title!,
                ),
                const SizedBox(height: 8),
              ],
              if (subtitle != null) ...[
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 14,
                    color: context.textSecondaryColor,
                  ),
                  child: subtitle!,
                ),
                const SizedBox(height: 12),
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
