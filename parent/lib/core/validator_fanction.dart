class AppValues {
  // Email
  static const String emailRegex =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

  // Password
  static const String passwordRegex =
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&]).{8,}$';

  // Username
  static const String usernameRegex =
      r'^(?![._-])[a-zA-Z0-9._-]{3,20}(?<![._-])$';

  // Phone
  static const String phoneRegex = r'^\+?[1-9]\d{7,14}$';

  // OTP Code
  static const String otpRegex = r'^\d{6}$';
}

abstract class Validator {
  static String? validateEmail(String? val) {
    if (val == null || val.trim().isEmpty) {
      return 'Email cannot be empty';
    }

    final email = val.trim();
    if (!RegExp(AppValues.emailRegex).hasMatch(email)) {
      return 'Enter a valid email address';
    }

    return null;
  }

  static String? validatePassword(String? val) {
    if (val == null || val.isEmpty) {
      return 'Password cannot be empty';
    }

    if (!RegExp(AppValues.passwordRegex).hasMatch(val)) {
      return 'Password must be at least 8 characters and include uppercase, lowercase, number and special character';
    }

    return null;
  }

  static String? validateConfirmPassword(String? val, String? password) {
    if (val == null || val.isEmpty) {
      return 'Confirm password cannot be empty';
    }

    if (val != password) {
      return 'Passwords do not match';
    }

    return null;
  }

  static String? validateUsername(String? val) {
    if (val == null || val.trim().isEmpty) {
      return 'Username cannot be empty';
    }

    final username = val.trim();

    if (!RegExp(AppValues.usernameRegex).hasMatch(username)) {
      return 'Username must be 3–20 characters and not start or end with special characters';
    }

    return null;
  }

  static String? validatePhoneNumber(String? val) {
    if (val == null || val.trim().isEmpty) {
      return 'Phone number cannot be empty';
    }

    final phone = val.trim();

    if (!RegExp(AppValues.phoneRegex).hasMatch(phone)) {
      return 'Enter a valid international phone number';
    }

    return null;
  }

  static String? validateCode(String? val) {
    if (val == null || val.isEmpty) {
      return 'Code cannot be empty';
    }

    if (!RegExp(AppValues.otpRegex).hasMatch(val)) {
      return 'Code must be exactly 6 digits';
    }

    return null;
  }

  static String? validateName(String? val) {
    if (val == null || val.trim().isEmpty) {
      return 'Name cannot be empty';
    }

    if (val.trim().length < 2) {
      return 'Name is too short';
    }

    return null;
  }
}
