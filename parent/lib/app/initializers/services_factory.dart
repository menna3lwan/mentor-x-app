import 'package:device_info_service/device_info_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:push_notification_service/push_notification_service.dart';

final class AppServices {
  final DeviceInfoService deviceInfoService;
  final PushNotificationService pushNotificationService;

  const AppServices._({
    required this.deviceInfoService,
    required this.pushNotificationService,
  });

  List<RepositoryProvider<Object>> toProviders() {
    return [
      RepositoryProvider<DeviceInfoService>(
        create: (_) => deviceInfoService,
      ),
      RepositoryProvider<PushNotificationService>(
        create: (_) => pushNotificationService,
      ),
    ];
  }
}

final class ServicesFactory {
  ServicesFactory._();

  static final _logger = MentorXLogger('ServicesFactory');

  static Future<AppServices> initServices() async {
    final deviceInfoService = DeviceInfoServiceImpl();

    PushNotificationService pushNotificationService;
    try {
      final firebase = FirebasePushNotificationService();
      await firebase.initialize();
      pushNotificationService = firebase;
    } catch (e, s) {
      // Firebase is not configured (missing GoogleService-Info.plist or
      // firebase_options.dart placeholders). Fall back to a no-op service so
      // the rest of the app starts normally. Push notifications will be
      // unavailable until Firebase is properly configured.
      _logger.warning('Firebase push service init failed, using no-op: $e');
      _logger.error('Firebase push service init failed', e, s);
      pushNotificationService = MockPushNotificationService();
    }

    return AppServices._(
      deviceInfoService: deviceInfoService,
      pushNotificationService: pushNotificationService,
    );
  }
}
