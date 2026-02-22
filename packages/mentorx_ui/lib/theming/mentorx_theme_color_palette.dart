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

  static const light = MentorXThemeColorPalette(
    brandPrimary: Color(0xFF1A3C78),
    brandPressed: Color(0xFF132F5E),
    brandTransparent: Color(0x661A3C78),
    brandSecondary: Color(0xFF49C3AE),
    brandTertiary: Color(0xFFE9F8F4),
    textPrimary: Color(0xFF152744),
    textSecondary: Color(0xFF5C6E89),
    textTertiary: Color(0xFF9EADC1),
    textForeground: Color(0xffFFFFFF),
    backgroundPrimary: Color(0xffFFFFFF),
    backgroundSecondary: Color(0xFFF5F8FC),
    backgroundTertiary: Color(0xFFEAF0F7),
    backgroundPrimaryTransparent: Color(0xCCFFFFFF),
    backgroundElevatedSurface: Color(0xffFFFFFF),
    backgroundElevatedSurfaceShadow: Color(0x1A143154),
    statusDanger: Color(0xFFD84C5A),
    statusSuccess: Color(0xFF2E9B79),
    statusWarning: Color(0xFFF39A3D),
  );

  static const dark = MentorXThemeColorPalette(
    brandPrimary: Color(0xFF3B63A3),
    brandPressed: Color(0xFF2B4A7D),
    brandTransparent: Color(0x663B63A3),
    brandSecondary: Color(0xFF40B7A2),
    brandTertiary: Color(0xFF1E3442),
    textPrimary: Color(0xffFFFFFF),
    textSecondary: Color(0xFFA7B6CA),
    textTertiary: Color(0xFF617086),
    textForeground: Color(0xffFFFFFF),
    backgroundPrimary: Color(0xFF0F1725),
    backgroundSecondary: Color(0xFF121E31),
    backgroundTertiary: Color(0xFF1A2B44),
    backgroundPrimaryTransparent: Color(0xCC0F1725),
    backgroundElevatedSurface: Color(0xFF18263B),
    backgroundElevatedSurfaceShadow: Color(0x66000000),
    statusDanger: Color(0xFFE4727D),
    statusSuccess: Color(0xFF55C39D),
    statusWarning: Color(0xFFFFB562),
  );
}
