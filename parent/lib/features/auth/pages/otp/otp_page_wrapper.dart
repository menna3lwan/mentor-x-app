import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mentorx_core/mentorx_core.dart';
import '../../../../core/routing/app_routes.dart';

class OtpPageWrapper extends StatelessWidget {
  final String phoneNumber;
  const OtpPageWrapper({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OTP Verification')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('OTP for $phoneNumber'),
            ElevatedButton(
              onPressed: () async {
                final childrenRepo = context.read<ParentChildrenRepository>();
                try {
                  final children = await childrenRepo.getChildren();
                  if (!context.mounted) return;
                  if (children.isEmpty) {
                    const AddChildLinkRoute().go(context);
                  } else {
                    const HomePageRoute().go(context);
                  }
                } catch (e) {
                  // Handle error
                }
              },
              child: const Text('Verify OTP'),
            ),
          ],
        ),
      ),
    );
  }
}
