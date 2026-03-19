import 'dart:convert';

/// Comprehensive input validation utilities for security and data integrity
class SecurityValidator {
  // Phone number patterns for supported regions
  static final RegExp _phonePattern = RegExp(r'^\+?[1-9]\d{1,14}$');
  static final RegExp _saudiPhonePattern = RegExp(r'^(\+966|0)?5[0-9]{8}$');

  // OTP validation patterns
  static final RegExp _numericOtpPattern = RegExp(r'^\d+$');
  static final RegExp _alphanumericOtpPattern = RegExp(r'^[A-Za-z0-9]+$');

  // Email validation pattern (RFC 5322 simplified)
  static final RegExp _emailPattern = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
  );

  // SQL injection patterns
  static final List<RegExp> _sqlInjectionPatterns = [
    RegExp(r'(\b(SELECT|INSERT|UPDATE|DELETE|DROP|UNION|ALTER|CREATE)\b)', caseSensitive: false),
    RegExp(r"[;'\x22\\]|--|/\*|\*/", caseSensitive: false),
    RegExp(r'(\bOR\b|\bAND\b).*[=<>]', caseSensitive: false),
  ];

  // XSS patterns
  static final List<RegExp> _xssPatterns = [
    RegExp(r'<script[^>]*>.*?</script>', caseSensitive: false),
    RegExp(r'javascript:', caseSensitive: false),
    RegExp(r'on\w+\s*=', caseSensitive: false),
    RegExp(r'<iframe[^>]*>', caseSensitive: false),
  ];

  /// Validates phone number format and returns sanitized version
  static ValidationResult<String> validatePhoneNumber(String? input) {
    if (input == null || input.isEmpty) {
      return ValidationResult.error('Phone number is required');
    }

    // Remove whitespace and common separators
    final sanitized = input.replaceAll(RegExp(r'[\s\-\(\)]+'), '');

    // Check for malicious patterns
    if (_containsMaliciousContent(sanitized)) {
      return ValidationResult.error('Invalid phone number format');
    }

    // Saudi Arabia specific validation
    if (_saudiPhonePattern.hasMatch(sanitized)) {
      String normalized = sanitized;
      if (normalized.startsWith('0')) {
        normalized = '+966${normalized.substring(1)}';
      } else if (!normalized.startsWith('+966')) {
        normalized = '+966$normalized';
      }
      return ValidationResult.success(normalized);
    }

    // International phone number validation
    if (_phonePattern.hasMatch(sanitized)) {
      final normalized = sanitized.startsWith('+') ? sanitized : '+$sanitized';
      return ValidationResult.success(normalized);
    }

    return ValidationResult.error('Invalid phone number format');
  }

  /// Validates OTP code format and length
  static ValidationResult<String> validateOtpCode(String? input, {
    int? expectedLength,
    bool allowAlphanumeric = false,
  }) {
    if (input == null || input.isEmpty) {
      return ValidationResult.error('OTP code is required');
    }

    final sanitized = input.trim();

    // Check for malicious patterns
    if (_containsMaliciousContent(sanitized)) {
      return ValidationResult.error('Invalid OTP format');
    }

    // Check length constraints
    if (expectedLength != null && sanitized.length != expectedLength) {
      return ValidationResult.error('OTP code must be $expectedLength digits');
    }

    // Validate character pattern
    final pattern = allowAlphanumeric ? _alphanumericOtpPattern : _numericOtpPattern;
    if (!pattern.hasMatch(sanitized)) {
      final expectedFormat = allowAlphanumeric ? 'letters and numbers' : 'numbers';
      return ValidationResult.error('OTP code must contain only $expectedFormat');
    }

    // Security constraints
    if (sanitized.length < 4 || sanitized.length > 8) {
      return ValidationResult.error('OTP code length must be between 4 and 8 characters');
    }

    return ValidationResult.success(sanitized);
  }

  /// Validates email address format
  static ValidationResult<String> validateEmail(String? input) {
    if (input == null || input.isEmpty) {
      return ValidationResult.error('Email address is required');
    }

    final sanitized = input.trim().toLowerCase();

    // Check for malicious patterns
    if (_containsMaliciousContent(sanitized)) {
      return ValidationResult.error('Invalid email format');
    }

    if (!_emailPattern.hasMatch(sanitized)) {
      return ValidationResult.error('Please enter a valid email address');
    }

    // Additional security checks
    if (sanitized.length > 254) {
      return ValidationResult.error('Email address is too long');
    }

    return ValidationResult.success(sanitized);
  }

  /// Validates and sanitizes general text input
  static ValidationResult<String> validateTextInput(String? input, {
    required String fieldName,
    int? minLength,
    int? maxLength,
    bool allowHtml = false,
  }) {
    if (input == null || input.isEmpty) {
      return ValidationResult.error('$fieldName is required');
    }

    String sanitized = input.trim();

    // Check for malicious patterns
    if (!allowHtml && _containsMaliciousContent(sanitized)) {
      return ValidationResult.error('$fieldName contains invalid characters');
    }

    // Length validation
    if (minLength != null && sanitized.length < minLength) {
      return ValidationResult.error('$fieldName must be at least $minLength characters');
    }

    if (maxLength != null && sanitized.length > maxLength) {
      return ValidationResult.error('$fieldName must not exceed $maxLength characters');
    }

    // HTML/XSS sanitization if HTML is not allowed
    if (!allowHtml) {
      sanitized = _sanitizeHtml(sanitized);
    }

    return ValidationResult.success(sanitized);
  }

  /// Validates JSON input for API requests
  static ValidationResult<Map<String, dynamic>> validateJsonInput(String? input) {
    if (input == null || input.isEmpty) {
      return ValidationResult.error('JSON input is required');
    }

    try {
      final decoded = json.decode(input) as Map<String, dynamic>;

      // Check for malicious patterns in JSON values
      if (_hasNestedMaliciousContent(decoded)) {
        return ValidationResult.error('JSON contains invalid content');
      }

      return ValidationResult.success(decoded);
    } catch (e) {
      return ValidationResult.error('Invalid JSON format');
    }
  }

  /// Checks for SQL injection patterns
  static bool containsSqlInjection(String input) {
    return _sqlInjectionPatterns.any((pattern) => pattern.hasMatch(input));
  }

  /// Checks for XSS patterns
  static bool containsXssAttempt(String input) {
    return _xssPatterns.any((pattern) => pattern.hasMatch(input));
  }

  /// Comprehensive malicious content detection
  static bool _containsMaliciousContent(String input) {
    return containsSqlInjection(input) ||
           containsXssAttempt(input) ||
           _containsNullBytes(input) ||
           _containsControlCharacters(input);
  }

  /// Recursively checks for malicious content in nested data structures
  static bool _hasNestedMaliciousContent(dynamic data) {
    if (data is String) {
      return _containsMaliciousContent(data);
    } else if (data is Map) {
      return data.values.any(_hasNestedMaliciousContent) ||
             data.keys.any((key) => _containsMaliciousContent(key.toString()));
    } else if (data is List) {
      return data.any(_hasNestedMaliciousContent);
    }
    return false;
  }

  /// Checks for null bytes that could truncate strings
  static bool _containsNullBytes(String input) {
    return input.contains('\x00');
  }

  /// Checks for control characters that could cause issues
  static bool _containsControlCharacters(String input) {
    return RegExp(r'[\x00-\x08\x0B\x0C\x0E-\x1F\x7F]').hasMatch(input);
  }

  /// Sanitizes HTML content by escaping dangerous characters
  static String _sanitizeHtml(String input) {
    return input
        .replaceAll('&', '&amp;')
        .replaceAll('<', '&lt;')
        .replaceAll('>', '&gt;')
        .replaceAll('"', '&quot;')
        .replaceAll("'", '&#x27;')
        .replaceAll('/', '&#x2F;');
  }

  /// Validates file upload security
  static ValidationResult<String> validateFileUpload(String fileName, List<String> allowedExtensions) {
    if (fileName.isEmpty) {
      return ValidationResult.error('File name is required');
    }

    // Check for path traversal attempts
    if (fileName.contains('..') || fileName.contains('/') || fileName.contains('\\')) {
      return ValidationResult.error('Invalid file name');
    }

    // Check file extension
    final extension = fileName.split('.').last.toLowerCase();
    if (!allowedExtensions.contains(extension)) {
      return ValidationResult.error('File type not allowed. Allowed types: ${allowedExtensions.join(', ')}');
    }

    // Check for double extensions (e.g., file.jpg.exe)
    final parts = fileName.split('.');
    if (parts.length > 2) {
      return ValidationResult.error('Invalid file name format');
    }

    return ValidationResult.success(fileName);
  }
}

/// Result of input validation
class ValidationResult<T> {
  final bool isValid;
  final T? value;
  final String? error;

  const ValidationResult._(this.isValid, this.value, this.error);

  factory ValidationResult.success(T value) {
    return ValidationResult._(true, value, null);
  }

  factory ValidationResult.error(String error) {
    return ValidationResult._(false, null, error);
  }

  /// Gets the validated value or throws if validation failed
  T get valueOrThrow {
    if (!isValid) {
      throw ValidationException(error!);
    }
    return value!;
  }
}

/// Exception thrown when validation fails
class ValidationException implements Exception {
  final String message;

  const ValidationException(this.message);

  @override
  String toString() => 'ValidationException: $message';
}