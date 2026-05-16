part of '../mentorx_ui.dart';

final class MentorXThemes {
  MentorXThemes._();

  static final MixThemeData light = _createTheme(
    brandPrimary: const Color(0xFF1E3ABA),
    brandPressed: const Color(0xFF182E95),
    brandTransparent: const Color(0x661E3ABA),
    brandSecondary: const Color(0xFFFF9F1C),
    brandTertiary: const Color(0xFFF2E1DB),
    textPrimary: const Color(0xFF1E3ABA),
    textSecondary: const Color(0xFF8F9091),
    textTertiary: const Color(0xFFB3B4B5),
    textForeground: const Color(0xFFFFFFFF),
    backgroundPrimary: const Color(0xFFF2E1DB),
    backgroundSecondary: const Color(0xFFFFFFFF),
    backgroundTertiary: const Color(0xFFF9F7F5),
    backgroundPrimaryTransparent: const Color(0xCCF2E1DB),
    backgroundElevatedSurface: const Color(0xFFFFFFFF),
    backgroundElevatedSurfaceShadow: const Color(0x261E3ABA), // 15% opacity Primary Blue
    statusDanger: const Color(0xFFD64545),
    statusSuccess: const Color(0xFF2EC4B6),
    statusWarning: const Color(0xFFFF9F1C),
    borderPrimary: const Color(0xFFE5E6E7),
    borderSecondary: const Color(0xFFF1F2F3),
  );

  static final MixThemeData dark = _createTheme(
    brandPrimary: const Color(0xFF3F59C7),
    brandPressed: const Color(0xFF2E45B0),
    brandTransparent: const Color(0x663F59C7),
    brandSecondary: const Color(0xFFFF9F1C),
    brandTertiary: const Color(0xFF3D3426),
    textPrimary: const Color(0xFFFFFFFF),
    textSecondary: const Color(0xFFA1A9B4),
    textTertiary: const Color(0xFF485056),
    textForeground: const Color(0xFFFFFFFF),
    backgroundPrimary: const Color(0xFF1A1D21),
    backgroundSecondary: const Color(0xFF242830),
    backgroundTertiary: const Color(0xFF2C3038),
    backgroundPrimaryTransparent: const Color(0xCC1A1D21),
    backgroundElevatedSurface: const Color(0xFF2A2E36),
    backgroundElevatedSurfaceShadow: const Color(0x4D000000),
    statusDanger: const Color(0xFFE06B6B),
    statusSuccess: const Color(0xFF58D0C5),
    statusWarning: const Color(0xFFFFAE42),
    borderPrimary: const Color(0xFF3A3F48),
    borderSecondary: const Color(0xFF2C3138),
  );

  static MixThemeData fromBrightness(Brightness brightness) =>
      brightness == Brightness.light ? light : dark;

