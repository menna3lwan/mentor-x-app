import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:animate_do/animate_do.dart';
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
    _educationDepartmentController = TextEditingController(
      text: state.educationDepartment,
    );
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
                t['academicInfoTitle'] ?? 'Academic Information',
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
                t['academicInfoSubtitle'] ?? 'Tell us about your current grade and study preferences to personalize your experience.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: palette.textSecondary,
                  height: 1.5,
                ),
              ),
            ),
            const Gap(32),
            FadeInUp(
              duration: const Duration(milliseconds: 400),
              child: _buildGradePicker(context, state, bloc),
            ),
            const Gap(24),
            FadeInUp(
              duration: const Duration(milliseconds: 500),
              child: MentorXTextFormField(
                label: t['schoolNameLabel'] ?? 'School Name',
                icon: Icons.school_rounded,
                controller: _schoolNameController,
                onChanged: (value) =>
                    bloc.add(StudentRegistrationSchoolNameChanged(value)),
              ),
            ),
            const Gap(16),
            FadeInUp(
              duration: const Duration(milliseconds: 600),
              child: MentorXTextFormField(
                label: t['educationAdminLabel'] ?? 'Education Department',
                icon: Icons.domain_rounded,
                controller: _educationDepartmentController,
                onChanged: (value) => bloc.add(
                  StudentRegistrationEducationDepartmentChanged(value),
                ),
              ),
            ),
            const Gap(24),
            FadeInUp(
              duration: const Duration(milliseconds: 700),
              child: _buildStudyTypeToggle(context, state, bloc),
            ),
            if (!state.isOnline) ...[
              const Gap(16),
              FadeInUp(
                duration: const Duration(milliseconds: 400),
                child: MentorXTextFormField(
                  label: t['centerLabel'] ?? 'Center Name',
                  icon: Icons.location_on_rounded,
                  controller: _centerNameController,
                  onChanged: (value) =>
                      bloc.add(StudentRegistrationCenterNameChanged(value)),
                ),
              ),
            ],
          ],
        );
      },
    );
  }


  Widget _buildGradePicker(
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
          t['gradeLabel'] ?? 'Current Grade',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w800,
            color: palette.textPrimary,
          ),
        ),
        const Gap(12),
        DropdownButtonFormField<GradeEntity>(
          value: state.selectedGrade,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: palette.brandPrimary,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: palette.backgroundSecondary,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: palette.textTertiary.withValues(alpha: 0.1),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: palette.brandPrimary, width: 2),
            ),
          ),
          hint: Text(
            t['gradeHint'] ?? 'Select your grade',
            style: TextStyle(color: palette.textTertiary),
          ),
          items: state.grades.map((grade) {
            return DropdownMenuItem(
              value: grade,
              child: Text(
                grade.name,
                style: TextStyle(
                  color: palette.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }).toList(),
          onChanged: (value) =>
              bloc.add(StudentRegistrationGradeChanged(value)),
        ),
      ],
    );
  }

  Widget _buildStudyTypeToggle(
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
          t['studyTypeLabel'] ?? 'Study Preference',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w800,
            color: palette.textPrimary,
          ),
        ),
        const Gap(12),
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: palette.backgroundSecondary,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Expanded(
                child: _buildToggleOption(
                  context,
                  t['studyTypeOnline'] ?? 'Online Study',
                  Icons.laptop_chromebook_rounded,
                  state.isOnline,
                  () => bloc.add(
                    const StudentRegistrationOnlineToggleChanged(true),
                  ),
                ),
              ),
              const Gap(8),
              Expanded(
                child: _buildToggleOption(
                  context,
                  t['studyTypeCenter'] ?? 'Center Study',
                  Icons.location_city_rounded,
                  !state.isOnline,
                  () => bloc.add(
                    const StudentRegistrationOnlineToggleChanged(false),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildToggleOption(
    BuildContext context,
    String label,
    IconData icon,
    bool isSelected,
    VoidCallback onTap,
  ) {
    final palette = MentorXThemeColorPalette.light;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? palette.brandPrimary : palette.textSecondary,
            ),
            const Gap(8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w800,
                color: isSelected
                    ? palette.brandPrimary
                    : palette.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
