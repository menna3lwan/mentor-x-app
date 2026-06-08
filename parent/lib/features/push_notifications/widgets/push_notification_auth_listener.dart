import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';

import '../../../core/blocs/app_authentication_cubit/app_authentication_cubit.dart';
import '../../../core/utils/parent_cache_keys.dart';
import '../bloc/push_notifications_cubit.dart';

/// Bridges the authentication lifecycle to the push-notification service.
///
/// - When the user signs in, the listener checks the persisted push
///   preference and, if enabled, asks the cubit to (re)register a token.
/// - When the user signs out, it unregisters so the device stops
///   receiving notifications for the now-departed account.
///
/// Sits high in the widget tree (inside `ParentApp`) so it sees every
/// auth transition.
class PushNotificationAuthListener extends StatelessWidget {
  final Widget child;

  const PushNotificationAuthListener({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppAuthenticationCubit, AppAuthenticationState>(
      // Only react to true sign-in / sign-out transitions, not avatar
      // changes or profile edits that re-emit the cubit.
      listenWhen: (previous, current) =>
          (previous.user == null) != (current.user == null),
      listener: (context, state) async {
        final push = context.read<PushNotificationsCubit>();
        if (state.user != null) {
          final cache = context.read<CacheRepository>();
          final raw = await cache.get(
            ParentCacheKeys.pushNotificationsEnabled,
          );
          // Mirror SettingsCubit's hydration default (true) so first-time
          // sign-ins register a token unless the user explicitly turned
          // them off in a previous session.
          final wantPush = raw == null ? true : raw.toLowerCase() == 'true';
          if (wantPush) {
            await push.enable();
          }
        } else {
          await push.disable();
        }
      },
      child: child,
    );
  }
}