  static MixThemeData _createTheme({
    required Color brandPrimary,
    required Color brandPressed,
    required Color brandTransparent,
    required Color brandSecondary,
    required Color brandTertiary,
    required Color textPrimary,
    required Color textSecondary,
    required Color textTertiary,
    required Color textForeground,
    required Color backgroundPrimary,
    required Color backgroundSecondary,
    required Color backgroundTertiary,
    required Color backgroundPrimaryTransparent,
    required Color backgroundElevatedSurface,
    required Color backgroundElevatedSurfaceShadow,
    required Color statusDanger,
    required Color statusSuccess,
    required Color statusWarning,
    required Color borderPrimary,
    required Color borderSecondary,
  }) {
    final colorTokens = $mentorxToken.color;
    final radiusTokens = $mentorxToken.radius;
    final styleTokens = $mentorxToken.textStyle;

    return MixThemeData(
      colors: {
        colorTokens.brandPrimary: brandPrimary,
        colorTokens.brandPressed: brandPressed,
        colorTokens.brandTransparent: brandTransparent,
        colorTokens.brandSecondary: brandSecondary,
        colorTokens.brandTertiary: brandTertiary,
        colorTokens.textPrimary: textPrimary,
        colorTokens.textSecondary: textSecondary,
        colorTokens.textTertiary: textTertiary,
        colorTokens.textForeground: textForeground,
        colorTokens.backgroundPrimary: backgroundPrimary,
        colorTokens.backgroundSecondary: backgroundSecondary,
        colorTokens.backgroundTertiary: backgroundTertiary,
        colorTokens.backgroundPrimaryTransparent: backgroundPrimaryTransparent,
        colorTokens.backgroundElevatedSurface: backgroundElevatedSurface,
        colorTokens.backgroundElevatedSurfaceShadow:
            backgroundElevatedSurfaceShadow,
        colorTokens.statusDanger: statusDanger,
        colorTokens.statusSuccess: statusSuccess,
        colorTokens.statusWarning: statusWarning,
        colorTokens.borderPrimary: borderPrimary,
        colorTokens.borderSecondary: borderSecondary,
      },
      textStyles: {
        styleTokens.titleH1: GoogleFonts.cairo(
          fontSize: 28,
          fontWeight: FontWeight.w900,
          color: textPrimary,
          letterSpacing: -1.0,
        ),
        styleTokens.titleH2: GoogleFonts.cairo(
          fontSize: 22,
          fontWeight: FontWeight.w800,
          color: textPrimary,
          letterSpacing: -0.5,
        ),
        styleTokens.sectionTitle: GoogleFonts.cairo(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),
        styleTokens.bodyPrimary: GoogleFonts.cairo(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        styleTokens.bodySecondary: GoogleFonts.cairo(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: textSecondary,
        ),
        styleTokens.smallText: GoogleFonts.cairo(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: textSecondary,
        ),
      },
      radii: {
        radiusTokens.thin: const Radius.circular(6),
        radiusTokens.extraSmall: const Radius.circular(12),
        radiusTokens.small: const Radius.circular(16),
        radiusTokens.medium: const Radius.circular(24),
        radiusTokens.large: const Radius.circular(40),
      },
    );
  }

  // ── Shadow Constants ──────────────────────────────────────────────────
  static List<BoxShadow> softShadow(Color shadowColor) => [
        BoxShadow(
          color: shadowColor.withValues(alpha: 0.05),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> mediumShadow(Color shadowColor) => [
        BoxShadow(
          color: shadowColor.withValues(alpha: 0.1),
          blurRadius: 20,
          offset: const Offset(0, 8),
        ),
      ];

  static List<BoxShadow> hardShadow(Color shadowColor) => [
        BoxShadow(
          color: shadowColor.withValues(alpha: 0.15),
          blurRadius: 30,
          offset: const Offset(0, 12),
        ),
      ];

  /// This is used incase we need to use any existing material design components
  /// and this makes sure that the material components colors match our app theme
  static ThemeData materialThemeDataFromTheme(
    MixThemeData theme,
    BuildContext context,
  ) {
    final ThemeData defaultThemeData = Theme.of(context);

    // Resolve colors from theme tokens
    final primaryBlue = theme.colors[$mentorxToken.color.brandPrimary]!;
    final accentWarm = theme.colors[$mentorxToken.color.brandSecondary]!;
    final secondaryGreen = theme.colors[$mentorxToken.color.statusSuccess]!;
    final neutralGrey = theme.colors[$mentorxToken.color.textSecondary]!;
    final neutralLight = theme.colors[$mentorxToken.color.backgroundPrimary]!;
    final surfaceWhite = theme.colors[$mentorxToken.color.backgroundSecondary]!;
    final shadowColor = theme.colors[$mentorxToken.color.backgroundElevatedSurfaceShadow]!;
    final textPrimary = theme.colors[$mentorxToken.color.textPrimary]!;
    final textForeground = theme.colors[$mentorxToken.color.textForeground]!;
    final statusDanger = theme.colors[$mentorxToken.color.statusDanger]!;

    // Input decoration
    const inputBorderRadius = BorderRadius.all(Radius.circular(14));
    final focusedBorderSide = BorderSide(color: primaryBlue, width: 2.0);
    final inactiveBorderSide = BorderSide(color: neutralGrey.withValues(alpha: 0.2), width: 1.5);
    final errorBorderSide = BorderSide(color: statusDanger, width: 2.0);

    final focusedBorder = OutlineInputBorder(
      borderSide: focusedBorderSide,
      borderRadius: inputBorderRadius,
    );

    final mainInputDecoration = InputDecorationTheme(
      filled: true,
      fillColor: surfaceWhite,
      helperMaxLines: 1,
      iconColor: primaryBlue,
      suffixIconColor: primaryBlue,
      prefixIconColor: primaryBlue,
      labelStyle: GoogleFonts.cairo(color: neutralGrey, fontSize: 14),
      hintStyle: GoogleFonts.cairo(color: neutralGrey, fontSize: 14),
      floatingLabelStyle: GoogleFonts.cairo(color: primaryBlue, fontSize: 14),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
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
          color: neutralGrey.withValues(alpha: 0.1),
          width: 1,
        ),
        borderRadius: inputBorderRadius,
      ),
    );

    return defaultThemeData.copyWith(
      scaffoldBackgroundColor: neutralLight,
      canvasColor: neutralLight,
      primaryColor: primaryBlue,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryBlue,
        primary: primaryBlue,
        secondary: accentWarm,
        surface: surfaceWhite,
        error: statusDanger,
        onPrimary: textForeground,
        onSecondary: textForeground,
        onSurface: textPrimary,
        tertiary: secondaryGreen,
        shadow: shadowColor,
      ),
      // AppBar: Primary Blue bg, white title, elevation 0, centered
      appBarTheme: AppBarTheme(
        backgroundColor: primaryBlue,
        foregroundColor: textForeground,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: GoogleFonts.cairo(
          fontSize: 20,
          fontWeight: FontWeight.w700,
          color: textForeground,
        ),
        iconTheme: IconThemeData(color: textForeground),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      // Primary Button: Primary Blue bg, white text, borderRadius 16, height 54
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryBlue,
          foregroundColor: textForeground,
          elevation: 4,
          shadowColor: shadowColor.withValues(alpha: 0.5),
          minimumSize: const Size.fromHeight(54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: GoogleFonts.cairo(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
          disabledBackgroundColor: neutralGrey.withValues(alpha: 0.2),
          disabledForegroundColor: textForeground.withValues(alpha: 0.5),
        ),
      ),
      // CTA / accent buttons use Accent Warm
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: accentWarm,
          foregroundColor: textForeground,
          elevation: 4,
          shadowColor: accentWarm.withValues(alpha: 0.3),
          minimumSize: const Size.fromHeight(54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: GoogleFonts.cairo(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
          disabledBackgroundColor: neutralGrey.withValues(alpha: 0.2),
          disabledForegroundColor: textForeground.withValues(alpha: 0.5),
        ),
      ),
      // Text button with Accent Warm text
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: accentWarm,
          textStyle: GoogleFonts.cairo(
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      // Outlined button
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryBlue,
          minimumSize: const Size.fromHeight(54),
          side: BorderSide(color: primaryBlue.withValues(alpha: 0.2), width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: GoogleFonts.cairo(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      // Card: white bg, borderRadius 20, soft colored shadow
      cardTheme: CardThemeData(
        color: surfaceWhite,
        elevation: 0,
        margin: const EdgeInsets.only(bottom: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: primaryBlue.withValues(alpha: 0.05), width: 1),
        ),
        shadowColor: shadowColor,
      ),
      // Checkbox
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
        fillColor: WidgetStateProperty.fromMap({
          WidgetState.selected: primaryBlue,
          WidgetState.any: neutralGrey.withValues(alpha: 0.3),
        }),
        checkColor: WidgetStateProperty.all(textForeground),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      // Text theme using Cairo
      textTheme: GoogleFonts.cairoTextTheme(defaultThemeData.textTheme)
          .copyWith(
        headlineLarge: GoogleFonts.cairo(
          fontSize: 26,
          fontWeight: FontWeight.w800,
          color: textPrimary,
          letterSpacing: -0.5,
        ),
        headlineMedium: GoogleFonts.cairo(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: textPrimary,
          letterSpacing: -0.3,
        ),
        titleLarge: GoogleFonts.cairo(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        bodyLarge: GoogleFonts.cairo(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: textPrimary,
        ),
        bodyMedium: GoogleFonts.cairo(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: neutralGrey,
        ),
        bodySmall: GoogleFonts.cairo(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: neutralGrey,
        ),
      ),
      inputDecorationTheme: mainInputDecoration,
    );
  }
}
