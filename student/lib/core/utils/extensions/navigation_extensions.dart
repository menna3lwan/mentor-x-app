import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// App-specific navigation shortcuts built on top of GoRouter.
///
/// Note: GoRouter already provides [.go()], [.push()], [.pop()] directly
/// on [BuildContext] via [GoRouterHelper]. This extension adds semantic
/// helpers specific to the MentorX navigation patterns.
extension NavigationExtensions on BuildContext {
  /// Pops all routes until [location] is reached, then pushes it.
  void clearAndGo(String location) {
    while (GoRouter.of(this).canPop()) {
      GoRouter.of(this).pop();
    }
    GoRouter.of(this).go(location);
  }
}
