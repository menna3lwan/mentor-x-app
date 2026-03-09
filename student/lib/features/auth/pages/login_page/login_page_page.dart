import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

final class LoginPagePage extends StatefulWidget {
  final bool isLoading;
  final String? errorMessage;
  final ValueChanged<String> onPhoneChanged;
  final VoidCallback onSubmit;

  const LoginPagePage({
    super.key,
    required this.isLoading,
    required this.errorMessage,
    required this.onPhoneChanged,
    required this.onSubmit,
  });

  @override
  State<LoginPagePage> createState() => _LoginPagePageState();
}

final class _LoginPagePageState extends State<LoginPagePage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    widget.onSubmit();
  }

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 48),
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: palette.brandPrimary,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Icon(
                        Icons.school_outlined,
                        color: palette.textForeground,
                        size: 34,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      context.t.login.header,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      context.t.login.subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: palette.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      textDirection: TextDirection.ltr,
                      textAlign: TextAlign.left,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(11),
                      ],
                      decoration: InputDecoration(
                        labelText: context.t.login.phoneNumber,
                        hintText: context.t.login.phoneHint,
                        prefixIcon: const Icon(Icons.phone_android),
                      ),
                      autofillHints: const [AutofillHints.telephoneNumber],
                      textInputAction: TextInputAction.done,
                      onChanged: widget.onPhoneChanged,
                      onFieldSubmitted: (_) => _handleSubmit(),
                      validator: (value) {
                        final input = value?.trim() ?? '';
                        if (input.isEmpty) {
                          return context.t.forms.required;
                        }
                        if (!input.startsWith('01') || input.length != 11) {
                          return context.t.login.phoneValidationError;
                        }
                        return null;
                      },
                    ),
                    if (widget.errorMessage != null) ...[
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: palette.statusDanger.withAlpha(20),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: palette.statusDanger.withAlpha(80),
                            width: 0.8,
                          ),
                        ),
                        child: Text(
                          widget.errorMessage!,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: palette.statusDanger),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: widget.isLoading ? null : _handleSubmit,
                        child: widget.isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(context.t.login.signIn),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
