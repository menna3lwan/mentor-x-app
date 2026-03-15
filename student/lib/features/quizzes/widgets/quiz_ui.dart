import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mentorx_ui/mentorx_ui.dart';

class QuizUi {
  static const double radiusSm = 8;
  static const double radiusMd = 12;
  static const double radiusLg = 16;

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [AppColors.accent, AppColors.accentLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient tealGradient = LinearGradient(
    colors: [AppColors.success, AppColors.tealLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static final List<BoxShadow> shadowSm = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.08),
      blurRadius: 3,
      offset: const Offset(0, 1),
    ),
  ];

  static final List<BoxShadow> shadowMd = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.10),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];

  const QuizUi._();
}

class QuizHeader extends StatelessWidget {
  const QuizHeader({
    super.key,
    required this.title,
    this.trailing,
    this.showBack = true,
    this.centerTitle = false,
    this.onBack,
  });

  final String title;
  final Widget? trailing;
  final bool showBack;
  final bool centerTitle;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: AppColors.primary,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(20, top + 12, 20, 20),
        color: AppColors.primary,
        child: IconTheme(
          data: const IconThemeData(color: Colors.white),
          child: Row(
            children: [
              if (showBack)
                QuizCircleButton(
                  onTap: onBack ?? () => Navigator.maybePop(context),
                  child: const BackButtonIcon(),
                )
              else
                const SizedBox(width: 36, height: 36),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  textAlign: centerTitle ? TextAlign.center : TextAlign.start,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              trailing ?? const SizedBox(width: 36, height: 36),
            ],
          ),
        ),
      ),
    );
  }
}

class QuizCircleButton extends StatelessWidget {
  const QuizCircleButton({super.key, required this.child, this.onTap});

  final Widget child;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.15),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(width: 36, height: 36, child: Center(child: child)),
      ),
    );
  }
}

class QuizTimerPill extends StatelessWidget {
  const QuizTimerPill({
    super.key,
    required this.text,
    this.icon = Icons.schedule_rounded,
  });

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(QuizUi.radiusSm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: Colors.white),
          const SizedBox(width: 8),
          Text(
            text,
            textDirection: TextDirection.ltr,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class QuizCard extends StatelessWidget {
  const QuizCard({
    super.key,
    required this.child,
    this.margin = const EdgeInsets.all(20),
    this.padding = const EdgeInsets.all(20),
    this.shadow = QuizCardShadow.md,
    this.borderRadius = QuizUi.radiusLg,
  });

  final Widget child;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final QuizCardShadow shadow;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final shadows = switch (shadow) {
      QuizCardShadow.none => const <BoxShadow>[],
      QuizCardShadow.sm => QuizUi.shadowSm,
      QuizCardShadow.md => QuizUi.shadowMd,
    };

    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: shadows,
      ),
      child: child,
    );
  }
}

enum QuizCardShadow { none, sm, md }

class QuizGradientButton extends StatelessWidget {
  const QuizGradientButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.gradient = QuizUi.primaryGradient,
  });

  final String label;
  final VoidCallback? onPressed;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    final enabled = onPressed != null;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(QuizUi.radiusMd),
        child: Ink(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            gradient: enabled ? gradient : null,
            color: enabled ? null : AppColors.greyLight,
            borderRadius: BorderRadius.circular(QuizUi.radiusMd),
            boxShadow: enabled
                ? [
                    BoxShadow(
                      color: AppColors.accent.withValues(alpha: 0.30),
                      blurRadius: 15,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: enabled ? Colors.white : AppColors.greyDark,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class QuizOutlineButton extends StatelessWidget {
  const QuizOutlineButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.primary, width: 2),
          foregroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(QuizUi.radiusMd),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}

class QuizResultCircle extends StatelessWidget {
  const QuizResultCircle({
    super.key,
    required this.correct,
    required this.total,
    required this.label,
  });

  final int correct;
  final int total;
  final String label;

  double get _percent => total == 0 ? 0 : (correct / total).clamp(0.0, 1.0);

  ({Gradient gradient, Color borderColor, Color textColor}) get _style {
    if (_percent >= 0.85) {
      return (
        gradient: const LinearGradient(
          colors: [AppColors.greenLight, AppColors.greenLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderColor: AppColors.green,
        textColor: AppColors.green,
      );
    }
    if (_percent >= 0.60) {
      return (
        gradient: const LinearGradient(
          colors: [AppColors.background, AppColors.beige],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderColor: AppColors.accent,
        textColor: AppColors.accent,
      );
    }
    return (
      gradient: const LinearGradient(
        colors: [AppColors.redLight, AppColors.redLight],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderColor: AppColors.red,
      textColor: AppColors.red,
    );
  }

  @override
  Widget build(BuildContext context) {
    final style = _style;
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    return Container(
      width: 160,
      height: 160,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: style.borderColor, width: 4),
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: style.gradient,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$correct',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w800,
                color: style.textColor,
              ),
            ),
            Text(
              isRtl ? '\u0645\u0646 $total' : 'of $total',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.greyDark,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: style.textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
