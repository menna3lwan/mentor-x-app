import 'dart:async';

import 'package:flutter/material.dart';

import '../events/app_global_events.dart';

/// Listens to [AppRefreshEvent] on the [appEventBus] and calls [onRefresh]
/// to let parent screens reload their data.
///
/// Wrap a page body with this to wire up event-bus-driven refreshes:
///
/// ```dart
/// AppRefreshListener(
///   onRefresh: () => context.read<MyBloc>().add(const MyRefreshEvent()),
///   child: MyPageBody(),
/// )
/// ```
final class AppRefreshListener extends StatefulWidget {
  final Widget child;
  final VoidCallback onRefresh;

  const AppRefreshListener({
    super.key,
    required this.child,
    required this.onRefresh,
  });

  @override
  State<AppRefreshListener> createState() => _AppRefreshListenerState();
}

class _AppRefreshListenerState extends State<AppRefreshListener> {
  StreamSubscription<AppRefreshEvent>? _subscription;

  @override
  void initState() {
    super.initState();
    // Holding the subscription so it can be cancelled in [dispose] — without
    // this the listener leaks: every page that mounted this widget keeps a
    // dangling closure pointing at the old [BuildContext], firing forever.
    _subscription = appEventBus.on<AppRefreshEvent>().listen((_) {
      if (mounted) widget.onRefresh();
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _subscription = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
