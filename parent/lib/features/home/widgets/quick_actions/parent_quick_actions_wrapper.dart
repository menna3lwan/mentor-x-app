import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../../../../core/routing/app_routes.dart';
import '../../bloc/home_bloc.dart';
import 'parent_quick_actions_widget.dart';

/// Wires the 8 quick-actions to the right per-child routes.
/// Any action that depends on a selected child is disabled while no child
/// is selected.
class ParentQuickActionsWrapper extends StatelessWidget {
  const ParentQuickActionsWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;

    return BlocBuilder<HomeBloc, HomeState>(
      buildWhen: (prev, curr) =>
          prev.selectedChild?.id != curr.selectedChild?.id,
      builder: (context, state) {
        final childId = state.selectedChild?.id;
        final hasChild = childId != null;

        return ParentQuickActionsWidget(
          actions: [
            ParentQuickAction(
              icon: Icons.calendar_today_rounded,
              label: t.quickActions.attendance,
              enabled: hasChild,
              onTap: hasChild
                  ? () => AttendanceMonitorRoute(childId: childId).go(context)
                  : null,
            ),
            ParentQuickAction(
              icon: Icons.auto_stories_rounded,
              label: t.quickActions.courses,
              enabled: hasChild,
              onTap: hasChild
                  ? () => AcademicMonitorRoute(childId: childId).go(context)
                  : null,
            ),
            ParentQuickAction(
              icon: Icons.account_balance_wallet_rounded,
              label: t.quickActions.fees,
              enabled: hasChild,
              onTap: hasChild
                  ? () => FinancialMonitorRoute(childId: childId).go(context)
                  : null,
            ),
            ParentQuickAction(
              icon: Icons.chat_bubble_rounded,
              label: t.quickActions.messages,
              enabled: hasChild,
              onTap: hasChild
                  ? () => WhatsAppGroupsRoute(childId: childId).go(context)
                  : null,
            ),
            ParentQuickAction(
              icon: Icons.grading_rounded,
              label: t.quickActions.grades,
              enabled: hasChild,
              onTap: hasChild
                  ? () => GradeMonitorRoute(childId: childId).go(context)
                  : null,
            ),
            ParentQuickAction(
              icon: Icons.insights_rounded,
              label: t.analytics.pageTitle,
              enabled: hasChild,
              onTap: hasChild
                  ? () =>
                        AnalyticsMonitorRoute(childId: childId).go(context)
                  : null,
            ),
            ParentQuickAction(
              icon: Icons.campaign_rounded,
              label: t.quickActions.announcements,
              enabled: hasChild,
              onTap: hasChild
                  ? () => AnnouncementsRoute(childId: childId).go(context)
                  : null,
            ),
            ParentQuickAction(
              icon: Icons.notifications_active_rounded,
              label: t.notifications,
              enabled: hasChild,
              onTap: hasChild
                  ? () => NotificationsRoute(childId: childId).go(context)
                  : null,
            ),
            ParentQuickAction(
              icon: Icons.account_balance_wallet_outlined,
              label: t.financial.myWalletTitle,
              onTap: () => const MyWalletRoute().go(context),
            ),
            ParentQuickAction(
              icon: Icons.person_outline_rounded,
              label: t.myProfile,
              onTap: () => const ProfileRoute().go(context),
            ),
          ],
        );
      },
    );
  }
}
