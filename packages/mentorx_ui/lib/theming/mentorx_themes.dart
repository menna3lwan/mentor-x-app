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
        styleTokens.titleH1: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: palette.textPrimary,
        ),
        styleTokens.titleH2: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: palette.textPrimary,
        ),
        styleTokens.sectionTitle: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: palette.textPrimary,
        ),
        styleTokens.bodyPrimary: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: palette.textPrimary,
        ),
        styleTokens.bodySecondary: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: palette.textSecondary,
        ),
        styleTokens.smallText: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: palette.textSecondary,
        ),
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

    // Resolve colors from theme tokens
    final oxfordBlue = theme.colors[$mentorxToken.color.brandPrimary]!;
    final pumpkinOrange = theme.colors[$mentorxToken.color.brandSecondary]!;
    final tealGreen = theme.colors[$mentorxToken.color.statusSuccess]!;
    final ashGrey = theme.colors[$mentorxToken.color.textSecondary]!;
    final lightBeige = theme.colors[$mentorxToken.color.backgroundPrimary]!;
    final white = theme.colors[$mentorxToken.color.backgroundSecondary]!;
    final textPrimary = theme.colors[$mentorxToken.color.textPrimary]!;
    final textForeground = theme.colors[$mentorxToken.color.textForeground]!;
    final statusDanger = theme.colors[$mentorxToken.color.statusDanger]!;

    // Input decoration
    const inputBorderRadius = BorderRadius.all(Radius.circular(12));
    final focusedBorderSide = BorderSide(color: oxfordBlue, width: 1.5);
    final inactiveBorderSide = BorderSide(color: ashGrey, width: 1);
    final errorBorderSide = BorderSide(color: statusDanger, width: 1.5);

    final focusedBorder = OutlineInputBorder(
      borderSide: focusedBorderSide,
      borderRadius: inputBorderRadius,
    );

    final mainInputDecoration = InputDecorationTheme(
      filled: true,
      fillColor: white,
      helperMaxLines: 1,
      iconColor: oxfordBlue,
      suffixIconColor: oxfordBlue,
      prefixIconColor: oxfordBlue,
      labelStyle: GoogleFonts.poppins(color: ashGrey, fontSize: 14),
      hintStyle: GoogleFonts.poppins(color: ashGrey, fontSize: 14),
      floatingLabelStyle: GoogleFonts.poppins(color: oxfordBlue, fontSize: 14),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      focusedBorder: focusedBorder,
      enabledBorder: OutlineInputBorder(
        borderSide: inactiveBorderSide,
        borderRadius: inputBorderRadius,
      ),
      errorBorder: OutlineInputBorder(
        borderSide: errorBorderSide,
        borderRadius: inputBorderRadius,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: errorBorderSide,
        borderRadius: inputBorderRadius,
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: ashGrey.withValues(alpha: 0.3),
          width: 1,
        ),
        borderRadius: inputBorderRadius,
      ),
    );

    return defaultThemeData.copyWith(
      scaffoldBackgroundColor: lightBeige,
      canvasColor: lightBeige,
      primaryColor: oxfordBlue,
      colorScheme: ColorScheme.fromSeed(
        seedColor: oxfordBlue,
        primary: oxfordBlue,
        secondary: pumpkinOrange,
        surface: lightBeige,
        error: statusDanger,
        onPrimary: textForeground,
        onSecondary: textForeground,
        onSurface: textPrimary,
        tertiary: tealGreen,
      ),
      // AppBar: Oxford Blue bg, white title, elevation 0, centered
      appBarTheme: AppBarTheme(
        backgroundColor: oxfordBlue,
        foregroundColor: textForeground,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textForeground,
        ),
        iconTheme: IconThemeData(color: textForeground),
      ),
      // Primary Button: Oxford Blue bg, white text, borderRadius 14, height 50, elevation 2
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: oxfordBlue,
          foregroundColor: textForeground,
          elevation: 2,
          minimumSize: const Size.fromHeight(50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          disabledBackgroundColor: ashGrey.withValues(alpha: 0.3),
          disabledForegroundColor: textForeground.withValues(alpha: 0.5),
        ),
      ),
      // CTA / accent buttons use Pumpkin Orange
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: pumpkinOrange,
          foregroundColor: textForeground,
          minimumSize: const Size.fromHeight(50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          disabledBackgroundColor: ashGrey.withValues(alpha: 0.3),
          disabledForegroundColor: textForeground.withValues(alpha: 0.5),
        ),
      ),
      // Text button with Pumpkin Orange text
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: pumpkinOrange,
          textStyle: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      // Outlined button
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: oxfordBlue,
          minimumSize: const Size.fromHeight(50),
          side: BorderSide(color: oxfordBlue),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      // Card: white bg, borderRadius 16, soft shadow
      cardTheme: CardThemeData(
        color: white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        shadowColor: Colors.black.withValues(alpha: 0.1),
      ),
      // Checkbox
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
        fillColor: WidgetStateProperty.fromMap({
          WidgetState.selected: oxfordBlue,
          WidgetState.any: ashGrey,
        }),
        checkColor: WidgetStateProperty.fromMap({
          WidgetState.selected: textForeground,
          WidgetState.any: textForeground,
        }),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: const VisualDensity(
          horizontal: VisualDensity.minimumDensity,
          vertical: VisualDensity.minimumDensity,
        ),
      ),
      // Text theme using Poppins
      textTheme: GoogleFonts.poppinsTextTheme(defaultThemeData.textTheme)
          .copyWith(
        headlineLarge: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),
        headlineMedium: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        titleLarge: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: textPrimary,
        ),
        bodyLarge: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: textPrimary,
        ),
        bodyMedium: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: ashGrey,
        ),
        bodySmall: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: ashGrey,
        ),
      ),
      inputDecorationTheme: mainInputDecoration,
    );
  }
}
