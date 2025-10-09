part of '../mentorx_ui.dart';

extension MentorXThemeExtension on BuildContext {
  MixThemeData get theme => MixTheme.of(this);

  StyledTokens<ColorToken, dynamic> get colors => theme.colors;

  StyledTokens<TextStyleToken, TextStyle> get textStyles => theme.textStyles;

  StyledTokens<RadiusToken, Radius> get radii => theme.radii;

  // Color get brandPrimaryColor => colors[$mentorxToken.color.brandPrimary]!;


  BorderRadius get extraSmallRadius =>
      BorderRadius.circular(radii[$mentorxToken.radius.extraSmall]!.x);
  BorderRadius get smallRadius =>
      BorderRadius.circular(radii[$mentorxToken.radius.small]!.x);
  BorderRadius get mediumRadius =>
      BorderRadius.circular(radii[$mentorxToken.radius.medium]!.x);
  BorderRadius get largeRadius =>
      BorderRadius.circular(radii[$mentorxToken.radius.large]!.x);
}
