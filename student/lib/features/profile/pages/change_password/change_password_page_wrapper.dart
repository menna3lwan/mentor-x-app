import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import 'bloc/change_password_bloc.dart';
import 'change_password_page.dart';

final class ChangePasswordPageWrapper extends StatefulWidget {
  const ChangePasswordPageWrapper({super.key});

  @override
  State<ChangePasswordPageWrapper> createState() =>
      _ChangePasswordPageWrapperState();
}

class _ChangePasswordPageWrapperState extends State<ChangePasswordPageWrapper> {
  final _formKey = GlobalKey<FormState>();
  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

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

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;

    context.read<ChangePasswordBloc>().add(
      ChangePasswordSubmitEvent(
        currentPassword: _currentController.text,
        newPassword: _newController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      ChangePasswordBloc,
      ChangePasswordPresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case ChangePasswordNavigateBack():
            Navigator.of(context).pop();
          case ChangePasswordSuccess():
            Navigator.of(context).pop();
        }
      },
      child: BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            MentorXUI.showToast(message: state.errorMessage!);
          }
        },
        builder: (context, state) {
          final isSubmitting = state.loadingState == LoadingState.loading;

          return ChangePasswordPage(
            formKey: _formKey,
            currentController: _currentController,
            newController: _newController,
            confirmController: _confirmController,
            obscureCurrent: _obscureCurrent,
            obscureNew: _obscureNew,
            obscureConfirm: _obscureConfirm,
            isSubmitting: isSubmitting,
            onToggleCurrent: () =>
                setState(() => _obscureCurrent = !_obscureCurrent),
            onToggleNew: () => setState(() => _obscureNew = !_obscureNew),
            onToggleConfirm: () =>
                setState(() => _obscureConfirm = !_obscureConfirm),
            onSubmit: _onSubmit,
          );
        },
      ),
    );
  }
}
