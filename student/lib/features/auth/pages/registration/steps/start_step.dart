import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import '../bloc/student_registration_bloc.dart';

class StartStep extends StatefulWidget {
  const StartStep({super.key});

  @override
  State<StartStep> createState() => _StartStepState();
}

class _StartStepState extends State<StartStep> {
  late final TextEditingController _firstNameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _parentPhoneController;

  @override
  void initState() {
    super.initState();
    final state = context.read<StudentRegistrationBloc>().state;
    _firstNameController = TextEditingController(text: state.firstName);
    _phoneController = TextEditingController(text: state.phone);
    _parentPhoneController = TextEditingController(text: state.parentPhone);
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _phoneController.dispose();
    _parentPhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final palette = MentorXThemeColorPalette.light;
    final bloc = context.read<StudentRegistrationBloc>();

    return BlocBuilder<StudentRegistrationBloc, StudentRegistrationState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInDown(
              duration: const Duration(milliseconds: 400),
              child: Text(
                t['welcomeTitle'] ?? "Let's get started",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: palette.textPrimary,
                ),
              ),
            ),
            const SizedBox(height: 8),
            FadeInDown(
              duration: const Duration(milliseconds: 500),
              child: Text(
                t['welcomeSubtitle'] ?? 'Enter your basic details to verify your phone number and begin your journey.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: palette.textSecondary,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 32),
            FadeInUp(
              duration: const Duration(milliseconds: 400),
              child: MentorXTextFormField(
                key: const Key('registration_first_name'),
                label: t['firstNameLabel'] ?? 'First Name',
                icon: Icons.person_outline_rounded,
                controller: _firstNameController,
                onChanged: (v) => bloc.add(StudentRegistrationFirstNameChanged(v)),
              ),
            ),
            const SizedBox(height: 16),
            FadeInUp(
              duration: const Duration(milliseconds: 500),
              child: MentorXTextFormField(
                key: const Key('registration_phone'),
                label: t['studentPhoneLabel'] ?? 'Your Phone Number',
                icon: Icons.phone_android_outlined,
                keyboardType: TextInputType.phone,
                errorText: !state.isPhoneUnique
                    ? (t['phoneAlreadyRegistered'] ?? 'This phone number is already registered.')
                    : null,
                controller: _phoneController,
                onChanged: (v) => bloc.add(StudentRegistrationPhoneChanged(v)),
              ),
            ),
            const SizedBox(height: 16),
            FadeInUp(
              duration: const Duration(milliseconds: 600),
              child: MentorXTextFormField(
                key: const Key('registration_parent_phone'),
                label: t['parentPhoneLabel'] ?? 'Parent Phone Number',
                icon: Icons.family_restroom_outlined,
                keyboardType: TextInputType.phone,
                controller: _parentPhoneController,
                onChanged: (v) =>
                    bloc.add(StudentRegistrationParentPhoneChanged(v)),
              ),
            ),
          ],
        );
      },
    );
  }

}
