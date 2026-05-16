import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:mentorx_student/core/core.dart';
import '../bloc/student_registration_bloc.dart';

final class SecurityStep extends StatefulWidget {
  const SecurityStep({super.key});

  @override
  State<SecurityStep> createState() => _SecurityStepState();
}

final class _SecurityStepState extends State<SecurityStep> {
  final ImagePicker _imagePicker = ImagePicker();
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  @override
  void initState() {
    super.initState();
    final state = context.read<StudentRegistrationBloc>().state;
    _passwordController = TextEditingController(text: state.password);
    _confirmPasswordController = TextEditingController(
      text: state.confirmPassword,
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<StudentRegistrationBloc>();
    return Builder(
      builder: (context) {
        final password = context.select(
          (StudentRegistrationBloc bloc) => bloc.state.password,
        );
        final confirmPassword = context.select(
          (StudentRegistrationBloc bloc) => bloc.state.confirmPassword,
        );
        final idCardPhotoPath = context.select(
          (StudentRegistrationBloc bloc) => bloc.state.idCardPhotoPath,
        );

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInDown(
                duration: const Duration(milliseconds: 400),
                child: Text(
                  context.t.auth.securityIdentityTitle,
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
                  context.t.auth.securityIdentityDesc,
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
                        key: const Key('registration_password'),
                        label: context.t.auth.login.password,
                        icon: Icons.lock_outline_rounded,
                        controller: _passwordController,
                        isPassword: true,
                        onChanged: (value) =>
                            bloc.add(StudentRegistrationPasswordChanged(value)),
                      ),
                      const Gap(16),
                      _buildPasswordStrength(context, password),
                      const Gap(24),
                      MentorXTextFormField(
                        key: const Key('registration_confirm_password'),
                        label: context.t.auth.confirmPasswordLabel,
                        icon: Icons.lock_reset_rounded,
                        controller: _confirmPasswordController,
                        isPassword: true,
                        errorText:
                            password != confirmPassword && confirmPassword.isNotEmpty
                                ? context.t.auth.passwordMismatch
                                : null,
                        onChanged: (value) =>
                            bloc.add(StudentRegistrationConfirmPasswordChanged(value)),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(32),
              FadeInUp(
                duration: const Duration(milliseconds: 700),
                child: _buildIdCardUpload(context, idCardPhotoPath, bloc),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPasswordStrength(BuildContext context, String password) {
    final score = _passwordStrengthScore(password);

    final String label;
    final Color color;
    switch (score) {
      case <= 0.25:
        label = context.t.auth.passwordWeak;
        color = context.statusDangerColor;
      case <= 0.50:
        label = context.t.auth.passwordFair;
        color = context.statusWarningColor;
      case <= 0.75:
        label = context.t.auth.passwordGood;
        color = Colors.orangeAccent;
      default:
        label = context.t.auth.passwordStrong;
        color = context.statusSuccessColor;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: score == 0 ? 0.05 : score,
                  minHeight: 8,
                  color: color,
                  backgroundColor: context.backgroundSecondaryColor.withValues(alpha: 0.5),
                ),
              ),
            ),
            const Gap(16),
            Text(
              label,
              style: context.bodySecondaryStyle.copyWith(
                color: color,
                fontWeight: FontWeight.w900,
                fontSize: 12,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ],
    );
  }

  double _passwordStrengthScore(String value) {
    if (value.isEmpty) return 0;
    var points = 0;
    if (value.length >= 8) points += 1;
    if (RegExp(r'[A-Z]').hasMatch(value)) points += 1;
    if (RegExp(r'[0-9]').hasMatch(value)) points += 1;
    if (RegExp(r'[!@#\$%^&*(),.?":{}|<>]').hasMatch(value)) points += 1;
    return points / 4;
  }

  Widget _buildIdCardUpload(
    BuildContext context,
    String? idCardPhotoPath,
    StudentRegistrationBloc bloc,
  ) {
    final t = context.t;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.badge_rounded,
              color: context.brandPrimaryColor,
              size: 18,
            ),
            const Gap(8),
            Text(
              t.auth.nationalIdPhotoLabel,
              style: context.bodySecondaryStyle.copyWith(
                fontWeight: FontWeight.w800,
                color: context.textPrimaryColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const Gap(16),
        MentorXGlassCard(
          style: Style(
            $box.borderRadius(32),
            $box.padding.all(0),
            $box.clipBehavior.antiAlias(),
          ),
          child: InkWell(
            onTap: () => _pickIdCardPhoto(bloc),
            child: Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: context.backgroundSecondaryColor.withValues(alpha: 0.5),
              ),
              child: idCardPhotoPath == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: context.brandPrimaryColor.withValues(
                              alpha: 0.1,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.add_a_photo_rounded,
                            size: 36,
                            color: context.brandPrimaryColor,
                          ),
                        ),
                        const Gap(20),
                        Text(
                          t.auth.uploadIdFront,
                          style: context.bodySecondaryStyle.copyWith(
                            color: context.textSecondaryColor,
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    )
                  : Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.file(
                          File(idCardPhotoPath),
                          fit: BoxFit.cover,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.black.withValues(alpha: 0.4),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                        Positioned(
                          top: 16,
                          right: 16,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: context.backgroundPrimaryColor,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.2),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.edit_rounded,
                              size: 18,
                              color: context.brandPrimaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickIdCardPhoto(StudentRegistrationBloc bloc) async {
    final image = await _imagePicker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
      maxWidth: 1600,
      maxHeight: 1600,
    );
    if (image == null || !mounted) return;
    bloc.add(StudentRegistrationIdCardPhotoChanged(image.path));
  }
}
