import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/blocs/app_authentication_cubit/app_authentication_cubit.dart';
import '../../../core/routing/app_routes.dart';
import '../bloc/account_status_cubit.dart';

/// Pending Account gate.
///
/// Shown immediately after registration (and as a re-entry point on every
/// subsequent app launch) while the parent's account is in `pending` review.
/// The page polls the backend; once the account is approved the listener
/// pushes the user into the main shell.
class PendingAccountPageWrapper extends StatelessWidget {
  const PendingAccountPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AccountStatusCubit(
        repository: context.read<ParentAccountStatusRepository>(),
        appAuthCubit: context.read<AppAuthenticationCubit>(),
      )..start(),
      child: const _PendingAccountView(),
    );
  }
}

class _PendingAccountView extends StatelessWidget {
  const _PendingAccountView();

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;
    return BlocPresentationListener<AccountStatusCubit,
        AccountStatusPresentationEvent>(
      listener: (context, event) {
        switch (event) {
          case AccountStatusApprovedPresentationEvent():
            MentorXUI.showToast(
              message: t.pendingAccount.approvedToastMessage,
            );
            const HomePageRoute().go(context);
          case AccountStatusLoadFailedPresentationEvent(:final message):
            MentorXUI.showToast(message: message, isError: true);
          case AccountStatusUnauthorizedPresentationEvent():
            context.read<AppAuthenticationCubit>().logout();
            const LoginPageRoute().go(context);
        }
      },
      child: PopScope(
        // Disable the system back button: this is a gating page, the user
        // should not be able to navigate behind it.
        canPop: false,
        child: Scaffold(
          backgroundColor: context.backgroundPrimaryColor,
          appBar: AppBar(
            backgroundColor: context.backgroundSecondaryColor,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: Text(
              t.pendingAccount.pageTitle,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: context.brandPrimaryColor,
                  ),
            ),
            actions: [
              BlocBuilder<AccountStatusCubit, AccountStatusState>(
                buildWhen: (p, c) => p.isRefreshing != c.isRefreshing,
                builder: (context, state) => IconButton(
                  tooltip: t.pendingAccount.checkAgain,
                  onPressed: state.isRefreshing
                      ? null
                      : () => context.read<AccountStatusCubit>().refresh(),
                  icon: state.isRefreshing
                      ? SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: context.brandPrimaryColor,
                          ),
                        )
                      : Icon(
                          Icons.refresh_rounded,
                          color: context.brandPrimaryColor,
                        ),
                ),
              ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: () =>
                context.read<AccountStatusCubit>().refresh(),
            child: BlocBuilder<AccountStatusCubit, AccountStatusState>(
              builder: (context, state) => _body(context, state, t),
            ),
          ),
        ),
      ),
    );
  }

  Widget _body(
    BuildContext context,
    AccountStatusState state,
    TranslationsParentEn t,
  ) {
    if (state.status.isInitial || state.status.isLoading) {
      return ListView(
        padding: const EdgeInsets.all(24),
        children: const [
          MentorXSkeleton(width: double.infinity, height: 180, borderRadius: 20),
          SizedBox(height: 20),
          MentorXSkeleton(width: double.infinity, height: 120, borderRadius: 20),
          SizedBox(height: 20),
          MentorXSkeleton(width: double.infinity, height: 200, borderRadius: 20),
        ],
      );
    }

    if (state.status.isFailure) {
      return AppErrorView(
        title: t.pendingAccount.loadErrorTitle,
        message: state.errorMessage ?? t.pendingAccount.loadErrorMessage,
        buttonText: t.pendingAccount.checkAgain,
        onRetry: () => context.read<AccountStatusCubit>().refresh(),
      );
    }

    return ListView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      padding: const EdgeInsets.all(24),
      children: [
        _HeroCard(state: state, t: t),
        const Gap(20),
        _StepsCard(state: state, t: t),
        const Gap(20),
        if (state.entity.rejectionReason != null &&
            state.isRejectedOrSuspended)
          _RejectionReasonCard(
            reason: state.entity.rejectionReason!,
            t: t,
          ),
        if (state.entity.rejectionReason != null &&
            state.isRejectedOrSuspended)
          const Gap(20),
        _SupportCard(state: state, t: t),
        const Gap(20),
        _ActionsRow(state: state, t: t),
        const Gap(40),
      ],
    );
  }
}

