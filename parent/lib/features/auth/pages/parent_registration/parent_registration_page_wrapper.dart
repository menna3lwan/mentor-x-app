import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:parent/core/core.dart';

import 'bloc/parent_registration_bloc.dart';
import 'parent_registration_page.dart';

final class ParentRegistrationPageWrapper extends StatefulWidget {
  const ParentRegistrationPageWrapper({super.key});

  @override
  State<ParentRegistrationPageWrapper> createState() =>
      _ParentRegistrationPageWrapperState();
}

class _ParentRegistrationPageWrapperState
    extends State<ParentRegistrationPageWrapper> {
  final _lookupController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _lookupController.addListener(() {
      if (!mounted) {
        return;
      }
      context.read<ParentRegistrationBloc>().add(
        ParentRegistrationLookupValueChanged(
          value: _lookupController.text,
        ),
      );
    });
    _firstNameController.addListener(() {
      if (!mounted) {
        return;
      }
      context.read<ParentRegistrationBloc>().add(
        ParentRegistrationFirstNameChanged(
          value: _firstNameController.text,
        ),
      );
    });
    _lastNameController.addListener(() {
      if (!mounted) {
        return;
      }
      context.read<ParentRegistrationBloc>().add(
        ParentRegistrationLastNameChanged(
          value: _lastNameController.text,
        ),
      );
    });
    _phoneController.addListener(() {
      if (!mounted) {
        return;
      }
      context.read<ParentRegistrationBloc>().add(
        ParentRegistrationPhoneChanged(
          value: _phoneController.text,
        ),
      );
    });
    _emailController.addListener(() {
      if (!mounted) {
        return;
      }
      context.read<ParentRegistrationBloc>().add(
        ParentRegistrationEmailChanged(
          value: _emailController.text,
        ),
      );
    });
    _passwordController.addListener(() {
      if (!mounted) {
        return;
      }
      context.read<ParentRegistrationBloc>().add(
        ParentRegistrationPasswordChanged(
          value: _passwordController.text,
        ),
      );
    });
    _confirmPasswordController.addListener(() {
      if (!mounted) {
        return;
      }
      context.read<ParentRegistrationBloc>().add(
        ParentRegistrationConfirmPasswordChanged(
          value: _confirmPasswordController.text,
        ),
      );
    });
  }

  @override
  void dispose() {
    _lookupController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<
      ParentRegistrationBloc,
      ParentRegistrationPresentationEvent
    >(
      listener: (context, event) {
        switch (event) {
          case ParentRegistrationFailurePresentationEvent(:final message):
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
          case ParentRegistrationSuccessPresentationEvent(:final phone):
            OtpPageRoute(phoneNumber: phone).go(context);
        }
      },
      child: Builder(
        builder: (context) {
          final state = context.watch<ParentRegistrationBloc>().state;
          final bloc = context.read<ParentRegistrationBloc>();

          _syncController(_lookupController, state.lookupValue);
          _syncController(_firstNameController, state.firstName);
          _syncController(_lastNameController, state.lastName);
          _syncController(_phoneController, state.phone);
          _syncController(_emailController, state.email);
          _syncController(_passwordController, state.password);
          _syncController(_confirmPasswordController, state.confirmPassword);

          return ParentRegistrationPage(
            appBarLeading: IconButton(
              onPressed: () {
                if (state.currentStep == 0) {
                  const LoginPageRoute().go(context);
                  return;
                }
                bloc.add(const ParentRegistrationBackStepRequested());
              },
              icon: const Icon(Icons.arrow_back, color: Color(0xFF183764)),
            ),
            title: Text(
              _titleForStep(state.currentStep),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF183764),
              ),
            ),
            progressIndicator: _RegistrationProgress(
              currentStep: state.currentStep,
            ),
            body: _StepBody(
              state: state,
              lookupController: _lookupController,
              firstNameController: _firstNameController,
              lastNameController: _lastNameController,
              phoneController: _phoneController,
              emailController: _emailController,
              passwordController: _passwordController,
              confirmPasswordController: _confirmPasswordController,
            ),
            primaryButton: MentorXButton(
              onPressed: state.loadingState.isLoading
                  ? null
                  : () {
                      if (state.currentStep == 0) {
                        if (state.foundStudent == null) {
                          bloc.add(
                            const ParentRegistrationFindStudentSubmitted(),
                          );
                          return;
                        }
                        if (!state.isStudentConfirmed) {
                          bloc.add(const ParentRegistrationStudentConfirmed());
                          return;
                        }
                        bloc.add(const ParentRegistrationNextStepRequested());
                        return;
                      }

                      if (state.currentStep == 1) {
                        bloc.add(const ParentRegistrationNextStepRequested());
                        return;
                      }

                      bloc.add(const ParentRegistrationSubmitted());
                    },
              text: state.loadingState.isLoading
                  ? 'Please wait...'
                  : _primaryButtonLabel(state),
            ),
            secondaryButton: TextButton(
              onPressed: () => const LoginPageRoute().go(context),
              child: const Text('Already have an account? Login'),
            ),
          );
        },
      ),
    );
  }

  void _syncController(TextEditingController controller, String value) {
    if (controller.text == value) {
      return;
    }

    controller.value = controller.value.copyWith(
      text: value,
      selection: TextSelection.collapsed(offset: value.length),
      composing: TextRange.empty,
    );
  }

  String _titleForStep(int step) {
    switch (step) {
      case 0:
        return 'Link To Your Child';
      case 1:
        return 'Parent Information';
      case 2:
        return 'Security';
      default:
        return 'Register';
    }
  }

  String _primaryButtonLabel(ParentRegistrationState state) {
    if (state.currentStep == 0 && state.foundStudent == null) {
      return 'Find Student';
    }
    if (state.currentStep == 0 && !state.isStudentConfirmed) {
      return 'Confirm This Is My Child';
    }
    if (state.currentStep < 2) {
      return 'Next';
    }
    return 'Submit';
  }
}

