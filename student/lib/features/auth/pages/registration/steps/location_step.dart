import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:animate_do/animate_do.dart';
import '../bloc/student_registration_bloc.dart';

final class LocationStep extends StatelessWidget {
  const LocationStep({super.key});

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
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

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeInDown(
              duration: const Duration(milliseconds: 400),
              child: Text(
                t['locationLabel'] ?? 'Location Details',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: context.textPrimaryColor,
                  letterSpacing: -1.0,
                ),
              ),
            ),
            const Gap(12),
            FadeInDown(
              duration: const Duration(milliseconds: 500),
              child: Text(
                t['locationSubtitle'] ??
                    'Help us know where you are from to suggest the nearest centers.',
                style: TextStyle(
                  color: context.textSecondaryColor,
                  fontSize: 15,
                  height: 1.6,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Gap(40),
            FadeInUp(
              duration: const Duration(milliseconds: 400),
              child: _buildGovernoratePicker(
                context,
                selectedGovernorate,
                governorates,
                bloc,
              ),
            ),
            const Gap(32),
            FadeInUp(
              duration: const Duration(milliseconds: 500),
              child: _buildAreaPicker(context, selectedArea, areas, bloc),
            ),
          ],
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
    final t = context.t.student;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.map_rounded, color: context.brandPrimaryColor, size: 18),
            const Gap(8),
            Text(
              t['governorateLabel'] ?? 'Governorate',
              style: TextStyle(
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
          style: TextStyle(
            color: context.textPrimaryColor,
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: context.backgroundSecondaryColor,
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
            t['governorateHint'] ?? 'Select Governorate',
            style: TextStyle(
              color: context.textTertiaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          items: governorates.map((gov) {
            return DropdownMenuItem(
              value: gov,
              child: Text(
                gov.name,
                style: TextStyle(
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
    List<String> areas,
    StudentRegistrationBloc bloc,
  ) {
    final t = context.t.student;
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
              t['regionLabel'] ?? 'Area',
              style: TextStyle(
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
          style: TextStyle(
            color: context.textPrimaryColor,
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: context.backgroundSecondaryColor,
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
            t['regionHint'] ?? 'Select Area',
            style: TextStyle(
              color: context.textTertiaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          items: areas.map((area) {
            return DropdownMenuItem(
              value: area,
              child: Text(
                area,
                style: TextStyle(
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
