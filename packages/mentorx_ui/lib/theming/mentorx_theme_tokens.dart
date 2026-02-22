part of '../mentorx_ui.dart';

const $mentorxToken = MentorXToken();

final class MentorXToken {
  const MentorXToken();

  final color = const MentorXColorToken();
  final textStyle = const MentorXTextStyleToken();
  final radius = const MentorXRadiusToken();
}

final class MentorXColorToken {
  const MentorXColorToken();

  ColorToken get brandPrimary => const ColorToken('brandPrimary');
  ColorToken get brandPressed => const ColorToken('brandPressed');
  ColorToken get brandTransparent => const ColorToken('brandTransparent');
  ColorToken get brandSecondary => const ColorToken('brandSecondary');
  ColorToken get brandTertiary => const ColorToken('brandTertiary');

  ColorToken get textPrimary => const ColorToken('textPrimary');
  ColorToken get textSecondary => const ColorToken('textSecondary');
  ColorToken get textTertiary => const ColorToken('textTertiary');
  ColorToken get textForeground => const ColorToken('textForeground');

  ColorToken get backgroundPrimary => const ColorToken('backgroundPrimary');
  ColorToken get backgroundSecondary => const ColorToken('backgroundSecondary');
  ColorToken get backgroundTertiary => const ColorToken('backgroundTertiary');
  ColorToken get backgroundPrimaryTransparent =>
      const ColorToken('backgroundPrimaryTransparent');
  ColorToken get backgroundElevatedSurface =>
      const ColorToken('backgroundElevatedSurface');
  ColorToken get backgroundElevatedSurfaceShadow =>
      const ColorToken('backgroundElevatedSurfaceShadow');

  ColorToken get statusDanger => const ColorToken('statusDanger');
  ColorToken get statusSuccess => const ColorToken('statusSuccess');
  ColorToken get statusWarning => const ColorToken('statusWarning');
}

class MentorXTextStyleToken {
  const MentorXTextStyleToken();
}

class MentorXRadiusToken {
  const MentorXRadiusToken();

  RadiusToken get thin => const RadiusToken('thin');
  RadiusToken get extraSmall => const RadiusToken('extraSmallRadius');
  RadiusToken get small => const RadiusToken('smallRadius');
  RadiusToken get medium => const RadiusToken('mediumRadius');
  RadiusToken get large => const RadiusToken('largeRadius');
}