final class _RegistrationProgress extends StatelessWidget {
  final int currentStep;

  const _RegistrationProgress({required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(3, (index) {
        final isActive = index <= currentStep;
        return Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            height: 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: isActive ? const Color(0xFF183764) : Colors.white,
            ),
          ),
        );
      }),
    );
  }
}

final class _StepBody extends StatelessWidget {
  final ParentRegistrationState state;
  final TextEditingController lookupController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  const _StepBody({
    required this.state,
    required this.lookupController,
    required this.firstNameController,
    required this.lastNameController,
    required this.phoneController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ParentRegistrationBloc>();

    switch (state.currentStep) {
      case 0:
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SegmentedButton<ParentLookupType>(
                segments: const [
                  ButtonSegment(
                    value: ParentLookupType.phone,
                    label: Text('Phone Number'),
                    icon: Icon(Icons.phone_outlined),
                  ),
                  ButtonSegment(
                    value: ParentLookupType.studentCode,
                    label: Text('Student Code'),
                    icon: Icon(Icons.badge_outlined),
                  ),
                ],
                selected: {state.lookupType},
                onSelectionChanged: (selection) {
                  final value = selection.first;
                  bloc.add(
                    ParentRegistrationLookupTypeChanged(lookupType: value),
                  );
                },
              ),
              const SizedBox(height: 16),
              MentorXTextFormField(
                label: state.lookupType == ParentLookupType.phone
                    ? 'Child Phone Number'
                    : 'Student Code',
                icon: state.lookupType == ParentLookupType.phone
                    ? Icons.phone
                    : Icons.perm_identity,
                controller: lookupController,
              ),
              const SizedBox(height: 16),
              if (state.foundStudent != null)
                _StudentPreviewCard(
                  student: state.foundStudent!,
                  isConfirmed: state.isStudentConfirmed,
                ),
            ],
          ),
        );
      case 1:
        return SingleChildScrollView(
          child: Column(
            children: [
              MentorXTextFormField(
                label: 'First Name',
                icon: Icons.person_outline,
                controller: firstNameController,
              ),
              const SizedBox(height: 12),
              MentorXTextFormField(
                label: 'Last Name',
                icon: Icons.person_outline,
                controller: lastNameController,
              ),
              const SizedBox(height: 12),
              MentorXTextFormField(
                label: 'Phone Number',
                icon: Icons.phone_outlined,
                controller: phoneController,
              ),
              const SizedBox(height: 12),
              MentorXTextFormField(
                label: 'Email (Optional)',
                icon: Icons.email_outlined,
                controller: emailController,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: state.relationship.isEmpty ? null : state.relationship,
                decoration: const InputDecoration(
                  labelText: 'Relationship',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'father', child: Text('Father')),
                  DropdownMenuItem(value: 'mother', child: Text('Mother')),
                  DropdownMenuItem(value: 'guardian', child: Text('Guardian')),
                  DropdownMenuItem(value: 'other', child: Text('Other')),
                ],
                onChanged: (value) {
                  if (value == null) {
                    return;
                  }
                  bloc.add(ParentRegistrationRelationshipChanged(value: value));
                },
              ),
            ],
          ),
        );
      case 2:
      default:
        return SingleChildScrollView(
          child: Column(
            children: [
              MentorXTextFormField(
                label: 'Password',
                icon: Icons.lock_outline,
                isPassword: true,
                controller: passwordController,
              ),
              const SizedBox(height: 12),
              MentorXTextFormField(
                label: 'Confirm Password',
                icon: Icons.lock_reset_outlined,
                isPassword: true,
                controller: confirmPasswordController,
              ),
            ],
          ),
        );
    }
  }
}

final class _StudentPreviewCard extends StatelessWidget {
  final ParentStudentLookupEntity student;
  final bool isConfirmed;

  const _StudentPreviewCard({required this.student, required this.isConfirmed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF183764).withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            student.maskedName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Color(0xFF183764),
            ),
          ),
          const SizedBox(height: 4),
          Text('Grade: ${student.gradeName}'),
          Text('Center: ${student.centerName}'),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                isConfirmed ? Icons.verified : Icons.pending,
                color: isConfirmed ? Colors.green : Colors.orange,
              ),
              const SizedBox(width: 8),
              Text(
                isConfirmed ? 'Child confirmed' : 'Please confirm your child',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
