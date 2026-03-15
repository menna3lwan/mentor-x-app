import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'shell_page_page.dart';

final class ShellPageWrapper extends StatelessWidget {
  const ShellPageWrapper({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return ShellPage(navigationShell: navigationShell);
  }
}
