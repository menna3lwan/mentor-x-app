import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_student/core/core.dart';


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
