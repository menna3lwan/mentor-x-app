import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

/// A search row (text field + submit button) used to look up a child by
/// admission code or phone number.
class StudentLookupFormWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool isLoading;
  final VoidCallback onSubmit;
  final ValueChanged<String>? onChanged;
  final String label;
  final String hint;

  const StudentLookupFormWidget({
    super.key,
    required this.controller,
    required this.isLoading,
    required this.onSubmit,
    required this.label,
    required this.hint,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: MentorXTextFormField(
            label: label,
            controller: controller,
            hint: hint,
            icon: Icons.search_rounded,
            onChanged: onChanged,
            onFieldSubmitted: (_) => onSubmit(),
          ),
        ),
        const Gap(12),
        _SubmitButton(isLoading: isLoading, onTap: onSubmit),
      ],
    );
  }
}

class _SubmitButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onTap;

  const _SubmitButton({required this.isLoading, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.brandPrimaryColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: context.brandPrimaryColor.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IconButton(
        onPressed: isLoading ? null : onTap,
        icon: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              )
            : const Icon(Icons.arrow_forward_rounded, color: Colors.white),
      ),
    );
  }
}