// ──── Hero card ──────────────────────────────────────────────────────────────

class _HeroCard extends StatelessWidget {
  final AccountStatusState state;
  final TranslationsParentEn t;
  const _HeroCard({required this.state, required this.t});

  @override
  Widget build(BuildContext context) {
    final isRejected = state.isRejectedOrSuspended;
    final accentColor = isRejected
        ? context.statusDangerColor
        : context.brandPrimaryColor;
    final iconData =
        isRejected ? Icons.error_outline_rounded : Icons.hourglass_top_rounded;
    final headline = isRejected
        ? t.pendingAccount.headlineRejected
        : t.pendingAccount.headlinePending;
    final subtitle = isRejected
        ? t.pendingAccount.subtitleRejected
        : t.pendingAccount.subtitlePending;
    final badgeLabel = isRejected
        ? t.pendingAccount.statusBadgeRejected
        : t.pendingAccount.statusBadgePending;

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            accentColor.withValues(alpha: 0.12),
            accentColor.withValues(alpha: 0.04),
          ],
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: accentColor.withValues(alpha: 0.20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(iconData, color: accentColor, size: 26),
              ),
              const Gap(12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.circle,
                        size: 8,
                        color: accentColor,
                      ),
                      const Gap(6),
                      Flexible(
                        child: Text(
                          badgeLabel,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: accentColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Gap(16),
          Text(
            headline,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: context.textPrimaryColor,
              height: 1.3,
            ),
          ),
          const Gap(8),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: context.textSecondaryColor,
              height: 1.6,
            ),
          ),
          if (state.entity.submittedAt != null) ...[
            const Gap(16),
            _MetadataRow(
              icon: Icons.event_available_outlined,
              label: t.pendingAccount.submittedOn(
                date: _formatDate(state.entity.submittedAt!),
              ),
            ),
          ],
          if (state.entity.estimatedReviewBy != null) ...[
            const Gap(8),
            _MetadataRow(
              icon: Icons.schedule_outlined,
              label: t.pendingAccount.estimatedReviewBy(
                date: _formatDate(state.entity.estimatedReviewBy!),
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatDate(DateTime d) {
    final formatter = DateFormat.yMMMMd();
    return formatter.format(d.toLocal());
  }
}

class _MetadataRow extends StatelessWidget {
  final IconData icon;
  final String label;
  const _MetadataRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 16, color: context.textSecondaryColor),
        const Gap(8),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: context.textSecondaryColor,
            ),
          ),
        ),
      ],
    );
  }
}

// ──── Steps card ─────────────────────────────────────────────────────────────

class _StepsCard extends StatelessWidget {
  final AccountStatusState state;
  final TranslationsParentEn t;
  const _StepsCard({required this.state, required this.t});

  @override
  Widget build(BuildContext context) {
    // Progress logic: received ≈ always done once we have *any* entity, review
    // is active while pending, approved is the final state.
    final isPending = state.isPending;
    final isActive = state.isActive;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: context.borderSecondaryColor,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _StepRow(
            label: t.pendingAccount.stepReceived,
            hint: t.pendingAccount.stepReceivedHint,
            isCompleted: true,
            isActive: false,
            isFirst: true,
          ),
          _StepRow(
            label: t.pendingAccount.stepUnderReview,
            hint: t.pendingAccount.stepUnderReviewHint,
            isCompleted: isActive,
            isActive: isPending,
            isFirst: false,
          ),
          _StepRow(
            label: t.pendingAccount.stepApproved,
            hint: t.pendingAccount.stepApprovedHint,
            isCompleted: isActive,
            isActive: false,
            isFirst: false,
            isLast: true,
          ),
        ],
      ),
    );
  }
}

class _StepRow extends StatelessWidget {
  final String label;
  final String hint;
  final bool isCompleted;
  final bool isActive;
  final bool isFirst;
  final bool isLast;

