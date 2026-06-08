import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../../bloc/home_bloc.dart';
import 'parent_hero_card_widget.dart';

/// Binds the summary section state to [ParentHeroCardWidget].
/// Falls back to skeleton on loading and to a compact error/empty state.
class ParentHeroCardWrapper extends StatelessWidget {
  const ParentHeroCardWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;

    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (prev, curr) => prev.summarySection != curr.summarySection,
      builder: (context, state) {
        final section = state.summarySection;

        if (section.isLoading && section.data == null) {
          return const ParentHeroCardSkeleton();
        }
        if (section.isFailure && section.data == null) {
          return _HeroCardFailure(
            message: section.errorMessage ?? t.unableToLoad,
            onRetry: () => context.read<HomeBloc>().add(
              const HomeRetrySectionRequested(HomeSection.summary),
            ),
            retryLabel: t.retry,
          );
        }

        final summary = section.data;
        if (summary == null) return const SizedBox.shrink();

        return ParentHeroCardWidget(
          overview: summary.overview,
          title: t.home.academicStanding,
          avgGradeLabel: t.home.avgGrade,
          attendanceLabel: t.home.attendance,
          unpaidFeesLabel: t.home.unpaidFees,
        );
      },
    );
  }
}

class _HeroCardFailure extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  final String retryLabel;

  const _HeroCardFailure({
    required this.message,
    required this.onRetry,
    required this.retryLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.statusDangerColor.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: context.statusDangerColor.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline_rounded,
            color: context.statusDangerColor,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: context.textPrimaryColor,
                fontWeight: FontWeight.w700,
                fontSize: 13,
              ),
            ),
          ),
          TextButton(onPressed: onRetry, child: Text(retryLabel)),
        ],
      ),
    );
  }
}
