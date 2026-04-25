import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import '../bloc/student_registration_bloc.dart';

class OtpStep extends StatelessWidget {
  const OtpStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentRegistrationBloc, StudentRegistrationState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(
              Icons.mark_email_read_outlined,
              size: 64,
              color: Colors.blue,
            ),
            const SizedBox(height: 24),
            const Text(
              'Verification Code',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Sent to ${state.phone}',
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 32),
            Pinput(
              length: 6,
              onChanged: (v) => context.read<StudentRegistrationBloc>().add(
                    StudentRegistrationOtpChanged(v),
                  ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Didn\'t receive a code? '),
                TextButton(
                  onPressed: () => context.read<StudentRegistrationBloc>().add(
                        const StudentRegistrationResendOtpRequested(),
                      ),
                  child: const Text('Resend'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
