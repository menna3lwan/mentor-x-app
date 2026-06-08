import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import '../../../core/core.dart';
import 'package:url_launcher/url_launcher.dart';

import '../bloc/notifications_bloc.dart';
import '../domain/usecases/notification_usecases.dart';

final class NotificationsParentPage extends StatelessWidget {
  final String childId;

  const NotificationsParentPage({super.key, required this.childId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final repository = context.read<NotificationRepository>();
        return NotificationsBloc(
          getNotifications: GetParentNotificationsUseCase(repository),
          markAsRead: MarkParentNotificationAsReadUseCase(repository),
          markAllAsRead: MarkAllParentNotificationsAsReadUseCase(repository),
          getUnreadCount: GetParentUnreadNotificationsCountUseCase(repository),
        )..add(const NotificationsStarted());
      },
      child: const _NotificationsView(),
    );
  }
}

final class _NotificationsView extends StatefulWidget {
  const _NotificationsView();

  @override
  State<_NotificationsView> createState() => _NotificationsViewState();
}

final class _NotificationsViewState extends State<_NotificationsView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 160) {
      context.read<NotificationsBloc>().add(
        const NotificationsLoadMoreRequested(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent.notificationCenter;

    return MultiBlocListener(
      listeners: [
        BlocListener<NotificationsBloc, NotificationsState>(
          listenWhen: (previous, current) =>
              previous.unreadCount != current.unreadCount,
          listener: (context, state) {
            context.read<NotificationsBadgeCubit>().setCount(state.unreadCount);
          },
        ),
        BlocPresentationListener<
          NotificationsBloc,
          NotificationsPresentationEvent
        >(
          listener: (context, event) {
            switch (event) {
              case NotificationsFailurePresentationEvent(:final message):
                MentorXUI.showToast(message: message, isError: true);
              case NotificationMarkedReadPresentationEvent():
                MentorXUI.showToast(message: t.markReadSuccess);
              case NotificationsMarkedAllReadPresentationEvent():
                MentorXUI.showToast(message: t.markAllReadSuccess);
            }
          },
        ),
      ],
      child: AppDashboardScaffold(
        title: t.title,
        onRefresh: () async => context.read<NotificationsBloc>().add(
          const NotificationsRefreshRequested(),
        ),
        actions: [
          BlocBuilder<NotificationsBloc, NotificationsState>(
            buildWhen: (previous, current) =>
                previous.unreadCount != current.unreadCount ||
                previous.isMarkingAllRead != current.isMarkingAllRead,
            builder: (context, state) {
              return IconButton(
                tooltip: t.markAllRead,
                onPressed: state.unreadCount == 0 || state.isMarkingAllRead
                    ? null
                    : () => context.read<NotificationsBloc>().add(
                        const NotificationsMarkAllReadRequested(),
                      ),
                icon: state.isMarkingAllRead
                    ? const SizedBox.square(
                        dimension: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.done_all_rounded),
              );
            },
          ),
        ],
        body: BlocBuilder<NotificationsBloc, NotificationsState>(
          builder: (context, state) {
            if (state.isLoading && state.notifications.isEmpty) {
              return ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(20),
                itemBuilder: (_, _) => const MentorXSkeleton(
                  height: 96,
                  borderRadius: 16,
                ),
                separatorBuilder: (_, _) => const Gap(12),
                itemCount: 6,
              );
            }

            if (state.errorMessage != null && state.notifications.isEmpty) {
              return AppErrorView(
                message: t.loadFailed,
                onRetry: () => context.read<NotificationsBloc>().add(
                  const NotificationsStarted(),
                ),
              );
            }

            if (state.notifications.isEmpty) {
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(24),
                children: [
                  const Gap(120),
                  AppEmptyView(
                    title: t.noNotificationsTitle,
                    message: t.noNotificationsHint,
                    icon: Icons.notifications_off_rounded,
                  ),
                ],
              );
            }

            return ListView.separated(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
              itemCount:
                  state.notifications.length + (state.isLoadingMore ? 1 : 0),
              separatorBuilder: (_, _) => const Gap(12),
              itemBuilder: (context, index) {
                if (index == state.notifications.length) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final notification = state.notifications[index];
                return _NotificationTile(
                  notification: notification,
                  onTap: () {
                    if (!notification.isRead) {
                      context.read<NotificationsBloc>().add(
                        NotificationMarkReadRequested(notification.id),
                      );
                    }
                    _showNotificationDetails(context, notification);
                  },
                  onMarkRead: notification.isRead
                      ? null
                      : () => context.read<NotificationsBloc>().add(
                          NotificationMarkReadRequested(notification.id),
                        ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

final class _NotificationTile extends StatelessWidget {
  final NotificationEntity notification;
  final VoidCallback onTap;
  final VoidCallback? onMarkRead;

  const _NotificationTile({
    required this.notification,
    required this.onTap,
    required this.onMarkRead,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent.notificationCenter;
    final isUnread = !notification.isRead;
    final accentColor = _colorForType(context, notification.type);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final date = DateFormat.yMMMd(
      locale,
    ).add_jm().format(notification.createdAt);

    return Semantics(
      button: true,
      label: '${notification.title}, ${isUnread ? t.unread : t.read}',
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: context.mediumRadius,
          child: Ink(
            decoration: BoxDecoration(
              color: isUnread
                  ? context.brandTransparentColor
                  : context.backgroundSecondaryColor,
              borderRadius: context.mediumRadius,
              border: Border.all(
                color: isUnread
                    ? context.brandPrimaryColor.withValues(alpha: 0.22)
                    : context.borderPrimaryColor.withValues(alpha: 0.12),
              ),
              boxShadow: [
                BoxShadow(
                  color: context.backgroundElevatedSurfaceShadowColor,
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: accentColor.withValues(alpha: 0.12),
                      borderRadius: context.smallRadius,
                    ),
                    child: Icon(
                      _iconForType(notification.type),
                      color: accentColor,
                    ),
                  ),
                  const Gap(14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                notification.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: context.bodyPrimaryStyle.copyWith(
                                  color: context.textPrimaryColor,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                            if (isUnread) ...[
                              const Gap(8),
                              Container(
                                width: 9,
                                height: 9,
                                decoration: BoxDecoration(
                                  color: context.brandPrimaryColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ],
                          ],
                        ),
                        const Gap(6),
                        Text(
                          notification.message,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: context.bodySecondaryStyle.copyWith(
                            color: context.textSecondaryColor,
                            height: 1.35,
                          ),
                        ),
                        const Gap(10),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                date,
                                style: context.smallTextStyle.copyWith(
                                  color: context.textTertiaryColor,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            if (onMarkRead != null)
                              IconButton(
                                tooltip: t.markRead,
                                onPressed: onMarkRead,
                                icon: const Icon(Icons.mark_email_read_rounded),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _colorForType(BuildContext context, NotificationType type) {
    return switch (type) {
      NotificationType.success => context.statusSuccessColor,
      NotificationType.warning => context.statusWarningColor,
      NotificationType.error => context.statusDangerColor,
      NotificationType.course => context.brandPrimaryColor,
      NotificationType.quiz => context.brandSecondaryColor,
      NotificationType.announcement => context.brandTertiaryColor,
      NotificationType.system => context.textSecondaryColor,
      NotificationType.info => context.brandPrimaryColor,
    };
  }

  IconData _iconForType(NotificationType type) {
    return switch (type) {
      NotificationType.success => Icons.check_circle_rounded,
      NotificationType.warning => Icons.warning_rounded,
      NotificationType.error => Icons.error_rounded,
      NotificationType.course => Icons.auto_stories_rounded,
      NotificationType.quiz => Icons.quiz_rounded,
      NotificationType.announcement => Icons.campaign_rounded,
      NotificationType.system => Icons.settings_rounded,
      NotificationType.info => Icons.notifications_rounded,
    };
  }
}

Future<void> _showNotificationDetails(
  BuildContext context,
  NotificationEntity notification,
) {
  final t = Translations.of(context).parent.notificationCenter;
  final locale = Localizations.localeOf(context).toLanguageTag();
  final date = DateFormat.yMMMMd(
    locale,
  ).add_jm().format(notification.createdAt);

  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: context.backgroundSecondaryColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: context.largeRadius.topLeft),
    ),
    builder: (context) {
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t.detailsTitle,
                style: context.sectionTitleStyle.copyWith(
                  color: context.textPrimaryColor,
                ),
              ),
              const Gap(16),
              Text(
                notification.title,
                style: context.bodyPrimaryStyle.copyWith(
                  color: context.textPrimaryColor,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Gap(8),
              Text(
                notification.message,
                style: context.bodySecondaryStyle.copyWith(
                  color: context.textSecondaryColor,
                  height: 1.45,
                ),
              ),
              const Gap(16),
              _DetailLine(label: t.receivedAt, value: date),
              if (notification.studentName != null)
                _DetailLine(label: t.student, value: notification.studentName!),
              if (notification.deepLink != null) ...[
                const Gap(12),
                MentorXButton(
                  label: t.openLink,
                  onPressed: () async {
                    final uri = Uri.tryParse(notification.deepLink!);
                    if (uri == null) return;
                    await launchUrl(uri, mode: LaunchMode.externalApplication);
                  },
                ),
              ],
            ],
          ),
        ),
      );
    },
  );
}

final class _DetailLine extends StatelessWidget {
  final String label;
  final String value;

  const _DetailLine({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: context.smallTextStyle.copyWith(
                color: context.textTertiaryColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const Gap(12),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: context.smallTextStyle.copyWith(
                color: context.textPrimaryColor,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
