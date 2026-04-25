import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

class ForgotPasswordPage extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController phoneController;
  final bool isLoading;
  final String? errorMessage;
  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? phoneValidator;
  final ValueChanged<String>? onPhoneChanged;
  final VoidCallback onSubmit;
  final VoidCallback onBack;

  const ForgotPasswordPage({
    super.key,
    required this.formKey,
    required this.phoneController,
    required this.isLoading,
    this.errorMessage,
    this.inputFormatters,
    this.phoneValidator,
    this.onPhoneChanged,
    required this.onSubmit,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;
    return Scaffold(
      backgroundColor: palette.backgroundPrimary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: palette.textPrimary),
          onPressed: onBack,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(40),
                Text(
                  'Forgot Password?',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: palette.textPrimary,
                      ),
                ),
                const Gap(12),
                Text(
                  'Enter your phone number and we will send you a code to reset your password.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: palette.textSecondary,
                      ),
                ),
                const Gap(40),
                if (errorMessage != null) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: palette.statusDanger.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: palette.statusDanger),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.error_outline, color: palette.statusDanger),
                        const Gap(12),
                        Expanded(
                          child: Text(
                            errorMessage!,
                            style: TextStyle(color: palette.statusDanger),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(24),
                ],
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: inputFormatters,
                  validator: phoneValidator,
                  onChanged: onPhoneChanged,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    hintText: '01xxxxxxxxx',
                    prefixIcon: Icon(Icons.phone_android_outlined),
                  ),
                ),
                const Gap(40),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: isLoading ? null : onSubmit,
                    child: isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : const Text('Send Reset Code'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
