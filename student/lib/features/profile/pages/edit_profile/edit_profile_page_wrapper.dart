import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import 'bloc/edit_profile_bloc.dart';
import 'edit_profile_page.dart';

final class EditProfilePageWrapper extends StatefulWidget {
  const EditProfilePageWrapper({super.key});

  @override
  State<EditProfilePageWrapper> createState() => _EditProfilePageWrapperState();
}

class _EditProfilePageWrapperState extends State<EditProfilePageWrapper> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _firstNameController;
  late TextEditingController _secondNameController;
  late TextEditingController _thirdNameController;
  late TextEditingController _fourthNameController;
  late TextEditingController _phoneController;
  late TextEditingController _gradeController;
  late TextEditingController _centerController;
  late TextEditingController _schoolController;
  late TextEditingController _governorateController;
  late TextEditingController _areaController;
  late TextEditingController _educationDepartmentController;

  late StudentEntity? _user;

  @override
  void initState() {
    super.initState();
    _user = context.read<AppAuthenticationCubit>().state;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _firstNameController = TextEditingController(text: _user?.firstName);
    _secondNameController = TextEditingController(text: _user?.secondName);
    _thirdNameController = TextEditingController(text: _user?.thirdName);
    _fourthNameController = TextEditingController(text: _user?.fourthName);
    _phoneController = TextEditingController(text: _user?.phoneNumber);
    _gradeController = TextEditingController(text: _user?.gradeName);
    _centerController = TextEditingController(text: _user?.centerName);
    _schoolController = TextEditingController(text: _user?.schoolName);
    _governorateController = TextEditingController(text: _user?.governorate);
    _areaController = TextEditingController(text: _user?.area);
    _educationDepartmentController = TextEditingController(text: _user?.educationDepartment);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _secondNameController.dispose();
    _thirdNameController.dispose();
    _fourthNameController.dispose();
    _phoneController.dispose();
    _gradeController.dispose();
    _centerController.dispose();
    _schoolController.dispose();
    _governorateController.dispose();
    _areaController.dispose();
    _educationDepartmentController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;

    final updatedUser = _user?.copyWith(
      firstName: _firstNameController.text,
      secondName: MentorXNullableValue(_firstNameController.text.isNotEmpty ? _secondNameController.text : null),
      thirdName: MentorXNullableValue(_firstNameController.text.isNotEmpty ? _thirdNameController.text : null),
      fourthName: MentorXNullableValue(_firstNameController.text.isNotEmpty ? _fourthNameController.text : null),
      gradeName: MentorXNullableValue(_gradeController.text),
      centerName: MentorXNullableValue(_centerController.text),
      schoolName: MentorXNullableValue(_schoolController.text),
      governorate: MentorXNullableValue(_governorateController.text),
      area: MentorXNullableValue(_areaController.text),
      educationDepartment: MentorXNullableValue(_educationDepartmentController.text),
    );

    if (updatedUser == _user) {
      MentorXUI.showToast(
        message: context.t.profile.noChangesDetected,
      );
      return;
    }

    context.read<EditProfileBloc>().add(
      EditProfileUpdateProfileEvent(updatedUser: updatedUser!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      EditProfileBloc,
      EditProfilePresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case EditProfileNavigateBack():
            Navigator.of(context).pop();
          case EditProfileSuccess():
            MentorXUI.showToast(
              message: context.t.profile.requestSentSuccess,
            );
            Navigator.of(context).pop();
        }
      },
      child: BlocConsumer<EditProfileBloc, EditProfileState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            MentorXUI.showToast(message: state.errorMessage!);
          }
        },
        builder: (context, state) {
          final isSubmitting = state.loadingState == LoadingState.loading;

          return EditProfilePage(
            formKey: _formKey,
            firstNameController: _firstNameController,
            secondNameController: _secondNameController,
            thirdNameController: _thirdNameController,
            fourthNameController: _fourthNameController,
            phoneController: _phoneController,
            gradeController: _gradeController,
            centerController: _centerController,
            schoolController: _schoolController,
            governorateController: _governorateController,
            areaController: _areaController,
            educationDepartmentController: _educationDepartmentController,
            isSubmitting: isSubmitting,
            onSubmit: _onSubmit,
          );
        },
      ),
    );
  }
}
