import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../../../core/blocs/app_authentication_cubit/app_authentication_cubit.dart';
import '../../../core/routing/app_routes.dart';
import '../bloc/account_deletion_bloc.dart';

/// Account-deletion request form.
///
/// Composed of three guard-rails the user must satisfy before the danger
/// CTA enables:
/// 1. An "I understand this is permanent" checkbox.
/// 2. Typing the localized confirmation phrase verbatim.
/// 3. A final modal confirmation dialog on tap.
///
/// On success the wrapper logs the user out and bounces to `/login`.
class DeleteAccountPageWrapper extends StatelessWidget {
  const DeleteAccountPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;
    return BlocProvider(
      create: (context) => AccountDeletionBloc(
        repository: context.read<ParentAccountDeletionRepository>(),
        expectedPhrase: t.deleteAccount.confirmationPhrase,
      ),
      child: const _DeleteAccountView(),
    );
  }
}

class _DeleteAccountView extends StatefulWidget {
  const _DeleteAccountView();

  @override
  State<_DeleteAccountView> createState() => _DeleteAccountViewState();
}

class _DeleteAccountViewState extends State<_DeleteAccountView> {
  final _reasonController = TextEditingController();
  final _confirmationController = TextEditingController();

  @override
  void dispose() {
    _reasonController.dispose();
    _confirmationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;

    return BlocPresentationListener<
      AccountDeletionBloc,
      AccountDeletionPresentationEvent
    >(
      listener: (context, event) => _onEvent(context, t, event),
      child: Scaffold(
        backgroundColor: context.backgroundPrimaryColor,
        appBar: AppBar(
          backgroundColor: context.backgroundSecondaryColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: context.textPrimaryColor,
              size: 20,
            ),
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                const SettingsRoute().go(context);
              }
            },
          ),
          title: Text(
            t.deleteAccount.pageTitle,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: context.statusDangerColor,
            ),
          ),
        ),
        body: BlocBuilder<AccountDeletionBloc, AccountDeletionState>(
          builder: (context, state) => _body(context, state, t),
        ),
      ),
    );
  }

  Widget _body(
    BuildContext context,
    AccountDeletionState state,
    TranslationsParentEn t,
  ) {
    final danger = context.statusDangerColor;
    return ListView(
      physics: const BouncingScrollPhysics(
        parent: AlwaysScrollableScrollPhysics(),
      ),
      padding: const EdgeInsets.all(20),
      children: [
        _WarningBanner(t: t),
        const Gap(20),
        _BulletListCard(
          title: t.deleteAccount.consequencesTitle,
          bullets: [
            t.deleteAccount.consequence1,
            t.deleteAccount.consequence2,
            t.deleteAccount.consequence3,
            t.deleteAccount.consequence4,
          ],
        ),
        const Gap(20),
        _ReasonField(
          label: t.deleteAccount.reasonLabel,
          hint: t.deleteAccount.reasonHint,
          controller: _reasonController,
          onChanged: (v) => context.read<AccountDeletionBloc>().add(
            AccountDeletionReasonChanged(v),
          ),
        ),
        const Gap(20),
        CheckboxListTile(
          value: state.requestDataExport,
          onChanged: (v) => context.read<AccountDeletionBloc>().add(
            AccountDeletionDataExportToggled(v ?? false),
          ),
          activeColor: context.brandPrimaryColor,
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
          title: Text(
            t.deleteAccount.dataExportLabel,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: context.textPrimaryColor,
            ),
          ),
          subtitle: Text(
            t.deleteAccount.dataExportHint,
            style: TextStyle(
              color: context.textSecondaryColor,
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ),
        CheckboxListTile(
          value: state.acknowledgedPermanent,
          onChanged: (v) => context.read<AccountDeletionBloc>().add(
            AccountDeletionAcknowledgementToggled(v ?? false),
          ),
          activeColor: danger,
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
          title: Text(
            t.deleteAccount.acknowledgementLabel,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: context.textPrimaryColor,
            ),
          ),
        ),
        const Gap(12),
        Text(
          t.deleteAccount.confirmationPrompt(
            phrase: t.deleteAccount.confirmationPhrase,
          ),
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: context.textPrimaryColor,
          ),
        ),
        const Gap(8),
        TextField(
          controller: _confirmationController,
          onChanged: (v) => context.read<AccountDeletionBloc>().add(
            AccountDeletionConfirmationChanged(v),
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: context.backgroundSecondaryColor,
            hintText: t.deleteAccount.confirmationPhrase,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: context.borderSecondaryColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: context.borderSecondaryColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: danger, width: 2),
            ),
          ),
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: context.textPrimaryColor,
          ),
        ),
        const Gap(28),
        _DangerButton(
          enabled: state.canSubmit,
          loading: state.status.isSubmitting,
          label: t.deleteAccount.confirmAction,
          loadingLabel: t.deleteAccount.submitting,
          onPressed: () => _onSubmitTap(context, t),
        ),
        const Gap(10),
        SizedBox(
          width: double.infinity,
          child: TextButton(
            onPressed: state.status.isSubmitting
                ? null
                : () {
                    if (context.canPop()) {
                      context.pop();
                    } else {
                      const SettingsRoute().go(context);
                    }
                  },
            child: Text(
              t.deleteAccount.cancel,
              style: TextStyle(
                color: context.textSecondaryColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        const Gap(40),
      ],
    );
  }

  Future<void> _onSubmitTap(
    BuildContext context,
    TranslationsParentEn t,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: dialogContext.backgroundSecondaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          icon: Icon(
            Icons.warning_amber_rounded,
            color: dialogContext.statusDangerColor,
            size: 36,
          ),
          title: Text(
            t.deleteAccount.finalConfirmTitle,
            textAlign: TextAlign.center,
          ),
          content: Text(
            t.deleteAccount.finalConfirmMessage,
            textAlign: TextAlign.center,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: Text(t.deleteAccount.cancel),
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: dialogContext.statusDangerColor,
              ),
              onPressed: () => Navigator.of(dialogContext).pop(true),
              child: Text(t.deleteAccount.confirmAction),
            ),
          ],
        );
      },
    );
    if (confirmed != true || !context.mounted) return;
    context.read<AccountDeletionBloc>().add(const AccountDeletionSubmitted());
  }

  void _onEvent(
    BuildContext context,
    TranslationsParentEn t,
    AccountDeletionPresentationEvent event,
  ) {
    switch (event) {
      case AccountDeletionSucceededPresentationEvent():
        MentorXUI.showToast(message: t.deleteAccount.successMessage);
        // Log out the user — the backend has invalidated the session.
        context.read<AppAuthenticationCubit>().logout();
        const LoginPageRoute().go(context);
      case AccountDeletionFailedPresentationEvent(:final kind, :final message):
        MentorXUI.showToast(
          message: _messageFor(t, kind, message),
          isError: true,
        );
      case AccountDeletionUnauthorizedPresentationEvent():
        context.read<AppAuthenticationCubit>().logout();
        const LoginPageRoute().go(context);
    }
  }

  String _messageFor(
    TranslationsParentEn t,
    AccountDeletionFailureKind kind,
    String? message,
  ) {
    return switch (kind) {
      AccountDeletionFailureKind.validation => t.deleteAccount.validationError,
      AccountDeletionFailureKind.network => t.deleteAccount.networkError,
      AccountDeletionFailureKind.unauthorized =>
        t.deleteAccount.unauthorizedError,
      AccountDeletionFailureKind.unknown =>
        message ?? t.deleteAccount.unknownError,
    };
  }
}

