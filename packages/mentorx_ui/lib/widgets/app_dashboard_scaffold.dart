part of '../mentorx_ui.dart';

class AppDashboardScaffold extends StatelessWidget {
  const AppDashboardScaffold({
    super.key,
    required this.title,
    this.actions,
    required this.body,
    this.onRefresh,
    this.backgroundColor,
    this.floatingActionButton,
  });

  final String title;
  final List<Widget>? actions;
  final Widget body;
  final Future<void> Function()? onRefresh;
  final Color? backgroundColor;
  final Widget? floatingActionButton;

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold(
      backgroundColor: backgroundColor ?? context.backgroundPrimaryColor,
      appBar: AppBar(
        title: Text(
          title,
          style: context.titleH1Style.copyWith(
                fontWeight: FontWeight.w800,
                color: context.brandPrimaryColor,
              ),
        ),
        backgroundColor: context.backgroundSecondaryColor,
        elevation: 0,
        actions: actions,
      ),
      body: onRefresh != null
          ? RefreshIndicator(
              onRefresh: onRefresh!,
              child: body,
            )
          : body,
      floatingActionButton: floatingActionButton,
    );

    return scaffold;
  }
}
