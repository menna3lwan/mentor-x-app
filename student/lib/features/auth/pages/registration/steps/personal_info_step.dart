import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_core/mentorx_core.dart';
import '../bloc/student_registration_bloc.dart';

class PersonalInfoStep extends StatefulWidget {
  const PersonalInfoStep({super.key});

  @override
  State<PersonalInfoStep> createState() => _PersonalInfoStepState();
}

class _PersonalInfoStepState extends State<PersonalInfoStep> {
  final ImagePicker _imagePicker = ImagePicker();

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
              'Personal Information',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Gap(8),
            Text(
              'Please provide your basic details to get started.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: palette.textSecondary,
              ),
            ),
            const Gap(24),
            _buildPhotoPicker(context, state, bloc),
            const Gap(24),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'First Name',
                hintText: 'Enter your first name',
              ),
              onChanged: (value) =>
                  bloc.add(StudentRegistrationFirstNameChanged(value)),
              initialValue: state.firstName,
            ),
            const Gap(16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Last Name',
                hintText: 'Enter your last name',
              ),
              onChanged: (value) =>
                  bloc.add(StudentRegistrationLastNameChanged(value)),
              initialValue: state.lastName,
            ),
            const Gap(16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Phone Number',
                hintText: '01xxxxxxxxx',
                prefixIcon: const Icon(Icons.phone),
                errorText: !state.isPhoneUnique
                    ? 'Phone number already registered'
                    : null,
              ),
              onChanged: (value) =>
                  bloc.add(StudentRegistrationPhoneChanged(value)),
              initialValue: state.phone,
              keyboardType: TextInputType.phone,
            ),
            const Gap(16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email (Optional)',
                hintText: 'example@email.com',
                prefixIcon: Icon(Icons.email),
              ),
              onChanged: (value) =>
                  bloc.add(StudentRegistrationEmailChanged(value)),
              initialValue: state.email,
              keyboardType: TextInputType.emailAddress,
            ),
            const Gap(16),
            _buildGenderPicker(context, state, bloc),
            const Gap(16),
            _buildDatePicker(context, state, bloc),
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

  Widget _buildGenderPicker(
    BuildContext context,
    StudentRegistrationState state,
    StudentRegistrationBloc bloc,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gender',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const Gap(8),
        Row(
          children: [
            Expanded(
              child: _buildGenderOption(
                context,
                'Male',
                Gender.male,
                state.gender == Gender.male,
                () => bloc.add(
                  const StudentRegistrationGenderChanged(Gender.male),
                ),
              ),
            ),
            const Gap(12),
            Expanded(
              child: _buildGenderOption(
                context,
                'Female',
                Gender.female,
                state.gender == Gender.female,
                () => bloc.add(
                  const StudentRegistrationGenderChanged(Gender.female),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildGenderOption(
    BuildContext context,
    String label,
    Gender gender,
    bool isSelected,
    VoidCallback onTap,
  ) {
    final palette = MentorXThemeColorPalette.light;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? palette.brandPrimary
              : palette.backgroundSecondary,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? palette.brandPrimary : palette.textTertiary,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: isSelected ? palette.textForeground : palette.textPrimary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDatePicker(
    BuildContext context,
    StudentRegistrationState state,
    StudentRegistrationBloc bloc,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Date of Birth',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const Gap(8),
        GestureDetector(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now().subtract(
                const Duration(days: 365 * 15),
              ),
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
            );
            if (date != null) {
              bloc.add(StudentRegistrationDateOfBirthChanged(date));
            }
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: MentorXThemeColorPalette.light.backgroundSecondary,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: MentorXThemeColorPalette.light.textTertiary,
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.calendar_today, size: 20),
                const Gap(12),
                Text(
                  state.dateOfBirth != null
                      ? '${state.dateOfBirth!.year}-${state.dateOfBirth!.month}-${state.dateOfBirth!.day}'
                      : 'Select Date',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
