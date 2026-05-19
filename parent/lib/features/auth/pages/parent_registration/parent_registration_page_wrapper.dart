import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:device_info_service/device_info_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:parent/core/core.dart';

import 'package:gap/gap.dart';
import 'bloc/parent_registration_bloc.dart';
import 'parent_registration_page.dart';


final class ParentRegistrationPageWrapper extends StatelessWidget {
  const ParentRegistrationPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ParentRegistrationBloc(
        authenticationRepository: context.read<AuthenticationRepository<ParentEntity>>(),
        deviceInfoService: context.read<DeviceInfoService>(),
      ),
      child: const _ParentRegistrationPageContent(),
    );
  }
}

class _ParentRegistrationPageContent extends StatefulWidget {
  const _ParentRegistrationPageContent();

  @override
  State<_ParentRegistrationPageContent> createState() =>
      __ParentRegistrationPageContentState();
}

class __ParentRegistrationPageContentState
    extends State<_ParentRegistrationPageContent> {
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
      if (!mounted) return;
      context.read<ParentRegistrationBloc>().add(
        ParentRegistrationLookupValueChanged(value: _lookupController.text),
      );
    });
    _firstNameController.addListener(() {
      if (!mounted) return;
      context.read<ParentRegistrationBloc>().add(
        ParentRegistrationFirstNameChanged(value: _firstNameController.text),
      );
    });
    _lastNameController.addListener(() {
      if (!mounted) return;
      context.read<ParentRegistrationBloc>().add(
        ParentRegistrationLastNameChanged(value: _lastNameController.text),
      );
    });
    _phoneController.addListener(() {
      if (!mounted) return;
      context.read<ParentRegistrationBloc>().add(
        ParentRegistrationPhoneChanged(value: _phoneController.text),
      );
    });
    _emailController.addListener(() {
      if (!mounted) return;
      context.read<ParentRegistrationBloc>().add(
        ParentRegistrationEmailChanged(value: _emailController.text),
      );
    });
    _passwordController.addListener(() {
      if (!mounted) return;
      context.read<ParentRegistrationBloc>().add(
        ParentRegistrationPasswordChanged(value: _passwordController.text),
      );
    });
    _confirmPasswordController.addListener(() {
      if (!mounted) return;
      context.read<ParentRegistrationBloc>().add(
        ParentRegistrationConfirmPasswordChanged(value: _confirmPasswordController.text),
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
            MentorXUI.showToast(message: message, isError: true);
          case ParentRegistrationSuccessPresentationEvent(:final phone):
            OtpPageRoute(phoneNumber: phone).go(context);
        }
      },
      child: Builder(
        builder: (context) {
          final t = Translations.of(context).parent;
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
              icon: Icon(Icons.arrow_back_ios_new_rounded, color: context.textPrimaryColor, size: 20),
            ),
            title: _titleForStep(state.currentStep, t),
            currentStep: state.currentStep,
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
                          bloc.add(const ParentRegistrationFindStudentSubmitted());
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
              label: state.loadingState.isLoading
                  ? t.auth.regPleaseWait
                  : _primaryButtonLabel(state, t),
            ),
            secondaryButton: TextButton(
              onPressed: () => const LoginPageRoute().go(context),
              child: Text(
                t.auth.regAlreadyHaveAccount,
                style: TextStyle(
                  color: context.brandPrimaryColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _syncController(TextEditingController controller, String value) {
    if (controller.text == value) return;
    controller.value = controller.value.copyWith(
      text: value,
      selection: TextSelection.collapsed(offset: value.length),
      composing: TextRange.empty,
    );
  }

  String _titleForStep(int step, TranslationsParentEn t) {
    switch (step) {
      case 0:
        return t.auth.regStep1Title;
      case 1:
        return t.auth.regStep2Title;
      case 2:
        return t.auth.regStep3Title;
      default:
        return t.auth.regDefaultTitle;
    }
  }

  String _primaryButtonLabel(
    ParentRegistrationState state,
    TranslationsParentEn t,
  ) {
    if (state.currentStep == 0 && state.foundStudent == null) {
      return t.auth.regFindStudent;
    }
    if (state.currentStep == 0 && !state.isStudentConfirmed) {
      return t.auth.regConfirmChild;
    }
    if (state.currentStep < 2) return t.auth.regContinue;
    return t.auth.regCreateAccount;
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
    final t = Translations.of(context).parent;
    final bloc = context.read<ParentRegistrationBloc>();

    switch (state.currentStep) {
      case 0:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: context.backgroundSecondaryColor,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: _TabButton(
                      label: t.auth.regLookupPhoneTab,
                      icon: Icons.phone_rounded,
                      isActive: state.lookupType == ParentLookupType.phone,
                      onTap: () => bloc.add(const ParentRegistrationLookupTypeChanged(lookupType: ParentLookupType.phone)),
                    ),
                  ),
                  Expanded(
                    child: _TabButton(
                      label: t.auth.regLookupCodeTab,
                      icon: Icons.badge_rounded,
                      isActive: state.lookupType == ParentLookupType.studentCode,
                      onTap: () => bloc.add(const ParentRegistrationLookupTypeChanged(lookupType: ParentLookupType.studentCode)),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(32),
            MentorXTextFormField(
              label: state.lookupType == ParentLookupType.phone
                  ? t.auth.regChildPhoneLabel
                  : t.auth.regStudentCodeLabel,
              hintText: state.lookupType == ParentLookupType.phone
                  ? t.auth.regChildPhoneHint
                  : t.auth.regStudentCodeHint,
              icon: state.lookupType == ParentLookupType.phone ? Icons.phone_android_rounded : Icons.numbers_rounded,
              controller: lookupController,
              keyboardType: state.lookupType == ParentLookupType.phone ? TextInputType.phone : TextInputType.text,
            ),
            const Gap(24),
            if (state.foundStudent != null)
              FadeInScale(
                child: _StudentPreviewCard(
                  student: state.foundStudent!,
                  isConfirmed: state.isStudentConfirmed,
                ),
              ),
          ],
        );
      case 1:
        return Column(
          children: [
            MentorXTextFormField(
              label: t.auth.regFirstNameLabel,
              hintText: t.auth.regFirstNameHint,
              icon: Icons.person_rounded,
              controller: firstNameController,
            ),
            const Gap(20),
            MentorXTextFormField(
              label: t.auth.regLastNameLabel,
              hintText: t.auth.regLastNameHint,
              icon: Icons.person_rounded,
              controller: lastNameController,
            ),
            const Gap(20),
            MentorXTextFormField(
              label: t.auth.phoneNumberLabel,
              hintText: t.auth.regYourPhoneHint,
              icon: Icons.phone_android_rounded,
              controller: phoneController,
              keyboardType: TextInputType.phone,
            ),
            const Gap(20),
            MentorXTextFormField(
              label: t.auth.regEmailLabel,
              hintText: t.auth.regEmailHint,
              icon: Icons.email_rounded,
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            const Gap(20),
            _RelationshipDropdown(state: state, bloc: bloc),
          ],
        );
      case 2:
      default:
        return Column(
          children: [
            Text(
              t.auth.regSecurityHint,
              style: TextStyle(
                fontSize: 14,
                color: context.textSecondaryColor,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(32),
            MentorXTextFormField(
              label: t.auth.passwordLabel,
              hintText: t.auth.passwordPlaceholder,
              icon: Icons.lock_rounded,
              isPassword: true,
              controller: passwordController,
            ),
            const Gap(20),
            MentorXTextFormField(
              label: t.auth.confirmPasswordLabel,
              hintText: t.auth.passwordPlaceholder,
              icon: Icons.lock_reset_rounded,
              isPassword: true,
              controller: confirmPasswordController,
            ),
          ],
        );
    }
  }
}

class _RelationshipDropdown extends StatelessWidget {
  const _RelationshipDropdown({
    required this.state,
    required this.bloc,
  });

  final ParentRegistrationState state;
  final ParentRegistrationBloc bloc;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          value: state.relationship.isEmpty ? null : state.relationship,
          style: TextStyle(
            color: context.textPrimaryColor,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
          decoration: InputDecoration(
            labelText: t.auth.regRelationshipLabel,
            labelStyle: TextStyle(
              color: context.textTertiaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            border: InputBorder.none,
            prefixIcon: Icon(
              Icons.people_alt_rounded,
              color: context.brandPrimaryColor,
              size: 20,
            ),
          ),
          items: [
            DropdownMenuItem(
              value: 'father',
              child: Text(t.children.relationship.father),
            ),
            DropdownMenuItem(
              value: 'mother',
              child: Text(t.children.relationship.mother),
            ),
            DropdownMenuItem(
              value: 'guardian',
              child: Text(t.children.relationship.guardian),
            ),
            DropdownMenuItem(
              value: 'other',
              child: Text(t.children.relationship.other),
            ),
          ],
          onChanged: (value) {
            if (value != null) {
              bloc.add(ParentRegistrationRelationshipChanged(value: value));
            }
          },
        ),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  const _TabButton({required this.label, required this.icon, required this.isActive, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isActive ? context.brandPrimaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          boxShadow: isActive ? [
            BoxShadow(
              color: context.brandPrimaryColor.withValues(alpha: 0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ] : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon, 
              color: isActive ? Colors.white : context.textTertiaryColor, 
              size: 18,
            ),
            const Gap(10),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : context.textTertiaryColor,
                fontWeight: FontWeight.w800,
                fontSize: 14,
                letterSpacing: 0.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StudentPreviewCard extends StatelessWidget {
  final ParentStudentLookupEntity student;
  final bool isConfirmed;

  const _StudentPreviewCard({required this.student, required this.isConfirmed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: context.brandPrimaryColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.person_rounded, color: context.brandPrimaryColor, size: 28),
              ),
              const Gap(16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      student.maskedName,
                      style: TextStyle(
                        fontWeight: FontWeight.w900, 
                        fontSize: 18, 
                        color: context.textPrimaryColor,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const Gap(4),
                    Text(
                      '${student.gradeName} • ${student.centerName}',
                      style: TextStyle(
                        fontSize: 13, 
                        color: context.textSecondaryColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Gap(24),
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isConfirmed 
                  ? context.statusSuccessColor.withValues(alpha: 0.1) 
                  : context.statusWarningColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isConfirmed 
                    ? context.statusSuccessColor.withValues(alpha: 0.2) 
                    : context.statusWarningColor.withValues(alpha: 0.2),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  isConfirmed ? Icons.check_circle_rounded : Icons.info_outline_rounded,
                  color: isConfirmed ? context.statusSuccessColor : context.statusWarningColor,
                  size: 20,
                ),
                const Gap(12),
                Expanded(
                  child: Text(
                    isConfirmed
                        ? Translations.of(context).parent.auth.regChildConfirmed
                        : Translations.of(context)
                            .parent
                            .auth
                            .regConfirmIsYourChild,
                    style: TextStyle(
                      color: isConfirmed
                          ? context.statusSuccessColor
                          : context.statusWarningColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FadeInScale extends StatefulWidget {
  final Widget child;
  const FadeInScale({super.key, required this.child});

  @override
  State<FadeInScale> createState() => _FadeInScaleState();
}

class _FadeInScaleState extends State<FadeInScale> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: widget.child,
      ),
    );
  }
}
