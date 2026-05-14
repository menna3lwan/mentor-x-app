import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import 'bloc/edit_profile_page_bloc.dart';
import 'edit_profile_page_page.dart';

final class EditProfilePageWrapper extends StatefulWidget {
  const EditProfilePageWrapper({super.key});

  @override
  State<EditProfilePageWrapper> createState() => _EditProfilePageWrapperState();
}

class _AddRequest {
  final String field;
  final String oldValue;
  final String newValue;
  _AddRequest(this.field, this.oldValue, this.newValue);
}

class _EditProfilePageWrapperState extends State<EditProfilePageWrapper> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _gradeController;
  late TextEditingController _centerController;
  late TextEditingController _schoolController;
  late TextEditingController _reasonController;

  late AppSessionState _initialSession;

  @override
  void initState() {
    super.initState();
    _initialSession = context.read<AppSessionCubit>().state;
    // We cannot use context.isArabic in initState easily if it depends on inherited widget,
    // but context.read might be fine if it's not listening. We will do it in build or didChangeDependencies.
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final isAr = context.isArabic;
    _nameController = TextEditingController(
      text: isAr ? _initialSession.studentNameAr : _initialSession.studentName,
    );
    _phoneController = TextEditingController(text: _initialSession.phone);
    _gradeController = TextEditingController(
      text: isAr ? _initialSession.gradeAr : _initialSession.grade,
    );
    _centerController = TextEditingController(
      text: isAr ? _initialSession.centerAr : _initialSession.center,
    );
    _schoolController = TextEditingController(
      text: isAr ? _initialSession.schoolAr : _initialSession.school,
    );
    _reasonController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _gradeController.dispose();
    _centerController.dispose();
    _schoolController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;

    final isAr = context.isArabic;
    final requests = <_AddRequest>[];

    // Detect changes
    final currentName = isAr
        ? _initialSession.studentNameAr
        : _initialSession.studentName;
    if (_nameController.text != currentName) {
      requests.add(_AddRequest('name', currentName, _nameController.text));
    }

    if (_phoneController.text != _initialSession.phone) {
      requests.add(_AddRequest('phone', _initialSession.phone, _phoneController.text));
    }

    final currentGrade = isAr ? _initialSession.gradeAr : _initialSession.grade;
    if (_gradeController.text != currentGrade) {
      requests.add(_AddRequest('grade', currentGrade, _gradeController.text));
    }

    final currentCenter = isAr
        ? _initialSession.centerAr
        : _initialSession.center;
    if (_centerController.text != currentCenter) {
      requests.add(_AddRequest('center', currentCenter, _centerController.text));
    }

    final currentSchool = isAr
        ? _initialSession.schoolAr
        : _initialSession.school;
    if (_schoolController.text != currentSchool) {
      requests.add(_AddRequest('school', currentSchool, _schoolController.text));
    }

    if (requests.isEmpty) {
      MentorXUI.showToast(
        message:
            context.t.student['noChangesDetected'] ?? 'No changes detected',
      );
      return;
    }

    // Submit the first change
    final first = requests.first;
    context.read<EditProfilePageBloc>().add(
      EditProfilePageSubmitRequestEvent(
        fieldName: first.field,
        oldValue: first.oldValue,
        newValue: first.newValue,
        reason: _reasonController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      EditProfilePageBloc,
      EditProfilePagePresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case EditProfilePageNavigateBack():
            Navigator.of(context).pop();
          case EditProfilePageSuccess():
            MentorXUI.showToast(
              message:
                  context.t.student['requestSentSuccess'] ??
                  'Request sent successfully',
            );
            Navigator.of(context).pop();
        }
      },
      child: BlocConsumer<EditProfilePageBloc, EditProfilePageState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            MentorXUI.showToast(message: state.errorMessage!);
          }
        },
        builder: (context, state) {
          final isSubmitting = state.loadingState == LoadingState.loading;

          return EditProfilePage(
            formKey: _formKey,
            nameController: _nameController,
            phoneController: _phoneController,
            gradeController: _gradeController,
            centerController: _centerController,
            schoolController: _schoolController,
            reasonController: _reasonController,
            isSubmitting: isSubmitting,
            onSubmit: _onSubmit,
          );
        },
      ),
    );
  }
}
