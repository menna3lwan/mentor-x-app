import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'bloc/verify_identity_bloc.dart';
import 'verify_identity_page_page.dart';

class VerifyIdentityPageWrapper extends StatelessWidget {
  const VerifyIdentityPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VerifyIdentityBloc(
        repository: context.read<StudentProfileRepository>(),
      )..add(VerifyIdentityStarted()),
      child: const VerifyIdentityPagePage(),
    );
  }
}
