import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
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
    return BlocBuilder<StudentRegistrationBloc, StudentRegistrationState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Let\'s get started',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Enter your basic details to verify your phone number.',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 32),
            MentorXTextFormField(
              label: 'First Name',
              icon: Icons.person_outline,
              controller: _firstNameController,
              onChanged: (v) => context.read<StudentRegistrationBloc>().add(
                StudentRegistrationFirstNameChanged(v),
              ),
            ),
            const SizedBox(height: 16),
            MentorXTextFormField(
              label: 'Your Phone Number',
              icon: Icons.phone_android_outlined,
              keyboardType: TextInputType.phone,
              errorText: !state.isPhoneUnique
                  ? 'This phone number is already registered.'
                  : null,
              controller: _phoneController,
              onChanged: (v) => context.read<StudentRegistrationBloc>().add(
                StudentRegistrationPhoneChanged(v),
              ),
            ),
            const SizedBox(height: 16),
            MentorXTextFormField(
              label: 'Parent Phone Number',
              icon: Icons.family_restroom_outlined,
              keyboardType: TextInputType.phone,
              controller: _parentPhoneController,
              onChanged: (v) => context.read<StudentRegistrationBloc>().add(
                StudentRegistrationParentPhoneChanged(v),
              ),
            ),
          ],
        );
      },
    );
  }
}
