import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _gradeController;
  late TextEditingController _centerController;
  late TextEditingController _schoolController;
  late TextEditingController _reasonController;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    final session = context.read<AppSessionCubit>().state;
    final isAr =
        WidgetsBinding.instance.platformDispatcher.locale.languageCode == 'ar';
    _nameController = TextEditingController(
      text: isAr ? session.studentNameAr : session.studentName,
    );
    _phoneController = TextEditingController(text: session.phone);
    _gradeController = TextEditingController(
      text: isAr ? session.gradeAr : session.grade,
    );
    _centerController = TextEditingController(
      text: isAr ? session.centerAr : session.center,
    );
    _schoolController = TextEditingController(
      text: isAr ? session.schoolAr : session.school,
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

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSubmitting = true);

    // Simulate API call
    await Future<void>.delayed(const Duration(seconds: 1));

    if (!mounted) return;
    setState(() => _isSubmitting = false);
    MentorXUI.showToast(message: 'Edit request submitted successfully');
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: _buildAppBar(t),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Info banner
              _InfoBanner(text: t['editsNeedApproval'] ?? 'Edits need admin approval'),
              const SizedBox(height: 24),

              // Form fields
              _PremiumFormField(
                label: t['name'] ?? 'Name',
                controller: _nameController,
                icon: Icons.person_outline_rounded,
                iconColor: AppColors.primary,
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              _PremiumFormField(
                label: t['phone'] ?? 'Phone',
                controller: _phoneController,
                icon: Icons.phone_outlined,
                iconColor: AppColors.teal,
                keyboardType: TextInputType.phone,
                isLtr: true,
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              _PremiumFormField(
                label: t['grade'] ?? 'Grade',
                controller: _gradeController,
                icon: Icons.menu_book_outlined,
                iconColor: AppColors.accent,
              ),
              _PremiumFormField(
                label: t['center'] ?? 'Center',
                controller: _centerController,
                icon: Icons.location_on_outlined,
                iconColor: AppColors.success,
              ),
              _PremiumFormField(
                label: t['school'] ?? 'School',
                controller: _schoolController,
                icon: Icons.account_balance_outlined,
                iconColor: AppColors.purple,
              ),
              const SizedBox(height: 8),

              // Reason field
              Row(
                children: [
                  Container(
                    width: 4,
                    height: 18,
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    t['reasonForEdit'] ?? 'Reason for edit',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _reasonController,
                maxLines: 3,
                validator: (v) =>
                    v == null || v.trim().isEmpty ? 'Please provide a reason' : null,
                decoration: InputDecoration(
                  hintText: t['reasonHint'] ?? 'Explain why you want to edit your profile...',
                  hintStyle: TextStyle(
                    fontSize: 13,
                    color: AppColors.greyDark.withValues(alpha: 0.6),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.all(16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: AppColors.greyLight),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: AppColors.greyLight),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: AppColors.red),
                  ),
                ),
              ),
              const SizedBox(height: 28),

              // Submit button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _isSubmitting ? null : _onSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.5),
                    elevation: 4,
                    shadowColor: AppColors.primary.withValues(alpha: 0.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: _isSubmitting
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.white,
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.send_rounded, size: 18),
                            const SizedBox(width: 8),
                            Text(
                              t['sendRequest'] ?? 'Send Request',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(Map<String, String> t) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: AppColors.primary,
      title: Text(
        t['editProfile'] ?? 'Edit Profile',
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w700,
          color: AppColors.primary,
        ),
      ),
      centerTitle: true,
    );
  }
}

// ── Info Banner ──────────────────────────────────────────────────────────────

class _InfoBanner extends StatelessWidget {
  const _InfoBanner({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.accent.withValues(alpha: 0.08),
            AppColors.accent.withValues(alpha: 0.15),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.accent.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.accent.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.info_outline_rounded, size: 18, color: AppColors.accent),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.accentDark,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Premium Form Field ──────────────────────────────────────────────────────

class _PremiumFormField extends StatelessWidget {
  const _PremiumFormField({
    required this.label,
    required this.controller,
    required this.icon,
    required this.iconColor,
    this.isLtr = false,
    this.keyboardType,
    this.validator,
  });
  final String label;
  final TextEditingController controller;
  final IconData icon;
  final Color iconColor;
  final bool isLtr;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: iconColor),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            textDirection: isLtr ? TextDirection.ltr : null,
            keyboardType: keyboardType,
            validator: validator,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
            ),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: AppColors.greyLight),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: AppColors.greyLight),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: AppColors.red),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
