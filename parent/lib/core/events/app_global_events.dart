import 'package:event_bus/event_bus.dart';

/// Singleton event bus — import this file to fire or listen to events.
final EventBus appEventBus = EventBus();

// ──────────────────────────────────────────────────────────────────────────────
// Base
// ──────────────────────────────────────────────────────────────────────────────

sealed class AppGlobalEvent {
  const AppGlobalEvent();
}

// ──────────────────────────────────────────────────────────────────────────────
// Concrete events
// ──────────────────────────────────────────────────────────────────────────────

/// Fired when the language changes or auth state changes, so screens
/// can reload their data.
final class AppRefreshEvent extends AppGlobalEvent {
  const AppRefreshEvent();
}

/// Fired after login to instruct the app shell to navigate to a
/// specific route (e.g. from a deep-link or deferred action).
final class AppPostLoginNavigationEvent extends AppGlobalEvent {
  /// Route location to navigate to immediately after login.
  final String location;
  const AppPostLoginNavigationEvent({required this.location});
}
