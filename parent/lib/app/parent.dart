import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'parent_requirements.dart';

/// Root application widget. Receives fully-initialized [ParentRequirements]
/// from [main.dart] so it performs no async work itself.
final class ParentApp extends StatelessWidget {
  final ParentRequirements requirements;

  const ParentApp({super.key, required this.requirements});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: requirements.repositories.toProviders(),
      child: MultiBlocProvider(
        providers: requirements.blocs.toProviders(),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'MentorX Parent',
          routerConfig: requirements.routerConfig,
        ),
      ),
    );
  }
}
