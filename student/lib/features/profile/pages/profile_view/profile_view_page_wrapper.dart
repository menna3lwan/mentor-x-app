import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mentorx_student/core/core.dart';
import 'bloc/profile_view_bloc.dart';
import 'profile_view_page.dart';

final class ProfileViewPageWrapper extends StatelessWidget {
  const ProfileViewPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final session = context.select<AppSessionCubit, AppSessionState>(
      (cubit) => cubit.state,
    );
    final user = context.select<AppAuthenticationCubit, StudentEntity?>(
      (cubit) => cubit.state,
    );

    return BlocPresentationListener<
      ProfileViewBloc,
      ProfileViewPresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case ProfileViewNavigateBack():
            Navigator.of(context).pop();
        }
      },
      child: BlocBuilder<ProfileViewBloc, ProfileViewState>(
        builder: (context, state) {
          return ProfileViewPage(
            session: session,
            avatarUrl: user?.profileImageUrl,
            isLoading: state.loadingState == LoadingState.loading,
            onLogout: () {
              final authCubit = context.read<AppAuthenticationCubit>();
              authCubit.logout();
              const LoginRoute().go(context);
            },
          );
        },
      ),
    );
  }
}
