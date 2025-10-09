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
