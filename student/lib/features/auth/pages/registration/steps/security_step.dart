import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import '../bloc/student_registration_bloc.dart';

class SecurityStep extends StatelessWidget {
  const SecurityStep({super.key});

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
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Gap(8),
            Text(
              'Secure your account and verify your identity.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: palette.textSecondary,
              ),
            ),
            const Gap(24),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Password',
                hintText: 'Create a password',
              ),
              obscureText: true,
              onChanged: (value) => bloc.add(StudentRegistrationPasswordChanged(value)),
              initialValue: state.password,
            ),
            const Gap(16),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                hintText: 'Re-enter your password',
                errorText: state.password != state.confirmPassword && state.confirmPassword.isNotEmpty
                    ? 'Passwords do not match'
                    : null,
              ),
              obscureText: true,
              onChanged: (value) => bloc.add(StudentRegistrationConfirmPasswordChanged(value)),
              initialValue: state.confirmPassword,
            ),
            const Gap(24),
            _buildIdCardUpload(context, state, bloc),
          ],
        );
      },
    );
  }

  Widget _buildIdCardUpload(BuildContext context, StudentRegistrationState state, StudentRegistrationBloc bloc) {
    final palette = MentorXThemeColorPalette.light;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('National ID Card Photo', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
        const Gap(8),
        GestureDetector(
          onTap: () {
            // TODO: Implement image picker
            bloc.add(const StudentRegistrationIdCardPhotoChanged('mock_id_path'));
          },
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
                      Icon(Icons.add_a_photo, size: 40, color: palette.textTertiary),
                      const Gap(8),
                      Text(
                        'Upload ID Card',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: palette.textSecondary,
                        ),
                      ),
                    ],
                  )
                : Image.asset(state.idCardPhotoPath!, fit: BoxFit.cover), // TODO: Use FileImage
          ),
        ),
      ],
    );
  }
}
