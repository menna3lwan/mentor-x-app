part of '../mentorx_ui.dart';

final class MentorXThemeColorPalette {
  final Color brandPrimary;
  final Color brandPressed;
  final Color brandTransparent;
  final Color brandSecondary;
  final Color brandTertiary;
  final Color textPrimary;
  final Color textSecondary;
  final Color textTertiary;
  final Color textForeground;
  final Color backgroundPrimary;
  final Color backgroundPrimaryTransparent;
  final Color backgroundSecondary;
  final Color backgroundTertiary;
  final Color backgroundElevatedSurface;
  final Color backgroundElevatedSurfaceShadow;
  final Color statusDanger;
  final Color statusSuccess;
  final Color statusWarning;

  const MentorXThemeColorPalette({
    required this.textTertiary,
    required this.textForeground,
    required this.backgroundPrimary,
    required this.backgroundSecondary,
    required this.backgroundTertiary,
    required this.backgroundPrimaryTransparent,
    required this.backgroundElevatedSurface,
    required this.brandPrimary,
    required this.brandPressed,
    required this.textPrimary,
    required this.brandTransparent,
    required this.brandSecondary,
    required this.brandTertiary,
    required this.textSecondary,
    required this.backgroundElevatedSurfaceShadow,
    required this.statusDanger,
    required this.statusSuccess,
    required this.statusWarning,
  });

  /// Light theme using official MentorX brand colors:
  /// - Oxford Blue (#183764): Primary
  /// - Pumpkin Orange (#F59239): Accent / CTA
  /// - Teal Green (#4BBBA0): Success states
  /// - Ash Grey (#B3B4B5): Secondary text / borders
  /// - Light Beige (#FFF2DB): Background
  static const light = MentorXThemeColorPalette(
    // Oxford Blue - Primary brand color
    brandPrimary: Color(0xFF183764),
    // Oxford Blue darker - Pressed state
    brandPressed: Color(0xFF0F2647),
    // Oxford Blue 40% opacity - Transparent variant
    brandTransparent: Color(0x66183764),
    // Pumpkin Orange - Accent / CTA
    brandSecondary: Color(0xFFF59239),
    // Light Beige - Soft accent
    brandTertiary: Color(0xFFFFF2DB),
    // Oxford Blue - Primary text
    textPrimary: Color(0xFF183764),
    // Ash Grey - Secondary text, hints, subtitles
    textSecondary: Color(0xFFB3B4B5),
    // Ash Grey lighter - Disabled text, placeholders
    textTertiary: Color(0xFFD1D2D3),
    // White - Text on dark backgrounds
    textForeground: Color(0xFFFFFFFF),
    // Light Beige - Screen background
    backgroundPrimary: Color(0xFFFFF2DB),
    // White - Card / elevated surface background
    backgroundSecondary: Color(0xFFFFFFFF),
    // Light Beige darker - Soft sections
    backgroundTertiary: Color(0xFFF5E6C8),
    // Light Beige 80% - Transparent background
    backgroundPrimaryTransparent: Color(0xCCFFF2DB),
    // White - Elevated surface
    backgroundElevatedSurface: Color(0xFFFFFFFF),
    // Black 10% - Elevated surface shadow
    backgroundElevatedSurfaceShadow: Color(0x1A000000),
    // Red - Error / danger states
    statusDanger: Color(0xFFD64545),
    // Teal Green - Success states
    statusSuccess: Color(0xFF4BBBA0),
    // Pumpkin Orange - Warning states
    statusWarning: Color(0xFFF59239),
  );

  /// Dark theme adapted from the official MentorX brand colors
  static const dark = MentorXThemeColorPalette(
    // Oxford Blue lighter for dark backgrounds
    brandPrimary: Color(0xFF4A7BBF),
    // Oxford Blue lighter pressed
    brandPressed: Color(0xFF3A6BAF),
    // Oxford Blue lighter 40% opacity
    brandTransparent: Color(0x664A7BBF),
    // Pumpkin Orange - Accent / CTA (same in dark)
    brandSecondary: Color(0xFFF59239),
    // Light Beige muted for dark theme
    brandTertiary: Color(0xFF3D3426),
    // White - Primary text on dark
    textPrimary: Color(0xFFFFFFFF),
    // Ash Grey lighter for dark - Secondary text
    textSecondary: Color(0xFFA1A9B4),
    // Ash Grey darker for dark - Disabled text
    textTertiary: Color(0xFF485056),
    // White - Text on dark backgrounds
    textForeground: Color(0xFFFFFFFF),
    // Dark background
    backgroundPrimary: Color(0xFF1A1D21),
    // Slightly lighter dark background
    backgroundSecondary: Color(0xFF242830),
    // Dark tertiary background
    backgroundTertiary: Color(0xFF2C3038),
    // Dark transparent
    backgroundPrimaryTransparent: Color(0xCC1A1D21),
    // Dark elevated surface
    backgroundElevatedSurface: Color(0xFF2A2E36),
    // Black 30% for dark shadows
    backgroundElevatedSurfaceShadow: Color(0x4D000000),
    // Red lighter for dark
    statusDanger: Color(0xFFE06B6B),
    // Teal Green lighter for dark
    statusSuccess: Color(0xFF6DD4BE),
    // Pumpkin Orange lighter for dark
    statusWarning: Color(0xFFF7A85C),
  );
}
