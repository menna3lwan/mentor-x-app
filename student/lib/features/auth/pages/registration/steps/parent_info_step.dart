import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import '../bloc/student_registration_bloc.dart';

class ParentInfoStep extends StatelessWidget {
  const ParentInfoStep({super.key});

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
              'Parent Information',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Gap(8),
            Text(
              'Emergency contact details for your parents.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: palette.textSecondary,
              ),
            ),
            const Gap(24),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Parent's Name",
                hintText: "Enter your parent's full name",
              ),
              onChanged: (value) => bloc.add(StudentRegistrationParentNameChanged(value)),
              initialValue: state.parentName,
            ),
            const Gap(16),
            TextFormField(
              decoration: const InputDecoration(
                labelText: "Parent's Phone Number",
                hintText: '01xxxxxxxxx',
                prefixIcon: Icon(Icons.phone),
              ),
              onChanged: (value) => bloc.add(StudentRegistrationParentPhoneChanged(value)),
              initialValue: state.parentPhone,
              keyboardType: TextInputType.phone,
            ),
          ],
        );
      },
    );
  }
}
