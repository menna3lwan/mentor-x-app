import 'package:device_info_service/device_info_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  static Future<AppServices> initServices() async {
    final deviceInfoService = DeviceInfoServiceImpl();

    // Push notifications: we expose the abstract [PushNotificationService]
    // and bind it to [MockPushNotificationService] today. When the real
    // Firebase implementation lands, only this line changes.
    final pushNotificationService = MockPushNotificationService();
    await pushNotificationService.initialize();

    return AppServices._(
      deviceInfoService: deviceInfoService,
      pushNotificationService: pushNotificationService,
    );
  }
}
