import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:mentorx_student/core/core.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';
import 'bloc/notifications_page_bloc.dart';

final class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});
  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

final class _NotificationsPageState extends State<NotificationsPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      context.read<NotificationsPageBloc>().add(
        const NotificationsPageLoadMoreEvent(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;

    return Builder(
      builder: (context) {
        final notifications = context.select<NotificationsPageBloc, List<NotificationEntity>>(
          (bloc) => bloc.state.notifications,
        );
        final loadingState = context.select<NotificationsPageBloc, LoadingState>(
          (bloc) => bloc.state.loadingState,
        );
        final hasMore = context.select<NotificationsPageBloc, bool>(
          (bloc) => bloc.state.hasMore,
        );

        final isLoading = loadingState == LoadingState.loading;
        final isInitialLoading = isLoading && notifications.isEmpty;

        return Scaffold(
          backgroundColor: context.backgroundPrimaryColor,
          body: Stack(
            children: [
              const _BackgroundDecorations(),
              Column(
                children: [
                  _BuildHeader(
                    t: t,
                    hasNotifications: notifications.isNotEmpty,
                  ),
                  Expanded(
                    child: isInitialLoading
                        ? ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                            itemCount: 8,
                            itemBuilder: (_, _) => const Padding(
                              padding: EdgeInsets.only(bottom: 16),
                              child: MentorXSkeleton(height: 120, borderRadius: 28),
                            ),
                          )
                        : notifications.isEmpty
                            ? AppEmptyView(
                                title: t['noNotifications'] ?? 'No notifications yet',
                                message: t['noNotificationsDesc'] ?? "We'll notify you when something important happens.",
                                icon: Icons.notifications_off_rounded,
                              )
                            : RefreshIndicator(
                                color: context.brandPrimaryColor,
                                onRefresh: () async {
                                  context.read<NotificationsPageBloc>().add(
                                    const NotificationsPageLoadEvent(),
                                  );
                                },
                                child: ListView.builder(
                                  controller: _scrollController,
                                  physics: const BouncingScrollPhysics(),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 24,
                                  ),
                                  itemCount: notifications.length + (hasMore ? 1 : 0),
                                  itemBuilder: (context, i) {
                                    if (i == notifications.length) {
                                      return const Padding(
                                        padding: EdgeInsets.all(16.0),
                                        child: MentorXSkeleton(height: 60, borderRadius: 20),
                                      );
                                    }

                                    final notification = notifications[i];
                                    return FadeInUp(
                                      duration: const Duration(milliseconds: 500),
                                      delay: Duration(milliseconds: 50 * i),
                                      child: _NotificationItem(
                                        notification: notification,
                                        onTap: () {
                                          if (!notification.isRead) {
                                            context.read<NotificationsPageBloc>().add(
                                              NotificationsPageMarkAsReadEvent(
                                                notification.id,
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

final class _BuildHeader extends StatelessWidget {
  final dynamic t;
  final bool hasNotifications;

  const _BuildHeader({
    required this.t,
    required this.hasNotifications,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        24,
        MediaQuery.paddingOf(context).top + 16,
        16,
        24,
      ),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        border: Border(
          bottom: BorderSide(
            color: context.borderPrimaryColor.withValues(alpha: 0.1),
          ),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(32)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Row(
            children: [
              MentorXIconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icons.arrow_back_ios_new_rounded,
                color: context.textPrimaryColor,
              ),
              Expanded(
                child: Center(
                  child: Text(
                    t['notificationsTitle']!,
                    style: TextStyle(
                      color: context.textPrimaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
              ),
              if (hasNotifications)
                MentorXIconButton(
                  onPressed: () {
                    context.read<NotificationsPageBloc>().add(
                      const NotificationsPageMarkAllAsReadEvent(),
                    );
                  },
                  icon: Icons.done_all_rounded,
                  color: context.brandPrimaryColor,
                  tooltip: t['markAllRead'],
                )
              else
                const Gap(48),
            ],
          ),
        ),
      ),
    );
  }
}

final class _NotificationItem extends StatelessWidget {
  final NotificationEntity notification;
  final VoidCallback onTap;

  const _NotificationItem({
    required this.notification,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isUnread = !notification.isRead;
    final color = _getNotificationColor(context, notification.type);
    final icon = _getNotificationIcon(notification.type);
    final formattedDate = DateFormat(
      'dd MMM yyyy, hh:mm a',
    ).format(notification.createdAt);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: isUnread
                ? context.brandPrimaryColor.withValues(alpha: 0.2)
                : context.borderPrimaryColor.withValues(alpha: 0.1),
            width: isUnread ? 1.5 : 1.0,
          ),
          boxShadow: [
            BoxShadow(
              color: isUnread 
                  ? context.brandPrimaryColor.withValues(alpha: 0.05)
                  : Colors.black.withValues(alpha: 0.05),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              color.withValues(alpha: 0.2),
                              color.withValues(alpha: 0.05),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: color.withValues(alpha: 0.1),
                          ),
                        ),
                        child: Icon(icon, size: 24, color: color),
                      ),
                      const Gap(16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    notification.title,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900,
                                      color: isUnread
                                          ? context.brandPrimaryColor
                                          : context.textPrimaryColor,
                                      letterSpacing: -0.3,
                                    ),
                                  ),
                                ),
                                if (isUnread)
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: context.brandSecondaryColor,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: context.brandSecondaryColor.withValues(
                                            alpha: 0.4,
                                          ),
                                          blurRadius: 4,
                                        ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                            const Gap(6),
                            Text(
                              notification.message,
                              style: TextStyle(
                                fontSize: 14,
                                color: context.textSecondaryColor,
                                height: 1.5,
                                fontWeight: isUnread
                                    ? FontWeight.w700
                                    : FontWeight.w600,
                              ),
                            ),
                            const Gap(16),
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time_rounded,
                                  size: 14,
                                  color: context.textTertiaryColor,
                                ),
                                const Gap(6),
                                Text(
                                  formattedDate,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: context.textTertiaryColor,
                                    fontWeight: FontWeight.w800,
                                  ),
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
        ),
      ),
    );
  }

  Color _getNotificationColor(
    BuildContext context,
    NotificationType type,
  ) {
    switch (type) {
      case NotificationType.quiz:
        return context.brandSecondaryColor;
      case NotificationType.announcement:
        return context.brandPrimaryColor;
      case NotificationType.success:
        return context.statusSuccessColor;
      case NotificationType.system:
        return Colors.blueAccent;
      case NotificationType.error:
        return context.statusDangerColor;
      default:
        return context.brandPrimaryColor;
    }
  }

  IconData _getNotificationIcon(NotificationType type) {
    switch (type) {
      case NotificationType.quiz:
        return Icons.quiz_rounded;
      case NotificationType.announcement:
        return Icons.campaign_rounded;
      case NotificationType.system:
        return Icons.settings_suggest_rounded;
      case NotificationType.success:
        return Icons.check_circle_rounded;
      case NotificationType.error:
        return Icons.error_rounded;
      default:
        return Icons.notifications_rounded;
    }
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
