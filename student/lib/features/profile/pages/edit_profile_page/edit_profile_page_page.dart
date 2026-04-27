import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import '../../../../core/core.dart';
import 'bloc/edit_profile_page_bloc.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _AddRequest {
  final String field;
  final String value;
  _AddRequest(this.field, this.value);
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _gradeController;
  late TextEditingController _centerController;
  late TextEditingController _schoolController;
  late TextEditingController _reasonController;

  late AppSessionState _initialSession;

  @override
  void initState() {
    super.initState();
    _initialSession = context.read<AppSessionCubit>().state;
    final isAr = context.isArabic;
    
    _nameController = TextEditingController(
      text: isAr ? _initialSession.studentNameAr : _initialSession.studentName,
    );
    _phoneController = TextEditingController(text: _initialSession.phone);
    _gradeController = TextEditingController(
      text: isAr ? _initialSession.gradeAr : _initialSession.grade,
    );
    _centerController = TextEditingController(
      text: isAr ? _initialSession.centerAr : _initialSession.center,
    );
    _schoolController = TextEditingController(
      text: isAr ? _initialSession.schoolAr : _initialSession.school,
    );
    _reasonController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _gradeController.dispose();
    _centerController.dispose();
    _schoolController.dispose();
    _reasonController.dispose();
    super.dispose();
  }

  void _onSubmit() {
    if (!_formKey.currentState!.validate()) return;
    
    final isAr = context.isArabic;
    final requests = <_AddRequest>[];

    // Detect changes
    final currentName = isAr ? _initialSession.studentNameAr : _initialSession.studentName;
    if (_nameController.text != currentName) {
      requests.add(_AddRequest('name', _nameController.text));
    }

    if (_phoneController.text != _initialSession.phone) {
      requests.add(_AddRequest('phone', _phoneController.text));
    }

    final currentGrade = isAr ? _initialSession.gradeAr : _initialSession.grade;
    if (_gradeController.text != currentGrade) {
      requests.add(_AddRequest('grade', _gradeController.text));
    }

    final currentCenter = isAr ? _initialSession.centerAr : _initialSession.center;
    if (_centerController.text != currentCenter) {
      requests.add(_AddRequest('center', _centerController.text));
    }

    final currentSchool = isAr ? _initialSession.schoolAr : _initialSession.school;
    if (_schoolController.text != currentSchool) {
      requests.add(_AddRequest('school', _schoolController.text));
    }

    if (requests.isEmpty) {
      MentorXUI.showToast(message: context.t.student['noChangesDetected'] ?? 'No changes detected');
      return;
    }

    // Submit the first change
    final first = requests.first;
    context.read<EditProfilePageBloc>().add(
      EditProfilePageSubmitRequestEvent(
        fieldName: first.field,
        newValue: first.value,
        reason: _reasonController.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final palette = MentorXThemeColorPalette.light;

    return BlocConsumer<EditProfilePageBloc, EditProfilePageState>(
      listener: (context, state) {
        if (state.errorMessage != null) {
          MentorXUI.showToast(message: state.errorMessage!);
        }
        if (state.loadingState == LoadingState.loaded && Navigator.canPop(context)) {
          MentorXUI.showToast(message: t['requestSentSuccess'] ?? 'Request sent successfully');
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        final isSubmitting = state.loadingState == LoadingState.loading;

        return Scaffold(
          backgroundColor: palette.backgroundSecondary,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(70),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [palette.brandPrimary, palette.brandPrimary.withValues(alpha: 0.8)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
                boxShadow: [
                  BoxShadow(
                    color: palette.brandPrimary.withValues(alpha: 0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                foregroundColor: Colors.white,
                centerTitle: true,
                title: Text(
                  t['editProfile'] ?? 'Edit Profile',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, letterSpacing: -0.5),
                ),
              ),
            ),
          ),
          body: Form(
            key: _formKey,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInDown(
                    duration: const Duration(milliseconds: 500),
                    child: _InfoBanner(
                      text: t['editsNeedApproval'] ?? 'Edits need admin approval and verification',
                      palette: palette,
                    ),
                  ),
                  const Gap(32),

                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    child: _BuildSectionTitle(title: t['personalInfo'] ?? 'Personal Information', palette: palette),
                  ),
                  const Gap(16),
                  
                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 100),
                    child: _PremiumField(
                      label: t['name'] ?? 'Full Name',
                      controller: _nameController,
                      icon: Icons.person_outline_rounded,
                      palette: palette,
                      enabled: !isSubmitting,
                      validator: (v) => v == null || v.isEmpty ? t['requiredField'] : null,
                    ),
                  ),
                  
                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 150),
                    child: _PremiumField(
                      label: t['phone'] ?? 'Phone Number',
                      controller: _phoneController,
                      icon: Icons.phone_android_rounded,
                      palette: palette,
                      enabled: !isSubmitting,
                      keyboardType: TextInputType.phone,
                      validator: (v) => v == null || v.isEmpty ? t['requiredField'] : null,
                    ),
                  ),

                  const Gap(24),
                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 200),
                    child: _BuildSectionTitle(title: t['academicInfo'] ?? 'Academic Details', palette: palette),
                  ),
                  const Gap(16),

                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 250),
                    child: _PremiumField(
                      label: t['grade'] ?? 'Grade',
                      controller: _gradeController,
                      icon: Icons.school_outlined,
                      palette: palette,
                      enabled: !isSubmitting,
                    ),
                  ),
                  
                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 300),
                    child: _PremiumField(
                      label: t['center'] ?? 'Educational Center',
                      controller: _centerController,
                      icon: Icons.business_rounded,
                      palette: palette,
                      enabled: !isSubmitting,
                    ),
                  ),

                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 350),
                    child: _PremiumField(
                      label: t['school'] ?? 'School Name',
                      controller: _schoolController,
                      icon: Icons.account_balance_rounded,
                      palette: palette,
                      enabled: !isSubmitting,
                    ),
                  ),

                  const Gap(32),
                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 400),
                    child: _BuildSectionTitle(title: t['reasonForEdit'] ?? 'Reason for this change', palette: palette),
                  ),
                  const Gap(16),
                  
                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 450),
                    child: TextFormField(
                      controller: _reasonController,
                      maxLines: 4,
                      enabled: !isSubmitting,
                      validator: (v) => v == null || v.trim().isEmpty ? t['provideReason'] : null,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        hintText: t['reasonHint'] ?? 'Briefly explain why you want to update your profile...',
                        hintStyle: TextStyle(fontSize: 14, color: palette.textTertiary, fontWeight: FontWeight.w500),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide(color: palette.brandPrimary, width: 2),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: const BorderSide(color: Colors.red, width: 1.5),
                        ),
                        contentPadding: const EdgeInsets.all(20),
                      ),
                    ),
                  ),
                  const Gap(40),
                  
                  FadeInUp(
                    duration: const Duration(milliseconds: 500),
                    delay: const Duration(milliseconds: 500),
                    child: MentorXButton(
                      onPressed: isSubmitting ? null : _onSubmit,
                      text: t['sendRequest'] ?? 'Submit Changes',
                      loading: isSubmitting,
                    ),
                  ),
                  const Gap(40),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _BuildSectionTitle extends StatelessWidget {
  final String title;
  final MentorXThemeColorPalette palette;
  const _BuildSectionTitle({required this.title, required this.palette});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 20,
          decoration: BoxDecoration(
            color: palette.brandSecondary,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w800,
            color: palette.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _InfoBanner extends StatelessWidget {
  final String text;
  final MentorXThemeColorPalette palette;
  const _InfoBanner({required this.text, required this.palette});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: palette.brandPrimary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: palette.brandPrimary.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Icon(Icons.info_outline_rounded, color: palette.brandPrimary, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: palette.brandPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PremiumField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final IconData icon;
  final MentorXThemeColorPalette palette;
  final bool enabled;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  const _PremiumField({
    required this.label,
    required this.controller,
    required this.icon,
    required this.palette,
    this.enabled = true,
    this.keyboardType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: palette.textSecondary,
              ),
            ),
          ),
          MentorXTextFormField(
            label: label,
            controller: controller,
            icon: icon,
            enabled: enabled,
            keyboardType: keyboardType ?? TextInputType.text,
            validator: validator,
          ),
        ],
      ),
    );
  }
}
