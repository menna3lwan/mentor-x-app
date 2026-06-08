import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../../../core/blocs/app_authentication_cubit/app_authentication_cubit.dart';
import '../../../core/routing/app_routes.dart';
import '../bloc/change_password_bloc.dart';

class ChangePasswordPageWrapper extends StatelessWidget {
  const ChangePasswordPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordBloc(
        profileRepository: context.read<ParentProfileRepository>(),
      ),
      child: const _ChangePasswordView(),
    );
  }
}

class _ChangePasswordView extends StatefulWidget {
  const _ChangePasswordView();

  @override
  State<_ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<_ChangePasswordView> {
  final _formKey = GlobalKey<FormState>();
  final _currentController = TextEditingController();
  final _newController = TextEditingController();
  final _confirmController = TextEditingController();

  @override
  void dispose() {
    _currentController.dispose();
    _newController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;

    return BlocPresentationListener<
      ChangePasswordBloc,
      ChangePasswordPresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case ChangePasswordSucceededPresentationEvent():
            MentorXUI.showToast(message: t.profile.changePasswordSuccess);
            if (context.canPop()) {
              context.pop();
            } else {
              const SettingsRoute().go(context);
            }
          case ChangePasswordFailedPresentationEvent(:final kind):
            MentorXUI.showToast(
              message: _messageFor(t, kind),
              isError: true,
            );
          case ChangePasswordUnauthorizedPresentationEvent():
            MentorXUI.showToast(
              message: t.profile.editUnauthorized,
              isError: true,
            );
            context.read<AppAuthenticationCubit>().logout();
            const LoginPageRoute().go(context);
        }
      },
      child: Scaffold(
        backgroundColor: context.backgroundPrimaryColor,
        appBar: AppBar(
          backgroundColor: context.backgroundSecondaryColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: context.textPrimaryColor,
              size: 20,
            ),
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                const SettingsRoute().go(context);
              }
            },
          ),
          title: Text(
            t.profile.changePasswordTitle,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: context.brandPrimaryColor,
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 24,
            ),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    t.profile.changePasswordHint,
                    style: TextStyle(
                      color: context.textSecondaryColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                    ),
                  ),
                  const Gap(28),
                  MentorXTextFormField(
                    controller: _currentController,
                    label: t.profile.changePasswordCurrentLabel,
                    isPassword: true,
                    icon: Icons.lock_outline_rounded,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => context
                        .read<ChangePasswordBloc>()
                        .add(ChangePasswordCurrentChanged(value)),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return t.profile.changePasswordCurrentRequired;
                      }
                      return null;
                    },
                  ),
                  const Gap(20),
                  MentorXTextFormField(
                    controller: _newController,
                    label: t.profile.changePasswordNewLabel,
                    isPassword: true,
                    icon: Icons.lock_rounded,
                    textInputAction: TextInputAction.next,
                    onChanged: (value) => context
                        .read<ChangePasswordBloc>()
                        .add(ChangePasswordNewChanged(value)),
                    validator: (value) {
                      if (value == null || value.length < 8) {
                        return t.profile.changePasswordTooWeak;
                      }
                      return null;
                    },
                  ),
                  const Gap(20),
                  MentorXTextFormField(
                    controller: _confirmController,
                    label: t.profile.changePasswordConfirmLabel,
                    isPassword: true,
                    icon: Icons.lock_reset_rounded,
                    textInputAction: TextInputAction.done,
                    onChanged: (value) => context
                        .read<ChangePasswordBloc>()
                        .add(ChangePasswordConfirmChanged(value)),
                    validator: (value) {
                      if (value != _newController.text) {
                        return t.profile.changePasswordMismatch;
                      }
                      return null;
                    },
                  ),
                  const Gap(36),
                  BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
                    buildWhen: (a, b) => a.status != b.status,
                    builder: (context, state) {
                      return MentorXButton(
                        loading: state.isSubmitting,
                        label: t.profile.changePasswordAction,
                        onPressed: state.isSubmitting
                            ? null
                            : () {
                                FocusScope.of(context).unfocus();
                                if (!(_formKey.currentState?.validate() ??
                                    false)) {
                                  return;
                                }
                                context.read<ChangePasswordBloc>().add(
                                  const ChangePasswordSubmitted(),
                                );
                              },
                      );
                    },
                  ),
                  const Gap(20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _messageFor(TranslationsParentEn t, ChangePasswordFailureKind kind) {
    return switch (kind) {
      ChangePasswordFailureKind.wrongCurrentPassword =>
        t.profile.changePasswordWrongCurrent,
      ChangePasswordFailureKind.passwordTooWeak =>
        t.profile.changePasswordTooWeak,
      ChangePasswordFailureKind.passwordsMismatch =>
        t.profile.changePasswordMismatch,
      ChangePasswordFailureKind.network => t.profile.editNetworkError,
      ChangePasswordFailureKind.unauthorized => t.profile.editUnauthorized,
      ChangePasswordFailureKind.unknown => t.profile.changePasswordFailed,
    };
  }
}
