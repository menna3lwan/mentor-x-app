import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:analytics_service/analytics_service.dart';

import 'app_routes.dart';

final class AppRouter {
  final String? initialLocation;

  AppRouter({
    this.initialLocation,
    bool debugLogDiagnostics = false,
    required GlobalKey<NavigatorState> navigatorKey,
    AnalyticsService? analyticsService,
  }) {
    _goRouter = _routes(
      navigatorKey,
      debugLogDiagnostics,
      analyticsService,
    );
  }

  late final GoRouter _goRouter;

  GoRouter get routes => _goRouter;

  GoRouter _routes(
    GlobalKey<NavigatorState> navigatorKey,
    bool debugLogDiagnostics,
    AnalyticsService? analyticsService,
  ) {
    return GoRouter(
      routes: $appRoutes,
      navigatorKey: navigatorKey,
      initialLocation: initialLocation,
      debugLogDiagnostics: debugLogDiagnostics,
      observers: [
        if (analyticsService is FirebaseAnalyticsService)
          analyticsService.observer,
      ],
    );
  }
}
