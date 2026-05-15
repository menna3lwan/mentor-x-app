import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

/// Pure-layout home page scaffold for the parent app.
///
/// Mirrors the student app's `HomePagePage`: an [AppDashboardScaffold] with
/// blurred-blob background decorations and a single scrollable content
/// region driven by a [content] slot.
final class HomePagePage extends StatelessWidget {
  final String title;
  final Widget content;
  final Future<void> Function() onRefresh;
  final List<Widget>? actions;

  const HomePagePage({
    super.key,
    required this.title,
    required this.content,
    required this.onRefresh,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppDashboardScaffold(
      title: title,
      actions: actions,
      onRefresh: onRefresh,
      body: Stack(
        children: [
          const _BackgroundDecorations(),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: content,
          ),
        ],
      ),
    );
  }
}

class _BackgroundDecorations extends StatelessWidget {
  const _BackgroundDecorations();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -100,
          right: -50,
          child: _BlurredBlob(
            color: context.brandPrimaryColor.withValues(alpha: 0.12),
            size: 350,
          ),
        ),
        Positioned(
          top: 300,
          left: -150,
          child: _BlurredBlob(
            color: context.brandSecondaryColor.withValues(alpha: 0.08),
            size: 400,
          ),
        ),
        Positioned(
          bottom: -50,
          right: -100,
          child: _BlurredBlob(
            color: context.brandPrimaryColor.withValues(alpha: 0.1),
            size: 300,
          ),
        ),
      ],
    );
  }
}

class _BlurredBlob extends StatelessWidget {
  final Color color;
  final double size;

  const _BlurredBlob({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
        child: const SizedBox.expand(),
      ),
    );
  }
}

/// Tiny pill that reports the time of the last successful refresh. Renders
/// nothing when [lastUpdatedAt] is `null`.
class HomeUpdatedAtChip extends StatelessWidget {
  final DateTime? lastUpdatedAt;
  final String Function(DateTime time) labelBuilder;

  const HomeUpdatedAtChip({
    super.key,
    required this.lastUpdatedAt,
    required this.labelBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final time = lastUpdatedAt;
    if (time == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        labelBuilder(time),
        style: TextStyle(
          color: context.textTertiaryColor,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

/// Lightweight wrapper to make `[SectionHeader] + Gap + child` consistent
/// across the home page (and ensures bottom padding is uniform).
class HomeSection extends StatelessWidget {
  final String title;
  final Widget child;
  final VoidCallback? onSeeAll;

  const HomeSection({
    super.key,
    required this.title,
    required this.child,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(title: title, onSeeAll: onSeeAll),
        const Gap(16),
        child,
      ],
    );
  }
}
