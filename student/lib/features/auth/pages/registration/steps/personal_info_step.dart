import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:mentorx_student/core/core.dart';
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
    final bloc = context.read<StudentRegistrationBloc>();
    return Builder(
      builder: (context) {
        final profilePhotoPath = context.select(
          (StudentRegistrationBloc bloc) => bloc.state.profilePhotoPath,
        );

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInDown(
                duration: const Duration(milliseconds: 400),
                child: Text(
                  context.t.auth.registerTitle,
                  style: context.titleH1Style.copyWith(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1.0,
                  ),
                ),
              ),
              const Gap(12),
              FadeInDown(
                duration: const Duration(milliseconds: 500),
                child: Text(
                  context.t.auth.personalInfoDesc,
                  style: context.bodySecondaryStyle.copyWith(
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
                child: MentorXGlassCard(
                  style: Style(
                    $box.padding.all(24),
                    $box.borderRadius(32),
                  ),
                  child: Column(
                    children: [
                      MentorXTextFormField(
                        key: const Key('registration_second_name'),
                        label: context.t.auth.secondNameLabel,
                        icon: Icons.person_outline_rounded,
                        controller: _secondNameController,
                        onChanged: (value) =>
                            bloc.add(StudentRegistrationSecondNameChanged(value)),
                      ),
                      const Gap(20),
                      MentorXTextFormField(
                        key: const Key('registration_third_name'),
                        label: context.t.auth.thirdNameLabel,
                        icon: Icons.person_outline_rounded,
                        controller: _thirdNameController,
                        onChanged: (value) =>
                            bloc.add(StudentRegistrationThirdNameChanged(value)),
                      ),
                      const Gap(20),
                      MentorXTextFormField(
                        key: const Key('registration_fourth_name'),
                        label: context.t.auth.fourthNameLabel,
                        icon: Icons.people_outline_rounded,
                        controller: _fourthNameController,
                        onChanged: (value) =>
                            bloc.add(StudentRegistrationFourthNameChanged(value)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
          MentorXGlassCard(
            style: Style(
              $box.width(120),
              $box.height(120),
              $box.borderRadius(60),
              $box.padding.all(4),
              $box.color(context.backgroundSecondaryColor.withValues(alpha: 0.5)),
            ),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
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
    final t = context.t;
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
                t.auth.personalPhotoLabel,
                style: context.titleH2Style.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -0.5,
                ),
              ),
              const Gap(40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _PhotoSourceOption(
                    icon: Icons.photo_library_outlined,
                    label: t.auth.gallery,
                    onTap: () => Navigator.of(context).pop(ImageSource.gallery),
                  ),
                  _PhotoSourceOption(
                    icon: Icons.camera_alt_outlined,
                    label: t.auth.camera,
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
          MentorXGlassCard(
            style: Style(
              $box.padding.all(24),
              $box.borderRadius(24),
              $box.color(context.brandPrimaryColor.withValues(alpha: 0.1)),
            ),
            child: Icon(icon, color: context.brandPrimaryColor, size: 36),
          ),
          const Gap(16),
          Text(
            label,
            style: context.bodyPrimaryStyle.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
