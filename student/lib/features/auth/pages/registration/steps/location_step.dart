import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_core/mentorx_core.dart';
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
            Text(
              'Location Details',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const Gap(8),
            Text(
              'Help us know where you are from.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: palette.textSecondary,
              ),
            ),
            const Gap(24),
            _buildGovernoratePicker(context, state, bloc),
            const Gap(16),
            _buildDistrictPicker(context, state, bloc),
          ],
        );
      },
    );
  }

  Widget _buildGovernoratePicker(BuildContext context, StudentRegistrationState state, StudentRegistrationBloc bloc) {
    final palette = MentorXThemeColorPalette.light;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Governorate', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
        const Gap(8),
        DropdownButtonFormField<GovernorateEntity>(
          value: state.selectedGovernorate,
          decoration: InputDecoration(
            filled: true,
            fillColor: palette.backgroundSecondary,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: palette.textTertiary),
            ),
          ),
          hint: const Text('Select Governorate'),
          items: state.governorates.map((gov) {
            return DropdownMenuItem(
              value: gov,
              child: Text(gov.name),
            );
          }).toList(),
          onChanged: (value) => bloc.add(StudentRegistrationGovernorateChanged(value)),
        ),
      ],
    );
  }

  Widget _buildDistrictPicker(BuildContext context, StudentRegistrationState state, StudentRegistrationBloc bloc) {
    final palette = MentorXThemeColorPalette.light;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('District', style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
        const Gap(8),
        DropdownButtonFormField<DistrictEntity>(
          value: state.selectedDistrict,
          decoration: InputDecoration(
            filled: true,
            fillColor: palette.backgroundSecondary,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: palette.textTertiary),
            ),
          ),
          hint: const Text('Select District'),
          items: state.districts.map((district) {
            return DropdownMenuItem(
              value: district,
              child: Text(district.name),
            );
          }).toList(),
          onChanged: (value) => bloc.add(StudentRegistrationDistrictChanged(value)),
        ),
      ],
    );
  }
}
