import 'package:event_bus/event_bus.dart';

final EventBus appEventBus = EventBus();

class AppGlobalEvent {
  const AppGlobalEvent();
}

/// Fired when language changes or auth state changes
class AppRefreshEvent extends AppGlobalEvent {
  const AppRefreshEvent();
}
