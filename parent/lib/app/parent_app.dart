import 'package:flutter/material.dart';
import 'package:parent/core/core.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

class ParentApp extends StatelessWidget {
  const ParentApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: const LoginPageRoute().location,
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'MentorX Parent',
      routerConfig: appRouter.routes,
    );
  }
}