  const _StepRow({
    required this.label,
    required this.hint,
    required this.isCompleted,
    required this.isActive,
    required this.isFirst,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final brandColor = context.brandPrimaryColor;
    final mutedColor = context.textSecondaryColor.withValues(alpha: 0.5);
    final dotColor = isCompleted
        ? brandColor
        : isActive
            ? brandColor
            : mutedColor;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 18,
                height: 18,
                decoration: BoxDecoration(
                  color: isCompleted
                      ? dotColor
                      : Colors.transparent,
                  border: Border.all(color: dotColor, width: 2),
                  shape: BoxShape.circle,
                ),
                child: isCompleted
                    ? Icon(
                        Icons.check,
                        size: 12,
                        color: context.backgroundSecondaryColor,
                      )
                    : isActive
                        ? Center(
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: dotColor,
                                shape: BoxShape.circle,
                              ),
                            ),
                          )
                        : null,
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: isCompleted ? dotColor : mutedColor,
                  ),
                ),
            ],
          ),
          const Gap(14),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                top: isFirst ? 0 : 2,
                bottom: isLast ? 0 : 18,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      color: isActive || isCompleted
                          ? context.textPrimaryColor
                          : context.textSecondaryColor,
                    ),
                  ),
                  const Gap(4),
                  Text(
                    hint,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: context.textSecondaryColor,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ──── Rejection reason card ──────────────────────────────────────────────────

class _RejectionReasonCard extends StatelessWidget {
  final String reason;
  final TranslationsParentEn t;
  const _RejectionReasonCard({required this.reason, required this.t});

  @override
  Widget build(BuildContext context) {
    final danger = context.statusDangerColor;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: danger.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: danger.withValues(alpha: 0.20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.report_gmailerrorred_outlined, color: danger),
              const Gap(8),
              Text(
                t.pendingAccount.rejectionReasonTitle,
                style: TextStyle(
                  color: danger,
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const Gap(8),
          Text(
            reason,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: context.textPrimaryColor,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

// ──── Support card ───────────────────────────────────────────────────────────

class _SupportCard extends StatelessWidget {
  final AccountStatusState state;
  final TranslationsParentEn t;
  const _SupportCard({required this.state, required this.t});

  @override
  Widget build(BuildContext context) {
    final support = state.entity.supportContact;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: context.borderSecondaryColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.support_agent_rounded,
                color: context.brandPrimaryColor,
              ),
              const Gap(8),
              Text(
                t.pendingAccount.supportLabel,
                style: TextStyle(
                  color: context.textPrimaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          const Gap(8),
          Text(
            t.pendingAccount.contactSupportHint,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: context.textSecondaryColor,
              height: 1.6,
            ),
          ),
          const Gap(12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => _openSupport(context, support),
              icon: Icon(
                Icons.mail_outline_rounded,
                size: 16,
                color: context.brandPrimaryColor,
              ),
              label: Text(
                support ?? t.pendingAccount.contactSupport,
                style: TextStyle(
                  color: context.brandPrimaryColor,
                  fontWeight: FontWeight.w800,
                ),
              ),
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: context.brandPrimaryColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openSupport(BuildContext context, String? support) async {
    if (support == null || support.trim().isEmpty) return;
    final trimmed = support.trim();
    final uri = trimmed.contains('@')
        ? Uri.parse('mailto:$trimmed')
        : Uri.parse('tel:$trimmed');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

// ──── Bottom actions ─────────────────────────────────────────────────────────

class _ActionsRow extends StatelessWidget {
  final AccountStatusState state;
  final TranslationsParentEn t;
  const _ActionsRow({required this.state, required this.t});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: MentorXButton(
            text: state.isRefreshing
                ? t.pendingAccount.checking
                : t.pendingAccount.checkAgain,
            onPressed: state.isRefreshing
                ? null
                : () => context.read<AccountStatusCubit>().refresh(),
          ),
        ),
        const Gap(10),
        SizedBox(
          width: double.infinity,
          child: TextButton.icon(
            onPressed: () => _confirmSignOut(context, t),
            icon: Icon(
              Icons.logout_rounded,
              size: 16,
              color: context.statusDangerColor,
            ),
            label: Text(
              t.pendingAccount.signOut,
              style: TextStyle(
                color: context.statusDangerColor,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _confirmSignOut(
    BuildContext context,
    TranslationsParentEn t,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: dialogContext.backgroundSecondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          title: Text(t.pendingAccount.signOutConfirmTitle),
          content: Text(t.pendingAccount.signOutConfirmMessage),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(t.pendingAccount.cancel),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: dialogContext.statusDangerColor,
              ),
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(t.pendingAccount.signOut),
            ),
          ],
        );
      },
    );
    if (confirmed != true || !context.mounted) return;
    context.read<AppAuthenticationCubit>().logout();
    const LoginPageRoute().go(context);
  }
}
