part of '../mentorx_ui.dart';

final class MentorXThemes {
  MentorXThemes._();

  static final MixThemeData light = _createTheme(
    brandPrimary: const Color(0xFF183764),
    brandPressed: const Color(0xFF0F2647),
    brandTransparent: const Color(0x66183764),
    brandSecondary: const Color(0xFFF59239),
    brandTertiary: const Color(0xFFFFF2DB),
    textPrimary: const Color(0xFF183764),
    textSecondary: const Color(0xFFB3B4B5),
    textTertiary: const Color(0xFFD1D2D3),
    textForeground: const Color(0xFFFFFFFF),
    backgroundPrimary: const Color(0xFFFFF2DB),
    backgroundSecondary: const Color(0xFFFFFFFF),
    backgroundTertiary: const Color(0xFFF5E6C8),
    backgroundPrimaryTransparent: const Color(0xCCFFF2DB),
    backgroundElevatedSurface: const Color(0xFFFFFFFF),
    backgroundElevatedSurfaceShadow: const Color(0x1A000000),
    statusDanger: const Color(0xFFD64545),
    statusSuccess: const Color(0xFF4BBBA0),
    statusWarning: const Color(0xFFF59239),
    borderPrimary: const Color(0xFFE5E6E7),
    borderSecondary: const Color(0xFFF1F2F3),
  );

  static final MixThemeData dark = _createTheme(
    brandPrimary: const Color(0xFF4A7BBF),
    brandPressed: const Color(0xFF3A6BAF),
    brandTransparent: const Color(0x664A7BBF),
    brandSecondary: const Color(0xFFF59239),
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
    statusSuccess: const Color(0xFF6DD4BE),
    statusWarning: const Color(0xFFF7A85C),
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
        colorTokens.backgroundElevatedSurfaceShadow: backgroundElevatedSurfaceShadow,
        colorTokens.statusDanger: statusDanger,
        colorTokens.statusSuccess: statusSuccess,
        colorTokens.statusWarning: statusWarning,
        colorTokens.borderPrimary: borderPrimary,
        colorTokens.borderSecondary: borderSecondary,
      },
      textStyles: {
        styleTokens.titleH1: GoogleFonts.cairo(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),
        styleTokens.titleH2: GoogleFonts.cairo(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        styleTokens.sectionTitle: GoogleFonts.cairo(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: textPrimary,
        ),
        styleTokens.bodyPrimary: GoogleFonts.cairo(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: textPrimary,
        ),
        styleTokens.bodySecondary: GoogleFonts.cairo(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: textSecondary,
        ),
        styleTokens.smallText: GoogleFonts.cairo(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: textSecondary,
        ),
      },
      radii: {
        radiusTokens.thin: const Radius.circular(2),
        radiusTokens.extraSmall: const Radius.circular(4),
        radiusTokens.small: const Radius.circular(8),
        radiusTokens.medium: const Radius.circular(16),
        radiusTokens.large: const Radius.circular(32),
      },
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
      labelStyle: GoogleFonts.cairo(color: ashGrey, fontSize: 14),
      hintStyle: GoogleFonts.cairo(color: ashGrey, fontSize: 14),
      floatingLabelStyle: GoogleFonts.cairo(color: oxfordBlue, fontSize: 14),
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
        titleTextStyle: GoogleFonts.cairo(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textForeground,
        ),
        iconTheme: IconThemeData(color: textForeground),
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness:
              defaultThemeData.brightness == Brightness.dark
                  ? Brightness.light
                  : Brightness.dark,
          statusBarBrightness: defaultThemeData.brightness,
        ),
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
          textStyle: GoogleFonts.cairo(
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
          textStyle: GoogleFonts.cairo(
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
          textStyle: GoogleFonts.cairo(
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
          textStyle: GoogleFonts.cairo(
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
      textTheme: GoogleFonts.cairoTextTheme(defaultThemeData.textTheme)
          .copyWith(
        headlineLarge: GoogleFonts.cairo(
          fontSize: 24,
          fontWeight: FontWeight.w700,
          color: textPrimary,
        ),
        headlineMedium: GoogleFonts.cairo(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        titleLarge: GoogleFonts.cairo(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: textPrimary,
        ),
        bodyLarge: GoogleFonts.cairo(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: textPrimary,
        ),
        bodyMedium: GoogleFonts.cairo(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: ashGrey,
        ),
        bodySmall: GoogleFonts.cairo(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: ashGrey,
        ),
      ),
      inputDecorationTheme: mainInputDecoration,
    );
  }
}
