import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/blocs/app_authentication_cubit/app_authentication_cubit.dart';
import '../../../core/routing/app_routes.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    _checkStatus();
  }

  Future<void> _checkStatus() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    final authState = context.read<AppAuthenticationCubit>().state;
    if (authState.isAuthenticated) {
      const HomePageRoute().go(context);
    } else {
      const LoginPageRoute().go(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.school_rounded, size: 100, color: Color(0xFF1E293B)),
            SizedBox(height: 24),
            CircularProgressIndicator(color: Color(0xFF1E293B)),
          ],
        ),
      ),
    );
  }
}
