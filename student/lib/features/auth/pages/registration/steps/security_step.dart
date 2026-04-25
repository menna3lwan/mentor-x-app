import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import '../bloc/student_registration_bloc.dart';

class SecurityStep extends StatefulWidget {
  const SecurityStep({super.key});

  @override
  State<SecurityStep> createState() => _SecurityStepState();
}

class _SecurityStepState extends State<SecurityStep> {
  final ImagePicker _imagePicker = ImagePicker();
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    final state = context.read<StudentRegistrationBloc>().state;
    _passwordController = TextEditingController(text: state.password);
    _confirmPasswordController = TextEditingController(text: state.confirmPassword);
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
              'Security & Verification',
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Gap(8),
            Text(
              'Secure your account and verify your identity.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: palette.textSecondary,
              ),
            ),
            const Gap(24),
            MentorXTextFormField(
              label: 'Password',
              icon: Icons.lock_outline,
              controller: _passwordController,
              isPassword: true,
              onChanged: (value) =>
                  bloc.add(StudentRegistrationPasswordChanged(value)),
            ),
            const Gap(8),
            _buildPasswordStrength(context, state.password),
            const Gap(16),
            MentorXTextFormField(
              label: 'Confirm Password',
              icon: Icons.lock_clock_outlined,
              controller: _confirmPasswordController,
              isPassword: true,
              errorText:
                  state.password != state.confirmPassword &&
                      state.confirmPassword.isNotEmpty
                  ? 'Passwords do not match'
                  : null,
              onChanged: (value) =>
                  bloc.add(StudentRegistrationConfirmPasswordChanged(value)),
            ),
            const Gap(24),
            _buildIdCardUpload(context, state, bloc),
          ],
        );
      },
    );
  }

  Widget _buildPasswordStrength(BuildContext context, String password) {
    final palette = MentorXThemeColorPalette.light;
    final score = _passwordStrengthScore(password);

    final String label;
    final Color color;
    switch (score) {
      case <= 0.33:
        label = 'Weak';
        color = palette.statusDanger;
      case <= 0.66:
        label = 'Medium';
        color = palette.statusWarning;
      default:
        label = 'Strong';
        color = palette.statusSuccess;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: score,
            minHeight: 6,
            color: color,
            backgroundColor: palette.backgroundTertiary,
          ),
        ),
        const Gap(6),
        Text(
          'Password strength: $label',
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: color),
        ),
      ],
    );
  }

  double _passwordStrengthScore(String value) {
    if (value.isEmpty) {
      return 0;
    }

    var points = 0;
    if (value.length >= 8) points += 1;
    if (RegExp(r'[A-Z]').hasMatch(value)) points += 1;
    if (RegExp(r'[a-z]').hasMatch(value)) points += 1;
    if (RegExp(r'[0-9]').hasMatch(value)) points += 1;
    if (RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(value)) points += 1;

    return points / 5;
  }

  Widget _buildIdCardUpload(
    BuildContext context,
    StudentRegistrationState state,
    StudentRegistrationBloc bloc,
  ) {
    final palette = MentorXThemeColorPalette.light;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'National ID Card Photo',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const Gap(8),
        InkWell(
          onTap: () => _pickIdCardPhoto(bloc),
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: palette.backgroundSecondary,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: palette.textTertiary,
                style: BorderStyle.solid,
              ),
            ),
            child: state.idCardPhotoPath == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_a_photo,
                        size: 40,
                        color: palette.textTertiary,
                      ),
                      const Gap(8),
                      Text(
                        'Upload ID Card',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: palette.textSecondary,
                        ),
                      ),
                    ],
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      File(state.idCardPhotoPath!),
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickIdCardPhoto(StudentRegistrationBloc bloc) async {
    final image = await _imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
      maxWidth: 1600,
      maxHeight: 1600,
    );
    if (image == null || !mounted) return;
    bloc.add(StudentRegistrationIdCardPhotoChanged(image.path));
  }
}
