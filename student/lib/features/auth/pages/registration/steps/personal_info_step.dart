import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import '../bloc/student_registration_bloc.dart';

final class PersonalInfoStep extends StatefulWidget {
  const PersonalInfoStep({super.key});

  @override
  State<PersonalInfoStep> createState() => _PersonalInfoStepState();
}

final class _PersonalInfoStepState extends State<PersonalInfoStep> {
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
    final t = context.t.student;
    final bloc = context.read<StudentRegistrationBloc>();
    return Builder(
      builder: (context) {
        final profilePhotoPath = context.select(
          (StudentRegistrationBloc bloc) => bloc.state.profilePhotoPath,
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInDown(
              duration: const Duration(milliseconds: 400),
              child: Text(
                t['completeProfileTitle'] ?? 'Complete Your Profile',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: context.textPrimaryColor,
                  letterSpacing: -1.0,
                ),
              ),
            ),
            const Gap(12),
            FadeInDown(
              duration: const Duration(milliseconds: 500),
              child: Text(
                t['completeProfileSubtitle'] ??
                    'Please provide your full name as it appears in your official documents.',
                style: TextStyle(
                  color: context.textSecondaryColor,
                  fontSize: 15,
                  height: 1.6,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Gap(40),
            ZoomIn(
              duration: const Duration(milliseconds: 500),
              child: _buildPhotoPicker(context, profilePhotoPath, bloc),
            ),
            const Gap(48),
            FadeInUp(
              duration: const Duration(milliseconds: 400),
              child: MentorXTextFormField(
                key: const Key('registration_second_name'),
                label: t['secondNameLabel'] ?? "Father's Name",
                icon: Icons.person_outline_rounded,
                controller: _secondNameController,
                onChanged: (value) =>
                    bloc.add(StudentRegistrationSecondNameChanged(value)),
              ),
            ),
            const Gap(20),
            FadeInUp(
              duration: const Duration(milliseconds: 500),
              child: MentorXTextFormField(
                key: const Key('registration_third_name'),
                label: t['thirdNameLabel'] ?? "Grandfather's Name",
                icon: Icons.person_outline_rounded,
                controller: _thirdNameController,
                onChanged: (value) =>
                    bloc.add(StudentRegistrationThirdNameChanged(value)),
              ),
            ),
            const Gap(20),
            FadeInUp(
              duration: const Duration(milliseconds: 600),
              child: MentorXTextFormField(
                key: const Key('registration_fourth_name'),
                label: t['fourthNameLabel'] ?? 'Family Name (Last Name)',
                icon: Icons.people_outline_rounded,
                controller: _fourthNameController,
                onChanged: (value) =>
                    bloc.add(StudentRegistrationFourthNameChanged(value)),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPhotoPicker(
    BuildContext context,
    String? profilePhotoPath,
    StudentRegistrationBloc bloc,
  ) {
    return Center(
      child: Stack(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.backgroundSecondaryColor,
              border: Border.all(
                color: context.brandPrimaryColor.withValues(alpha: 0.2),
                width: 4,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 25,
                  offset: const Offset(0, 12),
                ),
              ],
              image: profilePhotoPath != null
                  ? DecorationImage(
                      image: FileImage(File(profilePhotoPath)),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: profilePhotoPath == null
                ? Icon(
                    Icons.person_add_rounded,
                    size: 48,
                    color: context.brandPrimaryColor.withValues(alpha: 0.5),
                  )
                : null,
          ),
          Positioned(
            bottom: 4,
            right: 4,
            child: GestureDetector(
              onTap: () => _showPhotoSourcePicker(context, bloc),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: context.brandPrimaryColor,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: context.backgroundPrimaryColor,
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: context.brandPrimaryColor.withValues(alpha: 0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.camera_alt_rounded,
                  size: 20,
                  color: Colors.white,
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
    final t = context.t.student;
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: context.backgroundSecondaryColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
            border: Border.all(
              color: context.borderPrimaryColor.withValues(alpha: 0.05),
            ),
          ),
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 48),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: context.textTertiaryColor.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const Gap(32),
              Text(
                t['personalPhotoLabel'] ?? 'Profile Photo',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: context.textPrimaryColor,
                  letterSpacing: -0.5,
                ),
              ),
              const Gap(40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _PhotoSourceOption(
                    icon: Icons.photo_library_outlined,
                    label: t['gallery'] ?? 'Gallery',
                    onTap: () => Navigator.of(context).pop(ImageSource.gallery),
                  ),
                  _PhotoSourceOption(
                    icon: Icons.camera_alt_outlined,
                    label: t['camera'] ?? 'Camera',
                    onTap: () => Navigator.of(context).pop(ImageSource.camera),
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

final class _PhotoSourceOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _PhotoSourceOption({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: context.brandPrimaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: context.brandPrimaryColor.withValues(alpha: 0.1),
              ),
            ),
            child: Icon(icon, color: context.brandPrimaryColor, size: 36),
          ),
          const Gap(16),
          Text(
            label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: context.textPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
