import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:mentorx_student/core/core.dart';
import '../bloc/student_registration_bloc.dart';

final class AcademicInfoStep extends StatefulWidget {
  const AcademicInfoStep({super.key});

  @override
  State<AcademicInfoStep> createState() => _AcademicInfoStepState();
}

final class _AcademicInfoStepState extends State<AcademicInfoStep> {
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
    final bloc = context.read<StudentRegistrationBloc>();
    return Builder(
      builder: (context) {
        final selectedGrade = context.select(
          (StudentRegistrationBloc bloc) => bloc.state.selectedGrade,
        );
        final grades = context.select(
          (StudentRegistrationBloc bloc) => bloc.state.grades,
        );
        final isOnline = context.select(
          (StudentRegistrationBloc bloc) => bloc.state.isOnline,
        );

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInDown(
                duration: const Duration(milliseconds: 400),
                child: Text(
                  context.t.auth.academicInfoTitle,
                  style: context.titleH1Style.copyWith(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1.0,
                  ),
                ),
              ),
              const Gap(12),
              FadeInDown(
                duration: const Duration(milliseconds: 500),
                child: Text(
                  context.t.auth.academicInfoDesc,
                  style: context.bodySecondaryStyle.copyWith(
                    fontSize: 15,
                    height: 1.6,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Gap(40),
              FadeInUp(
                duration: const Duration(milliseconds: 400),
                child: MentorXGlassCard(
                  style: Style(
                    $box.padding.all(24),
                    $box.borderRadius(32),
                  ),
                  child: Column(
                    children: [
                      _buildGradePicker(context, selectedGrade, grades, bloc),
                      const Gap(24),
                      MentorXTextFormField(
                        label: context.t.auth.schoolNameLabel,
                        icon: Icons.school_rounded,
                        controller: _schoolNameController,
                        onChanged: (value) =>
                            bloc.add(StudentRegistrationSchoolNameChanged(value)),
                      ),
                      const Gap(20),
                      MentorXTextFormField(
                        label: context.t.auth.educationAdminLabel,
                        icon: Icons.domain_rounded,
                        controller: _educationDepartmentController,
                        onChanged: (value) => bloc.add(
                          StudentRegistrationEducationDepartmentChanged(value),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(32),
              FadeInUp(
                duration: const Duration(milliseconds: 700),
                child: MentorXGlassCard(
                  style: Style(
                    $box.padding.all(24),
                    $box.borderRadius(32),
                  ),
                  child: Column(
                    children: [
                      _buildStudyTypeToggle(context, isOnline, bloc),
                      if (!isOnline) ...[
                        const Gap(24),
                        FadeInUp(
                          duration: const Duration(milliseconds: 400),
                          child: MentorXTextFormField(
                            label: context.t.auth.centerNameLabel,
                            icon: Icons.location_on_rounded,
                            controller: _centerNameController,
                            onChanged: (value) =>
                                bloc.add(StudentRegistrationCenterNameChanged(value)),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGradePicker(
    BuildContext context,
    GradeEntity? selectedGrade,
    List<GradeEntity> grades,
    StudentRegistrationBloc bloc,
  ) {
    final t = context.t;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.stars_rounded,
              color: context.brandPrimaryColor,
              size: 18,
            ),
            const Gap(8),
            Text(
              t.auth.gradeLabel,
              style: context.bodySecondaryStyle.copyWith(
                fontWeight: FontWeight.w800,
                color: context.textPrimaryColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const Gap(16),
        DropdownButtonFormField<GradeEntity>(
          value: selectedGrade,
          dropdownColor: context.backgroundSecondaryColor,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: context.brandPrimaryColor,
            size: 24,
          ),
          style: context.bodyPrimaryStyle.copyWith(
            color: context.textPrimaryColor,
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: context.backgroundSecondaryColor.withValues(alpha: 0.5),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 18,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: context.borderPrimaryColor.withValues(alpha: 0.1),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: context.brandPrimaryColor,
                width: 2,
              ),
            ),
          ),
          hint: Text(
            t.auth.gradeHint,
            style: context.bodySecondaryStyle.copyWith(
              color: context.textTertiaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          items: grades.map((grade) {
            return DropdownMenuItem(
              value: grade,
              child: Text(
                grade.name,
                style: context.bodyPrimaryStyle.copyWith(
                  color: context.textPrimaryColor,
                  fontWeight: FontWeight.w700,
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
    bool isOnline,
    StudentRegistrationBloc bloc,
  ) {
    final t = context.t;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.auto_awesome_rounded,
              color: context.brandPrimaryColor,
              size: 18,
            ),
            const Gap(8),
            Text(
              t.auth.studyTypeLabel,
              style: context.bodySecondaryStyle.copyWith(
                fontWeight: FontWeight.w800,
                color: context.textPrimaryColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const Gap(16),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: context.backgroundSecondaryColor.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: context.borderPrimaryColor.withValues(alpha: 0.05),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: _buildToggleOption(
                  context,
                  t.auth.studyTypeOnline,
                  Icons.laptop_chromebook_rounded,
                  isOnline,
                  () => bloc.add(
                    const StudentRegistrationOnlineToggleChanged(true),
                  ),
                ),
              ),
              const Gap(8),
              Expanded(
                child: _buildToggleOption(
                  context,
                  t.auth.studyTypeCenter,
                  Icons.location_city_rounded,
                  !isOnline,
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
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        curve: Curves.fastOutSlowIn,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isSelected ? context.brandPrimaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: context.brandPrimaryColor.withValues(alpha: 0.3),
                    blurRadius: 12,
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
              size: 20,
              color: isSelected ? Colors.white : context.textSecondaryColor,
            ),
            const Gap(12),
            Text(
              label,
              style: context.bodySecondaryStyle.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w900,
                letterSpacing: 0.2,
                color: isSelected ? Colors.white : context.textSecondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
