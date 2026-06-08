part of '../mentorx_ui.dart';

final class MentorXTextFormField extends StatefulWidget {
  final String label;
  final IconData? icon;
  final IconData? prefixIcon;
  final bool isPassword;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final int? maxLength;
  final int? maxLines;
  final String? errorText;
  final String? hint;
  final String? hintText;
  final bool? obscurePassword;
  final VoidCallback? onObscureTextToggled;
  final bool enabled;
  final bool readOnly;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;

  const MentorXTextFormField({
    super.key,
    required this.label,
    this.icon,
    this.prefixIcon,
    required this.controller,
    this.isPassword = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.inputFormatters,
    this.onChanged,
    this.onFieldSubmitted,
    this.maxLength,
    this.maxLines = 1,
    this.errorText,
    this.hint,
    this.hintText,
    this.obscurePassword,
    this.onObscureTextToggled,
    this.enabled = true,
    this.readOnly = false,
    this.textInputAction,
    this.autofillHints,
  });

  @override
  State<MentorXTextFormField> createState() => _MentorXTextFormFieldState();
}

class _MentorXTextFormFieldState extends State<MentorXTextFormField> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    final effectiveObscure = widget.obscurePassword ?? obscure;

    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      inputFormatters: widget.inputFormatters,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      maxLength: widget.maxLength,
      maxLines: widget.maxLines,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      textInputAction: widget.textInputAction,
      autofillHints: widget.autofillHints,
      obscureText: widget.isPassword ? effectiveObscure : false,
      cursorColor: context.brandPrimaryColor,
      style: context.bodyPrimaryStyle.copyWith(
        fontWeight: FontWeight.w700,
      ),
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: context.bodyPrimaryStyle.copyWith(
          color: context.textSecondaryColor,
          fontWeight: FontWeight.w600,
        ),
        hintText: widget.hintText ?? widget.hint,
        errorText: widget.errorText,
        hintStyle: context.bodyPrimaryStyle.copyWith(
          color: context.textTertiaryColor,
          fontWeight: FontWeight.w500,
        ),
        errorStyle: context.smallTextStyle.copyWith(
          color: context.statusDangerColor,
          fontWeight: FontWeight.w700,
        ),
        filled: true,
        fillColor: context.backgroundSecondaryColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 22,
        ),
        prefixIcon: (widget.prefixIcon ?? widget.icon) != null
            ? Icon(
                widget.prefixIcon ?? widget.icon,
                color: context.brandPrimaryColor.withValues(alpha: 0.7),
                size: 22,
              )
            : null,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  effectiveObscure
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded,
                  color: context.textSecondaryColor,
                  size: 22,
                ),
                onPressed: () {
                  if (widget.onObscureTextToggled != null) {
                    widget.onObscureTextToggled!();
                  } else {
                    setState(() => obscure = !obscure);
                  }
                },
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: context.brandPrimaryColor.withValues(alpha: 0.08),
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: context.brandPrimaryColor,
            width: 2.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: context.statusDangerColor.withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: context.statusDangerColor,
            width: 2.0,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: context.borderPrimaryColor.withValues(alpha: 0.05),
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
