part of '../mentorx_ui.dart';

extension MentorXThemeExtension on BuildContext {
  MixThemeData get theme => MixTheme.of(this);

  StyledTokens<ColorToken, dynamic> get colors => theme.colors;
  StyledTokens<TextStyleToken, TextStyle> get textStyles => theme.textStyles;
  StyledTokens<RadiusToken, Radius> get radii => theme.radii;

  // ── Brand Colors ──────────────────────────────────────────────────────

  /// Primary Blue (#1E3ABA) - Primary brand color
  Color get primaryBlue => colors[$mentorxToken.color.brandPrimary]!;

  /// Accent Warm (#FF9F1C) - Accent / CTA color
  Color get accentWarm => colors[$mentorxToken.color.brandSecondary]!;

  /// Secondary Green (#2EC4B6) - Success state color
  Color get secondaryGreen => colors[$mentorxToken.color.statusSuccess]!;

  /// Neutral Grey (#B3B4B5) - Secondary text / borders
  Color get neutralGrey => colors[$mentorxToken.color.textSecondary]!;

  /// Neutral Light (#F2E1DB) - Background color
  Color get neutralLight => colors[$mentorxToken.color.backgroundPrimary]!;

  // ── Semantic Color Getters ────────────────────────────────────────────

  Color get brandPrimaryColor => colors[$mentorxToken.color.brandPrimary]!;
  Color get brandPressedColor => colors[$mentorxToken.color.brandPressed]!;
  Color get brandTransparentColor =>
      colors[$mentorxToken.color.brandTransparent]!;
  Color get brandSecondaryColor =>
      colors[$mentorxToken.color.brandSecondary]!;
  Color get brandTertiaryColor => colors[$mentorxToken.color.brandTertiary]!;

  Color get textPrimaryColor => colors[$mentorxToken.color.textPrimary]!;
  Color get textSecondaryColor => colors[$mentorxToken.color.textSecondary]!;
  Color get textTertiaryColor => colors[$mentorxToken.color.textTertiary]!;
  Color get textForegroundColor => colors[$mentorxToken.color.textForeground]!;

  Color get backgroundPrimaryColor =>
      colors[$mentorxToken.color.backgroundPrimary]!;
  Color get backgroundSecondaryColor =>
      colors[$mentorxToken.color.backgroundSecondary]!;
  Color get backgroundTertiaryColor =>
      colors[$mentorxToken.color.backgroundTertiary]!;
  Color get backgroundPrimaryTransparentColor =>
      colors[$mentorxToken.color.backgroundPrimaryTransparent]!;
  Color get backgroundElevatedSurfaceColor =>
      colors[$mentorxToken.color.backgroundElevatedSurface]!;
  Color get backgroundElevatedSurfaceShadowColor =>
      colors[$mentorxToken.color.backgroundElevatedSurfaceShadow]!;

  Color get statusDangerColor => colors[$mentorxToken.color.statusDanger]!;
  Color get statusSuccessColor => colors[$mentorxToken.color.statusSuccess]!;
  Color get statusWarningColor => colors[$mentorxToken.color.statusWarning]!;

  Color get borderPrimaryColor => colors[$mentorxToken.color.borderPrimary]!;
  Color get borderSecondaryColor => colors[$mentorxToken.color.borderSecondary]!;

  // ── TextStyle Getters ─────────────────────────────────────────────────

  /// H1: 24px, Bold, Primary Blue
  TextStyle get titleH1Style => textStyles[$mentorxToken.textStyle.titleH1]!;

  /// H2: 20px, SemiBold, Primary Blue
  TextStyle get titleH2Style => textStyles[$mentorxToken.textStyle.titleH2]!;

  /// Section Title: 18px, Medium, Primary Blue
  TextStyle get sectionTitleStyle =>
      textStyles[$mentorxToken.textStyle.sectionTitle]!;

  /// H3: 18px, Medium, Primary Blue (Alias for sectionTitleStyle)
  TextStyle get titleH3Style => sectionTitleStyle;

  /// Body Primary: 16px, Regular, Primary Blue
  TextStyle get bodyPrimaryStyle =>
      textStyles[$mentorxToken.textStyle.bodyPrimary]!;

  /// Body Secondary: 14px, Regular, Neutral Grey
  TextStyle get bodySecondaryStyle =>
      textStyles[$mentorxToken.textStyle.bodySecondary]!;

  /// Small Text: 12px, Regular, Neutral Grey
  TextStyle get smallTextStyle =>
      textStyles[$mentorxToken.textStyle.smallText]!;

  // ── Border Radius Getters ─────────────────────────────────────────────

  BorderRadius get extraSmallRadius =>
      BorderRadius.circular(radii[$mentorxToken.radius.extraSmall]!.x);
  BorderRadius get smallRadius =>
      BorderRadius.circular(radii[$mentorxToken.radius.small]!.x);
  BorderRadius get mediumRadius =>
      BorderRadius.circular(radii[$mentorxToken.radius.medium]!.x);
  BorderRadius get largeRadius =>
      BorderRadius.circular(radii[$mentorxToken.radius.large]!.x);

  // ── Shadow Getters ───────────────────────────────────────────────────

  List<BoxShadow> get softShadow =>
      MentorXThemes.softShadow(backgroundElevatedSurfaceShadowColor);
  List<BoxShadow> get mediumShadow =>
      MentorXThemes.mediumShadow(backgroundElevatedSurfaceShadowColor);
  List<BoxShadow> get hardShadow =>
      MentorXThemes.hardShadow(backgroundElevatedSurfaceShadowColor);
}

