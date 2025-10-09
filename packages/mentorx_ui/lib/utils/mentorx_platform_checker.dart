part of '../mentorx_ui.dart';

final class MentorXPlatformChecker {
  MentorXPlatformChecker._();

  static bool get isWeb => kIsWeb;
  static bool get isAndroid =>
      !isWeb && defaultTargetPlatform == TargetPlatform.android;
  static bool get isIOS =>
      !isWeb && defaultTargetPlatform == TargetPlatform.iOS;
  static bool get isMacOS =>
      !isWeb && defaultTargetPlatform == TargetPlatform.macOS;
  static bool get isWindows =>
      !isWeb && defaultTargetPlatform == TargetPlatform.windows;
  static bool get isLinux =>
      !isWeb && defaultTargetPlatform == TargetPlatform.linux;
  static bool get isFuchsia =>
      !isWeb && defaultTargetPlatform == TargetPlatform.fuchsia;

  static bool get isMobile => isAndroid || isIOS;

  static bool get isDesktop => isMacOS || isWindows || isLinux;

  static bool get isDebugMode => kDebugMode;
  static bool get isReleaseMode => kReleaseMode;
}
