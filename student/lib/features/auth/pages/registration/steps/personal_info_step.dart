import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import '../bloc/student_registration_bloc.dart';

class PersonalInfoStep extends StatefulWidget {
  const PersonalInfoStep({super.key});

  @override
  State<PersonalInfoStep> createState() => _PersonalInfoStepState();
}

class _PersonalInfoStepState extends State<PersonalInfoStep> {
  final ImagePicker _imagePicker = ImagePicker();
  late final TextEditingController _secondNameController;
  late final TextEditingController _thirdNameController;
  late final TextEditingController _fourthNameController;

  @override
  void initState() {
    super.initState();
    final state = context.read<StudentRegistrationBloc>().state;
    _secondNameController = TextEditingController(text: state.secondName);
    _thirdNameController = TextEditingController(text: state.thirdName);
    _fourthNameController = TextEditingController(text: state.fourthName);
  }

  @override
  void dispose() {
    _secondNameController.dispose();
    _thirdNameController.dispose();
    _fourthNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<StudentRegistrationBloc>();
    final palette = MentorXThemeColorPalette.light;
    return BlocBuilder<StudentRegistrationBloc, StudentRegistrationState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Complete Your Profile',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Gap(8),
            Text(
              'Please provide your full name as it appears in your documents.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: palette.textSecondary,
              ),
            ),
            const Gap(24),
            _buildPhotoPicker(context, state, bloc),
            const Gap(24),
            MentorXTextFormField(
              label: 'Second Name',
              icon: Icons.person_outline,
              controller: _secondNameController,
              onChanged: (value) =>
                  bloc.add(StudentRegistrationSecondNameChanged(value)),
            ),
            const Gap(16),
            MentorXTextFormField(
              label: 'Third Name',
              icon: Icons.person_outline,
              controller: _thirdNameController,
              onChanged: (value) =>
                  bloc.add(StudentRegistrationThirdNameChanged(value)),
            ),
            const Gap(16),
            MentorXTextFormField(
              label: 'Fourth Name (Last Name)',
              icon: Icons.person_outline,
              controller: _fourthNameController,
              onChanged: (value) =>
                  bloc.add(StudentRegistrationFourthNameChanged(value)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPhotoPicker(
    BuildContext context,
    StudentRegistrationState state,
    StudentRegistrationBloc bloc,
  ) {
    final palette = MentorXThemeColorPalette.light;
    return Center(
      child: Stack(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: palette.backgroundTertiary,
              image: state.profilePhotoPath != null
                  ? DecorationImage(
                      image: FileImage(File(state.profilePhotoPath!)),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: state.profilePhotoPath == null
                ? Icon(Icons.person, size: 50, color: palette.textTertiary)
                : null,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: CircleAvatar(
              backgroundColor: palette.brandPrimary,
              radius: 18,
              child: IconButton(
                icon: Icon(
                  Icons.camera_alt,
                  size: 20,
                  color: palette.textForeground,
                ),
                onPressed: () => _showPhotoSourcePicker(context, bloc),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showPhotoSourcePicker(
    BuildContext context,
    StudentRegistrationBloc bloc,
  ) async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library_outlined),
                title: const Text('Choose from gallery'),
                onTap: () => Navigator.of(context).pop(ImageSource.gallery),
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt_outlined),
                title: const Text('Take photo'),
                onTap: () => Navigator.of(context).pop(ImageSource.camera),
              ),
            ],
          ),
        );
      },
    );

    if (source == null) return;

    final image = await _imagePicker.pickImage(
      source: source,
      imageQuality: 80,
      maxWidth: 1200,
      maxHeight: 1200,
    );
    if (image == null) return;

    if (!mounted) return;
    bloc.add(StudentRegistrationProfilePhotoChanged(image.path));
  }
}
