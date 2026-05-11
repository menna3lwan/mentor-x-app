part of '../mentorx_ui.dart';

/// Static design-token color palette for the MentorX student app.
///
/// Used throughout the app via direct static access (e.g., [AppColors.primary]).
/// Mirrors the semantic colors for Material widgets
/// that don't support Mix tokens.
final class AppColors {
  AppColors._();

  // ── Brand / Primary ─────────────────────────────────────────────────────
  static const Color primary = Color(0xFF0B1D3A);
  static const Color primaryLight = Color(0xFF1A3A6B);
  static const Color primaryMid = Color(0xFF0F2A50);
  static const Color primaryGradientEnd = Color(0xFF1A3A6B);

  // ── Accent (Orange / CTA) ────────────────────────────────────────────────
  static const Color accent = Color(0xFFF28C28);
  static const Color accentLight = Color(0xFFFFAB40);
  static const Color accentDark = Color(0xFFD97706);

  // ── Teal (AI / success) ──────────────────────────────────────────────────
  static const Color teal = Color(0xFF14B8A6);
  static const Color tealLight = Color(0xFF5EEAD4);
  static const Color tealDark = Color(0xFF0D9488);

  // ── Grey ─────────────────────────────────────────────────────────────────
  static const Color grey = Color(0xFFB3B4B5);
  static const Color greyLight = Color(0xFFE8E9EA);
  static const Color greyDark = Color(0xFF6B6C6D);

  // ── Backgrounds ──────────────────────────────────────────────────────────
  static const Color background = Color(0xFFF8F9FA);
  static const Color backgroundLight = Color(0xFFF8F9FA);
  static const Color white = Color(0xFFFFFFFF);
  static const Color beige = Color(0xFFFFF2DB);

  // ── Status ───────────────────────────────────────────────────────────────
  static const Color success = Color(0xFF27AE60);
  static const Color green = Color(0xFF27AE60);
  static const Color greenLight = Color(0xFFE8F8F0);
  static const Color red = Color(0xFFE74C3C);
  static const Color redLight = Color(0xFFFDEAEA);
  static const Color purple = Color(0xFF8B5CF6);
  static const Color purpleLight = Color(0xFFF5F3FF);

  // ── Brand partnerships ───────────────────────────────────────────────────
  static const Color whatsAppGreen = Color(0xFF25D366);
}
