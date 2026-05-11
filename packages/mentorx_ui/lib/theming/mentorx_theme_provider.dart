part of '../mentorx_ui.dart';

/// A widget that provides the MentorX theme data to its descendants.
final class MentorXThemeProvider extends StatelessWidget {
  final Widget child;
  final Brightness brightness;
  final MixThemeData? darkTheme;
  final MixThemeData? lightTheme;

  const MentorXThemeProvider({
    this.darkTheme,
    this.lightTheme,
    required this.child,
    this.brightness = Brightness.light,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final appLighTheme =
        lightTheme ?? MentorXThemes.fromBrightness(Brightness.light);
    final appDarkTheme =
        darkTheme ?? MentorXThemes.fromBrightness(Brightness.dark);
    return MixTheme(
      data: brightness == Brightness.light ? appLighTheme : appDarkTheme,
      child: child,
    );
  }

  static MixThemeData of(BuildContext context) {
    return MixTheme.of(context);
  }
}
