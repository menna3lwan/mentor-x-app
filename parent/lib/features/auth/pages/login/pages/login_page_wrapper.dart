import 'package:device_info_service/device_info_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';
import '../bloc/login_bloc.dart';
import '../login_page.dart';

class LoginPageWrapper extends StatelessWidget {
  const LoginPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
        authenticationRepository: context.read<AuthenticationRepository<ParentEntity>>(),
        deviceInfoService: context.read<DeviceInfoService>(),
      ),
      child: const LoginPage(),
    );
  }
}
