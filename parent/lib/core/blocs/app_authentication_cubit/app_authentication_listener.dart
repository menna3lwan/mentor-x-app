import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_authentication_cubit.dart';

/// Convenience widget that rebuilds [builder] whenever the
/// [AppAuthenticationCubit] emits a new state.
final class AppAuthenticationListener extends StatelessWidget {
  final Widget Function(BuildContext context, AppAuthenticationState state)
      builder;

  const AppAuthenticationListener({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppAuthenticationCubit, AppAuthenticationState>(
      builder: builder,
    );
  }
}
