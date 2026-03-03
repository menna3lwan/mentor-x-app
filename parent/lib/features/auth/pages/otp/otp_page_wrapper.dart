import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:go_router/go_router.dart';
import 'package:parent/core/core.dart';
import 'package:parent/widgets/clickable_text_widget.dart';
import 'package:parent/widgets/matrial_button_widget.dart';
import 'package:parent/features/features.dart';
import 'bloc/otp_bloc.dart';
import 'otp_page.dart';

final class OtpPageWrapper extends StatefulWidget {
  final String phone;

  const OtpPageWrapper({super.key, required this.phone});

  @override
  State<OtpPageWrapper> createState() => _OtpPageWrapperState();
}

class _OtpPageWrapperState extends State<OtpPageWrapper> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    for (var node in focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void moveToNext(int index, String value) {
    if (value.length == 1 && index < 5) {
      focusNodes[index + 1].requestFocus();
    }
    if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocPresentationListener<OtpBloc, OtpPresentationEvent>(
      listener: (context, event) {
        if (event is OtpSuccessPresentationEvent) {
          const DashboardPageRoute().go(context);
        } else if (event is OtpFailurePresentationEvent) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content:
                    Text(event.exception.message ?? "Verification failed")),
          );
        }
      },
      child: BlocBuilder<OtpBloc, OtpState>(
        builder: (context, state) {
          return OtpPage(
            backButton: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.arrow_back, color: Color(0xFF183764)),
            ),
            title: const Text(
              "Verify Code",
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Color(0xFF183764),
              ),
            ),
            subtitle: const Text(
              "Enter the 6-digit code sent to your phone",
              style: TextStyle(color: Colors.grey),
            ),
            otpFields: Form(
              key: _formKey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(6, (index) {
                  return SizedBox(
                    width: 50,
                    child: TextFormField(
                      controller: controllers[index],
                      focusNode: focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      maxLength: 1,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF183764),
                      ),
                      decoration: InputDecoration(
                        counterText: "",
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 20,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide(color: Colors.grey.shade400),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: const BorderSide(
                            color: Color(0xFF183764),
                            width: 2,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        moveToNext(index, value);
                      },
                    ),
                  );
                }),
              ),
            ),
            verifyButton: MatrialButTonWidget(
              onPressed: state is OtpLoading
                  ? null
                  : () {
                      String code = controllers.map((e) => e.text).join();
                      if (code.length == 6) {
                        context.read<OtpBloc>().add(
                              OtpSubmittedEvent(
                                phone: widget.phone,
                                code: code,
                              ),
                            );
                      }
                    },
              text: state is OtpLoading ? "Verifying..." : "Verify",
            ),
            resendButton: ClickableTextWidget(
              alignment: Alignment.center,
              color: const Color(0xFF183764),
              text: "Didn't receive the code ?",
              onPressed: () {},
            ),
          );
        },
      ),
    );
  }
}
