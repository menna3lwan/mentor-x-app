import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../blocs/app_authentication_cubit/app_authentication_cubit.dart';
import 'app_routes.dart';

/// Global navigator key — used by [AppRouter] and shell widgets.
final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

/// Routes that don't require an authenticated parent. Used by [AppRouter]'s
/// redirect to bounce anonymous users away from protected screens, and to
/// bounce already-signed-in users away from the auth screens.
const Set<String> _publicRoutePrefixes = {
  '/',
  '/onboarding',
  '/login',
  '/forgot-password',
  '/otp',
  '/register',
};

bool _isPublicLocation(String location) {
  if (_publicRoutePrefixes.contains(location)) return true;
  return _publicRoutePrefixes.any(
    (prefix) => prefix != '/' && location.startsWith('$prefix/'),
  );
}

final class AppRouter {
  final String? initialLocation;
  final AppAuthenticationCubit authenticationCubit;

  AppRouter({
    this.initialLocation,
    bool debugLogDiagnostics = false,
    required GlobalKey<NavigatorState> navigatorKey,
    required this.authenticationCubit,
  }) {
    _goRouter = _routes(navigatorKey, debugLogDiagnostics);
  }

  late final GoRouter _goRouter;
  GoRouter get routes => _goRouter;

  GoRouter _routes(
    GlobalKey<NavigatorState> navigatorKey,
    bool debugLogDiagnostics,
  ) {
    return GoRouter(
      routes: $appRoutes,
      navigatorKey: navigatorKey,
      initialLocation: initialLocation,
      debugLogDiagnostics: debugLogDiagnostics,
      // Re-evaluates redirects whenever the authentication state changes so a
      // newly-logged-in user is pushed to /home and a freshly-logged-out user
      // is pushed back to /login without the page itself having to navigate.
      refreshListenable: _AuthenticationListenable(authenticationCubit),
      redirect: _onRedirect,
    );
  }

  String? _onRedirect(BuildContext context, GoRouterState state) {
    final isAuthenticated = authenticationCubit.isAuthenticated;
    final location = state.matchedLocation;
    final isPublic = _isPublicLocation(location);

    // Splash (`/`) handles its own redirect logic — let it through.
    if (location == '/') return null;

    if (!isAuthenticated && !isPublic) {
      return '/login';
    }

    // Block authenticated users from re-entering auth screens (apart from
    // splash which they may have refreshed into).
    if (isAuthenticated &&
        (location == '/login' ||
            location == '/onboarding' ||
            location == '/register')) {
      return '/home';
    }

    return null;
  }
}

/// Adapter that turns the [AppAuthenticationCubit]'s stream into a
/// [Listenable] consumable by [GoRouter.refreshListenable].
class _AuthenticationListenable extends ChangeNotifier {
  _AuthenticationListenable(AppAuthenticationCubit cubit) {
    _subscription = cubit.stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<AppAuthenticationState> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
