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
    final styleTokens = $mentorxToken.textStyle;
    final fontFamily = 'HT-Mosafer-Rounded';
    final fontPackage = null;
    final fallbackFontFamily = 'HT-Mosafer-Rounded-English';
    return MixThemeData(
      colors: {

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
    final ThemeData defaultThemeData = Theme.of(context);
    // final backgroundColor = context.backgroundPrimaryColor;
    final backgroundColor = Colors.amber;
    final primaryColor = Colors.amber;
    final focusedBorderSide = BorderSide(color: primaryColor, width: 1);
    final focusedBorder = OutlineInputBorder(
      borderSide: focusedBorderSide,
      borderRadius: BorderRadius.all(context.mediumRadius.topLeft),
    );
    final textStyle = Colors.amber;
    final mainInputDecoration = InputDecorationTheme(
      filled: true,
      helperMaxLines: 1,
      iconColor: primaryColor,
      suffixIconColor: primaryColor,
      prefixIconColor: primaryColor,
      focusedBorder: focusedBorder,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      enabledBorder: focusedBorder.copyWith(
        borderSide: focusedBorderSide.copyWith(
          // color: context.backgroundSecondaryColor,
        ),
      ),
      errorBorder: focusedBorder.copyWith(
        borderSide: focusedBorderSide.copyWith(
          // color: context.backgroundElevatedSurfaceColor,
        ),
      ),
      focusedErrorBorder: focusedBorder.copyWith(
        borderSide: focusedBorderSide.copyWith(
          // color: context.backgroundPrimaryColor,
        ),
      ),
      disabledBorder: focusedBorder.copyWith(
        borderSide: focusedBorderSide.copyWith(
          // color: context.backgroundSecondaryColor,
        ),
      ),
    );
    return defaultThemeData.copyWith(
      // scaffoldBackgroundColor: context.backgroundPrimaryColor,
      // colorScheme: ColorScheme.fromSeed(seedColor: context.brandPrimaryColor),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: primaryColor, width: 2),
          borderRadius: BorderRadius.circular(2),
        ),
        // overlayColor: WidgetStateProperty.all(context.brandPrimaryColor),
        fillColor: const WidgetStateProperty.fromMap({
          // WidgetState.selected: context.brandPrimaryColor,
          // WidgetState.any: context.textTertiaryColor,
        }),
        checkColor: WidgetStateProperty.fromMap({
          WidgetState.selected: backgroundColor,
          // WidgetState.any: context.brandPrimaryColor,
        }),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: const VisualDensity(
          horizontal: VisualDensity.minimumDensity,
          vertical: VisualDensity.minimumDensity,
        ),
      ),
      inputDecorationTheme: mainInputDecoration,
      // canvasColor: context.backgroundPrimaryColor,
      // primaryColor: context.brandPrimaryColor,
    );
  }
}
