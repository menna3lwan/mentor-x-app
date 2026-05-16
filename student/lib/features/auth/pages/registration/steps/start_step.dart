import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:mentorx_student/core/core.dart';
import '../bloc/student_registration_bloc.dart';

final class StartStep extends StatefulWidget {
  const StartStep({super.key});

  @override
  State<StartStep> createState() => _StartStepState();
}

final class _StartStepState extends State<StartStep> {
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
    final bloc = context.read<StudentRegistrationBloc>();

    return Builder(
      builder: (context) {
        final isPhoneUnique = context.select(
          (StudentRegistrationBloc bloc) => bloc.state.isPhoneUnique,
        );

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInDown(
                duration: const Duration(milliseconds: 400),
                child: Text(
                  context.t.auth.letsGetStarted,
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
                  context.t.auth.basicDetailsDesc,
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
                      MentorXTextFormField(
                        key: const Key('registration_first_name'),
                        label: context.t.auth.firstNameLabel,
                        icon: Icons.person_outline_rounded,
                        controller: _firstNameController,
                        onChanged: (v) =>
                            bloc.add(StudentRegistrationFirstNameChanged(v)),
                      ),
                      const Gap(20),
                      MentorXTextFormField(
                        key: const Key('registration_phone'),
                        label: context.t.auth.phoneLabel,
                        icon: Icons.phone_android_outlined,
                        keyboardType: TextInputType.phone,
                        errorText: !isPhoneUnique
                            ? context.t.auth.phoneAlreadyRegistered
                            : null,
                        controller: _phoneController,
                        onChanged: (v) =>
                            bloc.add(StudentRegistrationPhoneChanged(v)),
                      ),
                      const Gap(20),
                      MentorXTextFormField(
                        key: const Key('registration_parent_phone'),
                        label: context.t.auth.parentPhoneLabel,
                        icon: Icons.family_restroom_outlined,
                        keyboardType: TextInputType.phone,
                        controller: _parentPhoneController,
                        onChanged: (v) =>
                            bloc.add(StudentRegistrationParentPhoneChanged(v)),
                      ),
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
}
