import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_core/mentorx_core.dart';
import '../bloc/student_registration_bloc.dart';

class AcademicInfoStep extends StatelessWidget {
  const AcademicInfoStep({super.key});

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
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'School Name (Optional)',
                hintText: 'Enter your school name',
              ),
              onChanged: (value) => bloc.add(StudentRegistrationSchoolNameChanged(value)),
              initialValue: state.schoolName,
            ),
            const Gap(16),
            _buildStudyTypePicker(context, state, bloc),
            if (state.studyType != StudyType.online) ...[
              const Gap(16),
              _buildCenterPicker(context, state, bloc),
              const Gap(16),
              _buildSchedulePicker(context, state, bloc),
              const Gap(16),
              _buildGroupPicker(context, state, bloc),
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

  Widget _buildStudyTypePicker(BuildContext context, StudentRegistrationState state, StudentRegistrationBloc bloc) {
    final palette = MentorXThemeColorPalette.light;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Study Type', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
        const Gap(8),
        Row(
          children: StudyType.values.map((type) {
            final isSelected = state.studyType == type;
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: GestureDetector(
                  onTap: () => bloc.add(StudentRegistrationStudyTypeChanged(type)),
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
                        type.name.toUpperCase(),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: isSelected ? palette.textForeground : palette.textPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildCenterPicker(BuildContext context, StudentRegistrationState state, StudentRegistrationBloc bloc) {
    final palette = MentorXThemeColorPalette.light;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Center', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
        const Gap(8),
        DropdownButtonFormField<CenterEntity>(
          value: state.selectedCenter,
          decoration: InputDecoration(
            filled: true,
            fillColor: palette.backgroundSecondary,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: palette.textTertiary),
            ),
          ),
          hint: const Text('Select Center'),
          items: state.centers.map((center) {
            return DropdownMenuItem(
              value: center,
              child: Text(center.name),
            );
          }).toList(),
          onChanged: (value) => bloc.add(StudentRegistrationCenterChanged(value)),
        ),
      ],
    );
  }

  Widget _buildSchedulePicker(BuildContext context, StudentRegistrationState state, StudentRegistrationBloc bloc) {
    final palette = MentorXThemeColorPalette.light;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Schedule', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
        const Gap(8),
        DropdownButtonFormField<ScheduleEntity>(
          value: state.selectedSchedule,
          decoration: InputDecoration(
            filled: true,
            fillColor: palette.backgroundSecondary,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: palette.textTertiary),
            ),
          ),
          hint: const Text('Select Schedule'),
          items: state.schedules.map((schedule) {
            return DropdownMenuItem(
              value: schedule,
              child: Text(schedule.displayName),
            );
          }).toList(),
          onChanged: (value) => bloc.add(StudentRegistrationScheduleChanged(value)),
        ),
      ],
    );
  }

  Widget _buildGroupPicker(BuildContext context, StudentRegistrationState state, StudentRegistrationBloc bloc) {
    final palette = MentorXThemeColorPalette.light;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Group', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
        const Gap(8),
        DropdownButtonFormField<GroupEntity>(
          value: state.selectedGroup,
          decoration: InputDecoration(
            filled: true,
            fillColor: palette.backgroundSecondary,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: palette.textTertiary),
            ),
          ),
          hint: const Text('Select Group'),
          items: state.groups.map((group) {
            return DropdownMenuItem(
              value: group,
              child: Text(group.name),
            );
          }).toList(),
          onChanged: (value) => bloc.add(StudentRegistrationGroupChanged(value)),
        ),
      ],
    );
  }
}
