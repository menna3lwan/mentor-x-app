import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_core/mentorx_core.dart';
import '../bloc/student_registration_bloc.dart';

class AcademicInfoStep extends StatefulWidget {
  const AcademicInfoStep({super.key});

  @override
  State<AcademicInfoStep> createState() => _AcademicInfoStepState();
}

class _AcademicInfoStepState extends State<AcademicInfoStep> {
  late final TextEditingController _schoolNameController;
  late final TextEditingController _educationDepartmentController;
  late final TextEditingController _centerNameController;

  @override
  void initState() {
    super.initState();
    final state = context.read<StudentRegistrationBloc>().state;
    _schoolNameController = TextEditingController(text: state.schoolName);
    _educationDepartmentController = TextEditingController(text: state.educationDepartment);
    _centerNameController = TextEditingController(text: state.centerName ?? '');
  }

  @override
  void dispose() {
    _schoolNameController.dispose();
    _educationDepartmentController.dispose();
    _centerNameController.dispose();
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
              'Academic Information',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Gap(8),
            Text(
              'Tell us about your current grade and study preferences.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: palette.textSecondary,
              ),
            ),
            const Gap(24),
            _buildGradePicker(context, state, bloc),
            const Gap(16),
            MentorXTextFormField(
              label: 'School Name (Optional)',
              icon: Icons.school_outlined,
              controller: _schoolNameController,
              onChanged: (value) => bloc.add(StudentRegistrationSchoolNameChanged(value)),
            ),
            const Gap(16),
            MentorXTextFormField(
              label: 'Education Department (Optional)',
              icon: Icons.domain_outlined,
              controller: _educationDepartmentController,
              onChanged: (value) => bloc.add(StudentRegistrationEducationDepartmentChanged(value)),
            ),
            const Gap(16),
            _buildStudyTypeToggle(context, state, bloc),
            if (!state.isOnline) ...[
              const Gap(16),
              MentorXTextFormField(
                label: 'Center Name',
                icon: Icons.location_on_outlined,
                controller: _centerNameController,
                onChanged: (value) => bloc.add(StudentRegistrationCenterNameChanged(value)),
              ),
            ],
          ],
        );
      },
    );
  }

  Widget _buildGradePicker(BuildContext context, StudentRegistrationState state, StudentRegistrationBloc bloc) {
    final palette = MentorXThemeColorPalette.light;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Grade', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
        const Gap(8),
        DropdownButtonFormField<GradeEntity>(
          value: state.selectedGrade,
          decoration: InputDecoration(
            filled: true,
            fillColor: palette.backgroundSecondary,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: palette.textTertiary),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: palette.textTertiary),
            ),
          ),
          hint: const Text('Select Grade'),
          items: state.grades.map((grade) {
            return DropdownMenuItem(
              value: grade,
              child: Text(grade.name),
            );
          }).toList(),
          onChanged: (value) => bloc.add(StudentRegistrationGradeChanged(value)),
        ),
      ],
    );
  }

  Widget _buildStudyTypeToggle(BuildContext context, StudentRegistrationState state, StudentRegistrationBloc bloc) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Study Preference', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
        const Gap(8),
        Row(
          children: [
            Expanded(
              child: _buildToggleOption(
                context,
                'Online',
                state.isOnline,
                () => bloc.add(const StudentRegistrationOnlineToggleChanged(true)),
              ),
            ),
            const Gap(12),
            Expanded(
              child: _buildToggleOption(
                context,
                'Center',
                !state.isOnline,
                () => bloc.add(const StudentRegistrationOnlineToggleChanged(false)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildToggleOption(BuildContext context, String label, bool isSelected, VoidCallback onTap) {
    final palette = MentorXThemeColorPalette.light;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? palette.brandPrimary : palette.backgroundSecondary,
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
}
