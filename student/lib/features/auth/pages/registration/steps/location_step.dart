import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:animate_do/animate_do.dart';
import '../bloc/student_registration_bloc.dart';

class LocationStep extends StatelessWidget {
  const LocationStep({super.key});

  @override
  Widget build(BuildContext context) {
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
                'Location Details',
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
                'Help us know where you are from to suggest the nearest centers.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: palette.textSecondary,
                  height: 1.5,
                ),
              ),
            ),
            const Gap(32),
            FadeInUp(
              duration: const Duration(milliseconds: 400),
              child: _buildGovernoratePicker(context, state, bloc),
            ),
            const Gap(24),
            FadeInUp(
              duration: const Duration(milliseconds: 500),
              child: _buildAreaPicker(context, state, bloc),
            ),
          ],
        );
      },
    );
  }

  Widget _buildGovernoratePicker(
    BuildContext context,
    StudentRegistrationState state,
    StudentRegistrationBloc bloc,
  ) {
    final palette = MentorXThemeColorPalette.light;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Governorate',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w800,
            color: palette.textPrimary,
          ),
        ),
        const Gap(12),
        DropdownButtonFormField<GovernorateEntity>(
          value: state.selectedGovernorate,
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
            'Select Governorate',
            style: TextStyle(color: palette.textTertiary),
          ),
          items: state.governorates.map((gov) {
            return DropdownMenuItem(
              value: gov,
              child: Text(
                gov.name,
                style: TextStyle(
                  color: palette.textPrimary,
                  fontWeight: FontWeight.w600,
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
    StudentRegistrationState state,
    StudentRegistrationBloc bloc,
  ) {
    final palette = MentorXThemeColorPalette.light;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Area',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w800,
            color: palette.textPrimary,
          ),
        ),
        const Gap(12),
        DropdownButtonFormField<String>(
          value: state.selectedArea,
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
            'Select Area',
            style: TextStyle(color: palette.textTertiary),
          ),
          items: state.areas.map((area) {
            return DropdownMenuItem(
              value: area,
              child: Text(
                area,
                style: TextStyle(
                  color: palette.textPrimary,
                  fontWeight: FontWeight.w600,
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
