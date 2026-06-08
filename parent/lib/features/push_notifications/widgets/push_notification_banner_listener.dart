import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:push_notification_service/push_notification_service.dart';

import '../../../core/blocs/notifications_badge_cubit/notifications_badge_cubit.dart';
import '../bloc/push_notifications_cubit.dart';

/// Listens to push messages and surfaces them as Material banners.
///
/// Wrap any subtree of the app with this widget. It does two things on
/// each inbound message:
///   1. Bumps the [NotificationsBadgeCubit] counter so the bell icon in
///      the home AppBar updates.
///   2. Shows a non-blocking banner that the user can dismiss or tap to
///      open the related screen.
class PushNotificationBannerListener extends StatefulWidget {
  final Widget child;

  /// Optional callback invoked when the user taps a banner. Receives the
  /// raw [PushNotificationMessage] so the host can drive deeplink
  /// navigation. If null, banners are dismiss-only.
  final void Function(PushNotificationMessage message)? onTapMessage;

  const PushNotificationBannerListener({
    super.key,
    required this.child,
    this.onTapMessage,
  });

  @override
  State<PushNotificationBannerListener> createState() =>
      _PushNotificationBannerListenerState();
}

class _PushNotificationBannerListenerState
    extends State<PushNotificationBannerListener> {
  StreamSubscription<PushNotificationMessage>? _subscription;

  @override
  void initState() {
    super.initState();
    // Read the cubit once on mount. We then subscribe to its broadcast
    // stream and cancel in [dispose] — without this the listener leaks.
    final cubit = context.read<PushNotificationsCubit>();
    _subscription = cubit.messages.listen(_onMessage);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _onMessage(PushNotificationMessage message) {
    if (!mounted) return;
    // Bump the badge counter so the bell pill updates immediately.
    final badge = context.read<NotificationsBadgeCubit>();
    badge.setCount(badge.state.count + 1);
    _showBanner(message);
  }

  void _showBanner(PushNotificationMessage message) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.clearMaterialBanners();
    messenger.showMaterialBanner(
      MaterialBanner(
        backgroundColor: context.backgroundSecondaryColor,
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: context.brandPrimaryColor.withValues(alpha: 0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.notifications_active_rounded,
            color: context.brandPrimaryColor,
            size: 20,
          ),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: context.textPrimaryColor,
                fontWeight: FontWeight.w900,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              message.body,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: context.textSecondaryColor,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ],
        ),
        actions: [
          if (widget.onTapMessage != null)
            TextButton(
              onPressed: () {
                messenger.hideCurrentMaterialBanner();
                widget.onTapMessage!(message);
              },
              child: Text(
                Translations.of(context).parent.pushNotifications.bannerOpen,
                style: TextStyle(
                  color: context.brandPrimaryColor,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          TextButton(
            onPressed: messenger.hideCurrentMaterialBanner,
            child: Text(
              Translations.of(context).parent.pushNotifications.bannerDismiss,
              style: TextStyle(
                color: context.textSecondaryColor,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );

    // Auto-dismiss after 4s so the banner doesn't outlive its relevance.
    Future.delayed(const Duration(seconds: 4), () {
      if (!mounted) return;
      ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
    });
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
