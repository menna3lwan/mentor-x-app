import 'package:flutter/material.dart';

/// Parent-app-specific accent colors used for onboarding slides and
/// other feature-specific visual identity. These complement the shared
/// [AppColors] from mentorx_ui.
final class ParentColors {
  ParentColors._();

  /// Indigo used for the "Monitor Progress" onboarding slide.
  static const Color slideIndigo = Color(0xFF6366F1);

  /// Green used for the "Stay Connected" onboarding slide.
  static const Color slideGreen = Color(0xFF10B981);

  /// Amber used for the "Secure Payments" onboarding slide.
  static const Color slideAmber = Color(0xFFF59E0B);
}
