import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
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
    _confirmPasswordController = TextEditingController(
      text: state.confirmPassword,
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
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
                t['securityTitle'] ?? 'Security & Identity',
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
                t['securitySubtitle'] ?? 'Protect your account with a strong password and verify your identity with your National ID.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: palette.textSecondary,
                  height: 1.5,
                ),
              ),
            ),
            const Gap(32),
            FadeInUp(
              duration: const Duration(milliseconds: 400),
              child: MentorXTextFormField(
                key: const Key('registration_password'),
                label: t['passwordLabel'] ?? 'Password',
                icon: Icons.lock_outline_rounded,
                controller: _passwordController,
                isPassword: true,
                onChanged: (value) =>
                    bloc.add(StudentRegistrationPasswordChanged(value)),
              ),
            ),
            const Gap(12),
            FadeInUp(
              duration: const Duration(milliseconds: 500),
              child: _buildPasswordStrength(context, state.password),
            ),
            const Gap(24),
            FadeInUp(
              duration: const Duration(milliseconds: 600),
              child: MentorXTextFormField(
                key: const Key('registration_confirm_password'),
                label: t['confirmPasswordLabel'] ?? 'Confirm Password',
                icon: Icons.lock_reset_rounded,
                controller: _confirmPasswordController,
                isPassword: true,
                errorText:
                    state.password != state.confirmPassword &&
                        state.confirmPassword.isNotEmpty
                    ? (t['passwordMismatch'] ?? 'Passwords do not match')
                    : null,
                onChanged: (value) =>
                    bloc.add(StudentRegistrationConfirmPasswordChanged(value)),
              ),
            ),
            const Gap(32),
            FadeInUp(
              duration: const Duration(milliseconds: 700),
              child: _buildIdCardUpload(context, state, bloc),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPasswordStrength(BuildContext context, String password) {
    final t = context.t.student;
    final palette = MentorXThemeColorPalette.light;
    final score = _passwordStrengthScore(password);

    final String label;
    final Color color;
    switch (score) {
      case <= 0.25:
        label = t['passwordWeak'] ?? 'Weak';
        color = palette.statusDanger;
      case <= 0.50:
        label = t['passwordFair'] ?? 'Fair';
        color = palette.statusWarning;
      case <= 0.75:
        label = t['passwordGood'] ?? 'Good';
        color = Colors.orangeAccent;
      default:
        label = t['passwordStrong'] ?? 'Strong';
        color = palette.statusSuccess;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: score == 0 ? 0.05 : score,
                  minHeight: 6,
                  color: color,
                  backgroundColor: palette.backgroundSecondary,
                ),
              ),
            ),
            const Gap(12),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ],
    );
  }

  double _passwordStrengthScore(String value) {
    if (value.isEmpty) return 0;
    var points = 0;
    if (value.length >= 8) points += 1;
    if (RegExp(r'[A-Z]').hasMatch(value)) points += 1;
    if (RegExp(r'[0-9]').hasMatch(value)) points += 1;
    if (RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(value)) points += 1;
    return points / 4;
  }

  Widget _buildIdCardUpload(
    BuildContext context,
    StudentRegistrationState state,
    StudentRegistrationBloc bloc,
  ) {
    final t = context.t.student;
    final palette = MentorXThemeColorPalette.light;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t['nationalIdPhotoLabel'] ?? 'National ID Card Photo',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w800,
            color: palette.textPrimary,
          ),
        ),
        const Gap(12),
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _pickIdCardPhoto(bloc),
            borderRadius: BorderRadius.circular(20),
            child: Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                color: palette.backgroundSecondary,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: palette.brandPrimary.withValues(alpha: 0.1),
                  width: 2,
                ),
              ),
              child: state.idCardPhotoPath == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: palette.brandPrimary.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.add_a_photo_rounded,
                            size: 32,
                            color: palette.brandPrimary,
                          ),
                        ),
                        const Gap(16),
                        Text(
                          t['uploadIdFront'] ?? 'Upload Front Side of ID Card',
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: palette.textSecondary,
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                      ],
                    )
                  : Stack(
                      fit: StackFit.expand,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Image.file(
                            File(state.idCardPhotoPath!),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 12,
                          right: 12,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.edit_rounded,
                              size: 16,
                              color: palette.brandPrimary,
                            ),
                          ),
                        ),
                      ],
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
