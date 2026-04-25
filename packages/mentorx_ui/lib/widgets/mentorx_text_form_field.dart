part of '../mentorx_ui.dart';

final class MentorXTextFormField extends StatefulWidget {
  final String label;
  final IconData icon;
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

  const MentorXTextFormField({
    super.key,
    required this.label,
    required this.icon,
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
  });

  @override
  State<MentorXTextFormField> createState() => _MentorXTextFormFieldState();
}

class _MentorXTextFormFieldState extends State<MentorXTextFormField> {
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    final theme = MentorXThemeProvider.of(context);
    final brandPrimary = theme.colors[$mentorxToken.color.brandPrimary]!;
    final textPrimary = theme.colors[$mentorxToken.color.textPrimary]!;
    final textSecondary = theme.colors[$mentorxToken.color.textSecondary]!;
    final backgroundSecondary = theme.colors[$mentorxToken.color.backgroundSecondary]!;

    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      inputFormatters: widget.inputFormatters,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onFieldSubmitted,
      maxLength: widget.maxLength,
      maxLines: widget.maxLines,
      obscureText: widget.isPassword ? obscure : false,
      cursorColor: brandPrimary,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      decoration: InputDecoration(
        labelText: widget.label,
        errorText: widget.errorText,
        hintStyle: TextStyle(
          color: textSecondary,
          fontWeight: FontWeight.w500,
        ),
        filled: true,
        fillColor: backgroundSecondary,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 18,
        ),
        prefixIcon: Icon(widget.icon, color: textSecondary),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  obscure ? Icons.visibility_off : Icons.visibility,
                  color: textSecondary,
                ),
                onPressed: () => setState(() => obscure = !obscure),
              )
            : null,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: textSecondary.withValues(alpha: 0.3), width: 1.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: brandPrimary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Colors.red, width: 1.2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
      ),
    );
  }
}
