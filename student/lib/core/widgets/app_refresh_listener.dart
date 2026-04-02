import 'dart:async';

import 'package:flutter/material.dart';

import '../../app/student_app.dart';
import '../events/events.dart';

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

final class _AppRefreshListenerState extends State<AppRefreshListener> {
  late final StreamSubscription<AppRefreshEvent> _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = appEventBus.on<AppRefreshEvent>().listen((_) {
      widget.onRefresh();
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
