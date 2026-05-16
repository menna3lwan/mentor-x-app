import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:mentorx_student/core/core.dart';
import '../bloc/student_registration_bloc.dart';

final class LocationStep extends StatelessWidget {
  const LocationStep({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<StudentRegistrationBloc>();
    return Builder(
      builder: (context) {
        final selectedGovernorate = context.select(
          (StudentRegistrationBloc bloc) => bloc.state.selectedGovernorate,
        );
        final governorates = context.select(
          (StudentRegistrationBloc bloc) => bloc.state.governorates,
        );
        final selectedArea = context.select(
          (StudentRegistrationBloc bloc) => bloc.state.selectedArea,
        );
        final areas = context.select(
          (StudentRegistrationBloc bloc) => bloc.state.areas,
        );

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInDown(
                duration: const Duration(milliseconds: 400),
                child: Text(
                  context.t.auth.locationDetailsTitle,
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
                  context.t.auth.locationDetailsDesc,
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
                      _buildGovernoratePicker(
                        context,
                        selectedGovernorate,
                        governorates,
                        bloc,
                      ),
                      const Gap(32),
                      _buildAreaPicker(context, selectedArea, areas, bloc),
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

  Widget _buildGovernoratePicker(
    BuildContext context,
    GovernorateEntity? selectedGovernorate,
    List<GovernorateEntity> governorates,
    StudentRegistrationBloc bloc,
  ) {
    final t = context.t;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.map_rounded, color: context.brandPrimaryColor, size: 18),
            const Gap(8),
            Text(
              t.auth.governorateLabel,
              style: context.bodySecondaryStyle.copyWith(
                fontWeight: FontWeight.w800,
                color: context.textPrimaryColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const Gap(16),
        DropdownButtonFormField<GovernorateEntity>(
          value: selectedGovernorate,
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
            t.auth.governorateHint,
            style: context.bodySecondaryStyle.copyWith(
              color: context.textTertiaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          items: governorates.map((gov) {
            return DropdownMenuItem(
              value: gov,
              child: Text(
                gov.name,
                style: context.bodyPrimaryStyle.copyWith(
                  color: context.textPrimaryColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            );
          }).toList(),
          onChanged: (value) =>
              bloc.add(StudentRegistrationGovernorateChanged(value)),
        ),
      ],
    );
  }

  Widget _buildAreaPicker(
    BuildContext context,
    String? selectedArea,
    List<AreaEntity> areas,
    StudentRegistrationBloc bloc,
  ) {
    final t = context.t;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.location_on_rounded,
              color: context.brandPrimaryColor,
              size: 18,
            ),
            const Gap(8),
            Text(
              t.auth.regionLabel,
              style: context.bodySecondaryStyle.copyWith(
                fontWeight: FontWeight.w800,
                color: context.textPrimaryColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const Gap(16),
        DropdownButtonFormField<String>(
          value: selectedArea,
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
            t.auth.regionHint,
            style: context.bodySecondaryStyle.copyWith(
              color: context.textTertiaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          items: areas.map((area) {
            return DropdownMenuItem(
              value: area.name,
              child: Text(
                area.name,
                style: context.bodyPrimaryStyle.copyWith(
                  color: context.textPrimaryColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
            );
          }).toList(),
          onChanged: (value) => bloc.add(StudentRegistrationAreaChanged(value)),
        ),
      ],
    );
  }
}
