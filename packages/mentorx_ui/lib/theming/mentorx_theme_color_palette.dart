part of '../mentorx_ui.dart';

/// Static design-token color palette for the MentorX student app.
///
/// Used throughout the app via direct static access (e.g., [MentorXThemeColorPalette.primary]).
/// Mirrors the semantic colors for Material widgets
/// that don't support Mix tokens.
final class MentorXThemeColorPalette {
  MentorXThemeColorPalette._();

  // ── Brand / Primary ─────────────────────────────────────────────────────
  static const Color primary = Color(0xFF1E3ABA);
  static const Color primaryLight = Color(0xFF3F59C7);
  static const Color primaryMid = Color(0xFF182E95);
  static const Color primaryGradientEnd = Color(0xFF3F59C7);

  // ── Accent (Orange / CTA) ────────────────────────────────────────────────
  static const Color accent = Color(0xFFFF9F1C);
  static const Color accentLight = Color(0xFFFFB249);
  static const Color accentDark = Color(0xFFCC7F16);

  // ── Teal (AI / success) ──────────────────────────────────────────────────
  static const Color teal = Color(0xFF2EC4B6);
  static const Color tealLight = Color(0xFF58D0C5);
  static const Color tealDark = Color(0xFF259D92);

  // ── Grey ─────────────────────────────────────────────────────────────────
  static const Color grey = Color(0xFFB3B4B5);
  static const Color greyLight = Color(0xFFD1D2D3);
  static const Color greyDark = Color(0xFF8F9091);

  // ── Backgrounds ──────────────────────────────────────────────────────────
  static const Color background = Color(0xFFF2E1DB);
  static const Color backgroundLight = Color(0xFFF9F0ED);
  static const Color white = Color(0xFFFFFFFF);
  static const Color beige = Color(0xFFF2E1DB);

  // ── Status ───────────────────────────────────────────────────────────────
  static const Color success = Color(0xFF2EC4B6);
  static const Color green = Color(0xFF2EC4B6);
  static const Color greenLight = Color(0xFFEAF9F8);
  static const Color red = Color(0xFFE74C3C);
  static const Color redLight = Color(0xFFFDEAEA);
  static const Color purple = Color(0xFF8B5CF6);
  static const Color purpleLight = Color(0xFFF5F3FF);

  // ── Brand partnerships ───────────────────────────────────────────────────
  static const Color whatsAppGreen = Color(0xFF25D366);
}
