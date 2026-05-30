import 'package:device_info_service/device_info_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

final class AppServices {
  final DeviceInfoService deviceInfoService;

  const AppServices._({
    required this.deviceInfoService,
  });

  List<RepositoryProvider<Object>> toProviders() {
    return [
      RepositoryProvider<DeviceInfoService>(
        create: (_) => deviceInfoService,
      ),
    ];
  }
}

final class ServicesFactory {
  ServicesFactory._();

  static Future<AppServices> initServices() async {
    final deviceInfoService = DeviceInfoServiceImpl();
    // In a real app, you might call an initialize() method here if needed.

    return AppServices._(
      deviceInfoService: deviceInfoService,
    );
  }
}
