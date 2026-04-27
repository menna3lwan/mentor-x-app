import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
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
            FadeInDown(
              duration: const Duration(milliseconds: 400),
              child: Text(
                'Complete Your Profile',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: palette.textPrimary,
                    ),
              ),
            ),
            const Gap(8),
            FadeInDown(
              duration: const Duration(milliseconds: 500),
              child: Text(
                'Please provide your full name as it appears in your official documents.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: palette.textSecondary,
                      height: 1.5,
                    ),
              ),
            ),
            const Gap(32),
            ZoomIn(
              duration: const Duration(milliseconds: 500),
              child: _buildPhotoPicker(context, state, bloc),
            ),
            const Gap(32),
            FadeInUp(
              duration: const Duration(milliseconds: 400),
              child: MentorXTextFormField(
                label: 'Father\'s Name',
                icon: Icons.person_outline_rounded,
                controller: _secondNameController,
                onChanged: (value) => bloc.add(StudentRegistrationSecondNameChanged(value)),
              ),
            ),
            const Gap(16),
            FadeInUp(
              duration: const Duration(milliseconds: 500),
              child: MentorXTextFormField(
                label: 'Grandfather\'s Name',
                icon: Icons.person_outline_rounded,
                controller: _thirdNameController,
                onChanged: (value) => bloc.add(StudentRegistrationThirdNameChanged(value)),
              ),
            ),
            const Gap(16),
            FadeInUp(
              duration: const Duration(milliseconds: 600),
              child: MentorXTextFormField(
                label: 'Family Name (Last Name)',
                icon: Icons.people_outline_rounded,
                controller: _fourthNameController,
                onChanged: (value) => bloc.add(StudentRegistrationFourthNameChanged(value)),
              ),
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
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: palette.backgroundSecondary,
              border: Border.all(color: palette.brandPrimary.withValues(alpha: 0.2), width: 3),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
              image: state.profilePhotoPath != null
                  ? DecorationImage(
                      image: FileImage(File(state.profilePhotoPath!)),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: state.profilePhotoPath == null
                ? Icon(Icons.person_add_rounded, size: 40, color: palette.brandPrimary.withValues(alpha: 0.5))
                : null,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => _showPhotoSourcePicker(context, bloc),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: palette.brandPrimary,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2.5),
                  boxShadow: [
                    BoxShadow(
                      color: palette.brandPrimary.withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.camera_alt_rounded,
                  size: 18,
                  color: palette.textForeground,
                ),
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
    final palette = MentorXThemeColorPalette.light;
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          ),
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Profile Photo',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: palette.textPrimary,
                ),
              ),
              const Gap(24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _PhotoSourceOption(
                    icon: Icons.photo_library_outlined,
                    label: 'Gallery',
                    onTap: () => Navigator.of(context).pop(ImageSource.gallery),
                    palette: palette,
                  ),
                  _PhotoSourceOption(
                    icon: Icons.camera_alt_outlined,
                    label: 'Camera',
                    onTap: () => Navigator.of(context).pop(ImageSource.camera),
                    palette: palette,
                  ),
                ],
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

class _PhotoSourceOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final MentorXThemeColorPalette palette;

  const _PhotoSourceOption({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.palette,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: palette.brandPrimary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: palette.brandPrimary, size: 32),
          ),
          const Gap(12),
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: palette.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
