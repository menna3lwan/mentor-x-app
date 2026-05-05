import 'package:flutter/material.dart';
import 'package:bloc_presentation/bloc_presentation.dart';
import '../../../../core/core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'bloc/redeem_code_page_bloc.dart';

class RedeemCodePagePage extends StatefulWidget {
  final RedeemCodePageState state;
  final Function(String) onSubmit;

  const RedeemCodePagePage({
    super.key,
    required this.state,
    required this.onSubmit,
  });

  @override
  State<RedeemCodePagePage> createState() => _RedeemCodePagePageState();
}

class _RedeemCodePagePageState extends State<RedeemCodePagePage> {
  final _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final palette = MentorXThemeColorPalette.light;

    return BlocPresentationListener<
      RedeemCodePageBloc,
      RedeemCodePagePresentationEvent
    >(
      listener: (context, event) {
        if (event is RedeemCodePageNavigateBack) {
          MentorXUI.showToast(
            message: t['codeActivated'] ?? 'Code activated successfully!',
          );
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: palette.backgroundSecondary,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  palette.brandPrimary,
                  palette.brandPrimary.withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: palette.brandPrimary.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              foregroundColor: Colors.white,
              title: Text(
                t['redeemCode']!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 32),
              // Icon with glow
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: palette.brandPrimary.withOpacity(0.05),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: palette.brandPrimary.withOpacity(0.1),
                  ),
                ),
                child: Icon(
                  Icons.qr_code_scanner_rounded,
                  size: 56,
                  color: palette.brandPrimary,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                t['redeemCodeTitle'] ?? 'Redeem Your Code',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: palette.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                t['enterCodeDesc'] ??
                    'Enter the activation code to top up your wallet balance instantly.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: palette.textSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 40),
              // Glassmorphic Input
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: TextField(
                  controller: _codeController,
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 4,
                    color: palette.brandPrimary,
                  ),
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    hintText: 'XXXX-XXXX-XXXX',
                    hintStyle: TextStyle(
                      fontSize: 18,
                      color: palette.textTertiary.withOpacity(0.3),
                      letterSpacing: 4,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 20,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              if (widget.state.errorMessage != null) ...[
                const SizedBox(height: 16),
                StatusBadge(
                  message: widget.state.errorMessage!,
                  status: StatusBadgeType.danger,
                ),
              ],
              const SizedBox(height: 48),
              MentorXButton(
                onPressed:
                    _codeController.text.isNotEmpty &&
                        widget.state.loadingState != LoadingState.loading
                    ? () => widget.onSubmit(_codeController.text)
                    : null,
                text: t['activateCode']!,
                loading: widget.state.loadingState == LoadingState.loading,
              ),
              const SizedBox(height: 24),
              Text(
                t['redeemPolicy'] ??
                    'By activating this code, you agree to our terms and conditions.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 11, color: palette.textTertiary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
