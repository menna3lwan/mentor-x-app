part of '../mentorx_ui.dart';

extension MentorXThemeExtension on BuildContext {
  MixThemeData get theme => MixTheme.of(this);

  StyledTokens<ColorToken, dynamic> get colors => theme.colors;

  StyledTokens<TextStyleToken, TextStyle> get textStyles => theme.textStyles;

  StyledTokens<RadiusToken, Radius> get radii => theme.radii;

  Color get brandPrimaryColor => colors[$mentorxToken.color.brandPrimary]!;
  Color get brandPressedColor => colors[$mentorxToken.color.brandPressed]!;
  Color get brandTransparentColor =>
      colors[$mentorxToken.color.brandTransparent]!;
  Color get brandSecondaryColor => colors[$mentorxToken.color.brandSecondary]!;
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

  BorderRadius get extraSmallRadius =>
      BorderRadius.circular(radii[$mentorxToken.radius.extraSmall]!.x);
  BorderRadius get smallRadius =>
      BorderRadius.circular(radii[$mentorxToken.radius.small]!.x);
  BorderRadius get mediumRadius =>
      BorderRadius.circular(radii[$mentorxToken.radius.medium]!.x);
  BorderRadius get largeRadius =>
      BorderRadius.circular(radii[$mentorxToken.radius.large]!.x);
}
