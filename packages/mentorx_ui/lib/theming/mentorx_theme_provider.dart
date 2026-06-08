part of '../mentorx_ui.dart';

/// A widget that provides the MentorX theme data to its descendants.
final class MentorXThemeProvider extends StatelessWidget {
  final Widget child;
  final Brightness brightness;
  final MixThemeData? darkTheme;
  final MixThemeData? lightTheme;
  final List<Type>? defaultOrderOfModifiers;

  const MentorXThemeProvider({
    this.darkTheme,
    this.lightTheme,
    required this.child,
    this.brightness = Brightness.light,
    this.defaultOrderOfModifiers,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final overlayStyle = brightness == Brightness.dark
        ? const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.transparent,
            systemNavigationBarIconBrightness: Brightness.light,
            systemNavigationBarDividerColor: Colors.transparent,
          )
        : const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
            systemNavigationBarColor: Colors.transparent,
            systemNavigationBarIconBrightness: Brightness.dark,
            systemNavigationBarDividerColor: Colors.transparent,
          );

    final baseTheme = brightness == Brightness.light
        ? (lightTheme ?? MentorXThemes.fromBrightness(Brightness.light))
        : (darkTheme ?? MentorXThemes.fromBrightness(Brightness.dark));

    final theme = baseTheme.copyWith(
      defaultOrderOfModifiers: defaultOrderOfModifiers,
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle,
      child: MixTheme(
        data: theme,
        child: child,
      ),
    );
  }

  static MixThemeData of(BuildContext context) {
    return MixTheme.of(context);
  }
}
