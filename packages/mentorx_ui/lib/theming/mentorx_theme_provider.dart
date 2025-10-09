part of '../mentorx_ui.dart';

/// You can provider your own light and dark themes using [MentorXThemeProvider.fromColorPalette]
/// and override whatever tokens you want using the optional named parameters
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
}
