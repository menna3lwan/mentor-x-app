part of '../mentorx_ui.dart';


extension FormValidationExtensions on String? {
  String? validateField({
    int? minimumLength,
    int? maximumLength,
    bool isDigits = false,
    bool isRequired = true,
    String? customMinLegthError,
    String? customMaxLengthError,
  }) {
    if (isRequired && (this == null || this!.isEmpty)) return t.forms.required;
    if (this!.isNotEmpty &&
        minimumLength != null &&
        !this!.satisfiesMinLength(minimumLength)) {
      return customMinLegthError ??
          (isDigits ? t.forms.minDigitsLength : t.forms.minLength)(
            length: minimumLength,
          );
    }
    if (this!.isNotEmpty &&
        maximumLength != null &&
        !this!.satisfiesMaxLength(maximumLength)) {
      return customMaxLengthError ??
          (isDigits ? t.forms.maxDigitsLength : t.forms.maxLength)(
            length: maximumLength,
          );
    }
    return null;
  }

  String? validateAsEmail({bool isRequired = true}) {
    if (!isRequired && (this == null || this!.isEmpty)) return null;
    final isRequiredResult = validateField(isRequired: true);
    if (isRequiredResult != null) return isRequiredResult;
    if (!this!.isValidEmail) {
      return t.forms.youMustEnterAValidEmail;
    }
    return null;
  }

  String? validateAsPhoneNumber({
    bool isRequired = true,
    int maxLength = 13,
    int minLength = 11,
  }) {
    // final message = t.login.form.youMustEnterAValidPhoneNumber;
    if (isRequired) {
      final isRequiredResult = validateField(
        minimumLength: minLength,
        maximumLength: maxLength,
        isDigits: true,
      );
      if (isRequiredResult != null) return isRequiredResult;
    }
    return null;
  }
}
