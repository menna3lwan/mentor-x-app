part of '../mentorx_ui.dart';

extension MentorXThemeExtension on BuildContext {
  MixThemeData get theme => MixTheme.of(this);

  StyledTokens<ColorToken, dynamic> get colors => theme.colors;

  StyledTokens<TextStyleToken, TextStyle> get textStyles => theme.textStyles;

  StyledTokens<RadiusToken, Radius> get radii => theme.radii;

  // ── Brand Colors ──────────────────────────────────────────────────────

  /// Oxford Blue (#183764) - Primary brand color
  Color get oxfordBlue => colors[$mentorxToken.color.brandPrimary]!;

  /// Pumpkin Orange (#F59239) - Accent / CTA color
  Color get pumpkinOrange => colors[$mentorxToken.color.brandSecondary]!;

  /// Teal Green (#4BBBA0) - Success state color
  Color get tealGreen => colors[$mentorxToken.color.statusSuccess]!;

  /// Ash Grey (#B3B4B5) - Secondary text / borders
  Color get ashGrey => colors[$mentorxToken.color.textSecondary]!;

  /// Light Beige (#FFF2DB) - Background color
  Color get lightBeige => colors[$mentorxToken.color.backgroundPrimary]!;

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

  Color get statusDangerColor => colors[$mentorxToken.color.statusDanger]!;
  Color get statusSuccessColor => colors[$mentorxToken.color.statusSuccess]!;
  Color get statusWarningColor => colors[$mentorxToken.color.statusWarning]!;

  // ── TextStyle Getters ─────────────────────────────────────────────────

  /// H1: 24px, Bold, Oxford Blue
  TextStyle get titleH1Style => textStyles[$mentorxToken.textStyle.titleH1]!;

  /// H2: 20px, SemiBold, Oxford Blue
  TextStyle get titleH2Style => textStyles[$mentorxToken.textStyle.titleH2]!;

  /// Section Title: 18px, Medium, Oxford Blue
  TextStyle get sectionTitleStyle =>
      textStyles[$mentorxToken.textStyle.sectionTitle]!;

  /// Body Primary: 16px, Regular, Oxford Blue
  TextStyle get bodyPrimaryStyle =>
      textStyles[$mentorxToken.textStyle.bodyPrimary]!;

  /// Body Secondary: 14px, Regular, Ash Grey
  TextStyle get bodySecondaryStyle =>
      textStyles[$mentorxToken.textStyle.bodySecondary]!;

  /// Small Text: 12px, Regular, Ash Grey
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
}
