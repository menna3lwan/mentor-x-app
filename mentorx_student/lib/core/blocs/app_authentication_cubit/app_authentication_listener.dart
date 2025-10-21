import 'package:mentorx_core/mentorx_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_authentication_cubit.dart';

class AppAuthenticationListener extends StatelessWidget {
  final Widget Function(BuildContext context, StudentEntity? user) builder;

  const AppAuthenticationListener({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppAuthenticationCubit, StudentEntity?>(
      builder: builder,
    );
  }
}
