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
    brandPrimary: Color(0xff67314F),
    brandPressed: Color(0xff7F315C),
    brandTransparent: Color(0x6667314F),
    brandSecondary: Color(0xffAC654D),
    brandTertiary: Color(0xffF4DBC5),
    textPrimary: Color(0xff181818),
    textSecondary: Color(0xff93989C),
    textTertiary: Color(0xffC5CBD3),
    textForeground: Color(0xffFFFFFF),
    backgroundPrimary: Color(0xffFFFFFF),
    backgroundSecondary: Color(0xffF6F8F8),
    backgroundTertiary: Color(0xffF1F4F4),
    backgroundPrimaryTransparent: Color(0xCCFFFFFF),
    backgroundElevatedSurface: Color(0xffFFFFFF),
    backgroundElevatedSurfaceShadow: Color(0x1A1A6D6D),
    statusDanger: Color(0xff925B64),
    statusSuccess: Color(0xff426A53),
    statusWarning: Color(0xffECBE96),
  );

  static const dark = MentorXThemeColorPalette(
    brandPrimary: Color(0xff67314F),
    brandPressed: Color(0xff7F315C),
    brandTransparent: Color(0x6667314F),
    brandSecondary: Color(0xffAC654D),
    brandTertiary: Color(0xffF4DBC5),
    textPrimary: Color(0xffFFFFFF),
    textSecondary: Color(0xffA1A9B4),
    textTertiary: Color(0xff485056),
    textForeground: Color(0xffFFFFFF),
    backgroundPrimary: Color(0xff222526),
    backgroundSecondary: Color(0xff3A232B),
    backgroundTertiary: Color(0xff2C3535),
    backgroundPrimaryTransparent: Color(0xCCFFFFFF),
    backgroundElevatedSurface: Color(0xff2A3333),
    backgroundElevatedSurfaceShadow: Color(0x4D000000),
    statusDanger: Color(0xffBD8A7B),
    statusSuccess: Color(0xff85A18F),
    statusWarning: Color(0xffF2D3B8),
  );
}