// ──── Helper widgets ────────────────────────────────────────────────────────

class _WarningBanner extends StatelessWidget {
  final TranslationsParentEn t;
  const _WarningBanner({required this.t});

  @override
  Widget build(BuildContext context) {
    final danger = context.statusDangerColor;
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: danger.withValues(alpha: 0.08),
        border: Border.all(color: danger.withValues(alpha: 0.25)),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.warning_amber_rounded, color: danger),
          const Gap(10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.deleteAccount.warningTitle,
                  style: TextStyle(
                    color: danger,
                    fontWeight: FontWeight.w900,
                    fontSize: 14,
                  ),
                ),
                const Gap(6),
                Text(
                  t.deleteAccount.warningSubtitle,
                  style: TextStyle(
                    color: context.textPrimaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BulletListCard extends StatelessWidget {
  final String title;
  final List<String> bullets;
  const _BulletListCard({required this.title, required this.bullets});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: context.borderSecondaryColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: context.textPrimaryColor,
              fontWeight: FontWeight.w900,
              fontSize: 14,
            ),
          ),
          const Gap(8),
          for (final bullet in bullets) ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: context.statusDangerColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                const Gap(10),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Text(
                      bullet,
                      style: TextStyle(
                        color: context.textSecondaryColor,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _ReasonField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  const _ReasonField({
    required this.label,
    required this.hint,
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: context.textPrimaryColor,
            fontWeight: FontWeight.w800,
            fontSize: 13,
          ),
        ),
        const Gap(6),
        TextField(
          controller: controller,
          onChanged: onChanged,
          maxLines: 3,
          maxLength: 280,
          decoration: InputDecoration(
            filled: true,
            fillColor: context.backgroundSecondaryColor,
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: context.borderSecondaryColor),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: context.borderSecondaryColor),
            ),
          ),
        ),
      ],
    );
  }
}

class _DangerButton extends StatelessWidget {
  final bool enabled;
  final bool loading;
  final String label;
  final String loadingLabel;
  final VoidCallback onPressed;

  const _DangerButton({
    required this.enabled,
    required this.loading,
    required this.label,
    required this.loadingLabel,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final danger = context.statusDangerColor;
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: enabled && !loading ? onPressed : null,
        icon: loading
            ? SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: context.backgroundSecondaryColor,
                ),
              )
            : Icon(
                Icons.delete_forever_rounded,
                color: enabled
                    ? context.backgroundSecondaryColor
                    : context.textTertiaryColor,
              ),
        label: Text(
          loading ? loadingLabel : label,
          style: TextStyle(
            color: enabled
                ? context.backgroundSecondaryColor
                : context.textTertiaryColor,
            fontWeight: FontWeight.w800,
            fontSize: 14,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: danger,
          disabledBackgroundColor: danger.withValues(alpha: 0.30),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: const EdgeInsets.symmetric(vertical: 14),
        ),
      ),
    );
  }
}
