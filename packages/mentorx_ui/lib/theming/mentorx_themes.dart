part of '../mentorx_ui.dart';

final class MentorXThemes {
  MentorXThemes._();

  static final MixThemeData light = fromColorPalette(
    MentorXThemeColorPalette.light,
  );
  static final MixThemeData dark = fromColorPalette(
    MentorXThemeColorPalette.dark,
  );

  static MixThemeData fromBrightness(Brightness brightness) =>
      brightness == Brightness.light ? light : dark;

  /// You can override the existing tokens by using the override parameters
  /// and they will be merged with the existing ones
  static MixThemeData fromColorPalette(
    MentorXThemeColorPalette palette, {
    Map<ColorToken, Color> colorOverrides = const {},
    Map<RadiusToken, Radius> radiusOverrides = const {},
    Map<TextStyleToken, TextStyle> textStyleOverrides = const {},
  }) {
    final colorTokens = $mentorxToken.color;
    final radiusTokens = $mentorxToken.radius;
    return MixThemeData(
      colors: {
        colorTokens.brandPrimary: palette.brandPrimary,
        colorTokens.brandPressed: palette.brandPressed,
        colorTokens.brandTransparent: palette.brandTransparent,
        colorTokens.brandSecondary: palette.brandSecondary,
        colorTokens.brandTertiary: palette.brandTertiary,
        colorTokens.textPrimary: palette.textPrimary,
        colorTokens.textSecondary: palette.textSecondary,
        colorTokens.textTertiary: palette.textTertiary,
        colorTokens.textForeground: palette.textForeground,
        colorTokens.backgroundPrimary: palette.backgroundPrimary,
        colorTokens.backgroundSecondary: palette.backgroundSecondary,
        colorTokens.backgroundTertiary: palette.backgroundTertiary,
        colorTokens.backgroundPrimaryTransparent:
            palette.backgroundPrimaryTransparent,
        colorTokens.backgroundElevatedSurface:
            palette.backgroundElevatedSurface,
        colorTokens.backgroundElevatedSurfaceShadow:
            palette.backgroundElevatedSurfaceShadow,
        colorTokens.statusDanger: palette.statusDanger,
        colorTokens.statusSuccess: palette.statusSuccess,
        colorTokens.statusWarning: palette.statusWarning,
      }..addAll(colorOverrides),
      textStyles: {
        // styleTokens.titleH1: TextStyle(
        //   height: 1.15,
        //   fontSize: 44,
        //   package: fontPackage,
        //   fontFamily: fontFamily,
        //   fontWeight: FontWeight.w700,
        //   color: palette.textPrimary,
        //   fontFamilyFallback: [fallbackFontFamily],
        // ),
      }..addAll(textStyleOverrides),
      radii: {
        radiusTokens.thin: const Radius.circular(2),
        radiusTokens.extraSmall: const Radius.circular(4),
        radiusTokens.small: const Radius.circular(8),
        radiusTokens.medium: const Radius.circular(16),
        radiusTokens.large: const Radius.circular(32),
      }..addAll(radiusOverrides),
    );
  }

  /// This is used incase we need to use any existing material design components
  /// and this makes sure that the material components colors match our app theme
  static ThemeData materialThemeDataFromTheme(
    MixThemeData theme,
    BuildContext context,
  ) {
    final defaultThemeData = Theme.of(context);
    final backgroundColor = context.backgroundPrimaryColor;
    final primaryColor = context.brandPrimaryColor;
    final surfaceColor = context.backgroundElevatedSurfaceColor;
    final textColor = context.textPrimaryColor;
    final secondaryTextColor = context.textSecondaryColor;
    final errorColor = context.statusDangerColor;
    final focusedBorderSide = BorderSide(color: primaryColor, width: 1);
    final focusedBorder = OutlineInputBorder(
      borderSide: focusedBorderSide,
      borderRadius: BorderRadius.all(context.mediumRadius.topLeft),
    );

    final mainInputDecoration = InputDecorationTheme(
      filled: true,
      fillColor: surfaceColor,
      helperMaxLines: 1,
      iconColor: primaryColor,
      suffixIconColor: primaryColor,
      prefixIconColor: primaryColor,
      hintStyle: TextStyle(color: secondaryTextColor),
      focusedBorder: focusedBorder,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      enabledBorder: focusedBorder.copyWith(
        borderSide: focusedBorderSide.copyWith(
          color: context.backgroundSecondaryColor,
        ),
      ),
      errorBorder: focusedBorder.copyWith(
        borderSide: focusedBorderSide.copyWith(
          color: errorColor,
        ),
      ),
      focusedErrorBorder: focusedBorder.copyWith(
        borderSide: focusedBorderSide.copyWith(
          color: errorColor,
        ),
      ),
      disabledBorder: focusedBorder.copyWith(
        borderSide: focusedBorderSide.copyWith(
          color: context.backgroundSecondaryColor,
        ),
      ),
    );

    final colorScheme = ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Theme.of(context).brightness,
    ).copyWith(
      primary: primaryColor,
      onPrimary: context.textForegroundColor,
      secondary: context.brandSecondaryColor,
      onSecondary: context.textPrimaryColor,
      error: errorColor,
      onError: context.textForegroundColor,
      surface: surfaceColor,
      onSurface: textColor,
    );

    return defaultThemeData.copyWith(
      scaffoldBackgroundColor: backgroundColor,
      canvasColor: backgroundColor,
      primaryColor: primaryColor,
      colorScheme: colorScheme,
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: primaryColor, width: 2),
          borderRadius: BorderRadius.circular(2),
        ),
        fillColor: WidgetStateProperty.fromMap({
          WidgetState.selected: primaryColor,
          WidgetState.any: context.textTertiaryColor,
        }),
        checkColor: WidgetStateProperty.fromMap({
          WidgetState.selected: backgroundColor,
          WidgetState.any: primaryColor,
        }),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: const VisualDensity(
          horizontal: VisualDensity.minimumDensity,
          vertical: VisualDensity.minimumDensity,
        ),
      ),
      inputDecorationTheme: mainInputDecoration,
    );
  }
}
