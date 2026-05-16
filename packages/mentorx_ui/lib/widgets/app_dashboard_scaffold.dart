part of '../mentorx_ui.dart';

class AppDashboardScaffold extends StatelessWidget {
  const AppDashboardScaffold({
    super.key,
    this.title,
    this.appBar,
    this.actions,
    required this.body,
    this.onRefresh,
    this.backgroundColor,
    this.floatingActionButton,
    this.extendBodyBehindAppBar = false,
  });

  final String? title;
  final PreferredSizeWidget? appBar;
  final List<Widget>? actions;
  final Widget body;
  final Future<void> Function()? onRefresh;
  final Color? backgroundColor;
  final Widget? floatingActionButton;
  final bool extendBodyBehindAppBar;

  @override
  Widget build(BuildContext context) {
    final defaultAppBar = title != null
        ? AppBar(
            title: Text(
              title!,
              style: context.titleH1Style.copyWith(
                fontWeight: FontWeight.w900,
                color: context.textPrimaryColor,
                letterSpacing: -0.5,
              ),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
            actions: actions,
            iconTheme: IconThemeData(color: context.textPrimaryColor),
          )
        : null;

    final content = onRefresh != null
        ? RefreshIndicator(
            onRefresh: onRefresh!,
            color: context.brandPrimaryColor,
            backgroundColor: context.backgroundPrimaryColor,
            child: body,
          )
        : body;

    return Scaffold(
      extendBodyBehindAppBar: extendBodyBehindAppBar,
      backgroundColor: backgroundColor ?? context.backgroundPrimaryColor,
      appBar: appBar ?? defaultAppBar,
      body: content,
      floatingActionButton: floatingActionButton,
    );
  }
}
