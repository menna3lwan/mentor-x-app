import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

/// Pure-layout edit-profile screen. All state and side effects live in the
/// matching `EditProfilePageWrapper`; this widget just renders.
///
/// Uses a plain [Scaffold] rather than [AppDashboardScaffold] so it can
/// expose its own back button (the rest of the app navigates with
/// `go_router.go(...)` and therefore never gets an auto back arrow).
class EditProfilePage extends StatelessWidget {
  final String title;
  final String fullNameLabel;
  final String fullNameHint;
  final String saveLabel;
  final String avatarChangeLabel;
  final String avatarUploadingLabel;
  final String? avatarUrl;
  final String? localAvatarPath;
  final TextEditingController nameController;
  final bool isSaving;
  final bool isUploadingAvatar;
  final String? Function(String? value) nameValidator;
  final VoidCallback onSavePressed;
  final VoidCallback onChangeAvatarPressed;
  final VoidCallback onBackPressed;

  const EditProfilePage({
    super.key,
    required this.title,
    required this.fullNameLabel,
    required this.fullNameHint,
    required this.saveLabel,
    required this.avatarChangeLabel,
    required this.avatarUploadingLabel,
    required this.nameController,
    required this.nameValidator,
    required this.onSavePressed,
    required this.onChangeAvatarPressed,
    required this.onBackPressed,
    this.isSaving = false,
    this.isUploadingAvatar = false,
    this.avatarUrl,
    this.localAvatarPath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          onPressed: onBackPressed,
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w800,
            color: context.brandPrimaryColor,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Avatar(
                  remoteUrl: avatarUrl,
                  localPath: localAvatarPath,
                  isUploading: isUploadingAvatar,
                  uploadingLabel: avatarUploadingLabel,
                  changeLabel: avatarChangeLabel,
                  onPressed: isUploadingAvatar ? null : onChangeAvatarPressed,
                ),
                const Gap(32),
                MentorXTextFormField(
                  controller: nameController,
                  label: fullNameLabel,
                  hintText: fullNameHint,
                  icon: Icons.person_rounded,
                  textInputAction: TextInputAction.done,
                  validator: nameValidator,
                  onFieldSubmitted: (_) => onSavePressed(),
                ),
                const Gap(32),
                MentorXButton(
                  onPressed: isSaving ? null : onSavePressed,
                  loading: isSaving,
                  label: saveLabel,
                ),
                const Gap(20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String? remoteUrl;
  final String? localPath;
  final bool isUploading;
  final String uploadingLabel;
  final String changeLabel;
  final VoidCallback? onPressed;

  const _Avatar({
    required this.isUploading,
    required this.uploadingLabel,
    required this.changeLabel,
    required this.onPressed,
    this.remoteUrl,
    this.localPath,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: context.brandPrimaryColor.withValues(alpha: 0.1),
                    width: 4,
                  ),
                ),
                child: CircleAvatar(
                  radius: 56,
                  backgroundColor: context.backgroundSecondaryColor,
                  backgroundImage: _resolveImage(),
                  child: _resolveImage() == null
                      ? Icon(
                          Icons.person_rounded,
                          size: 64,
                          color: context.brandPrimaryColor,
                        )
                      : null,
                ),
              ),
              if (isUploading)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black.withValues(alpha: 0.35),
                    ),
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 28,
                      height: 28,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: context.backgroundPrimaryColor,
                      ),
                    ),
                  ),
                ),
              if (!isUploading)
                Material(
                  color: context.brandPrimaryColor,
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: onPressed,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Icon(
                        Icons.camera_alt_rounded,
                        size: 18,
                        color: context.backgroundPrimaryColor,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const Gap(12),
          Text(
            isUploading ? uploadingLabel : changeLabel,
            style: TextStyle(
              color: context.textSecondaryColor,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  ImageProvider<Object>? _resolveImage() {
    final local = localPath;
    if (local != null && local.isNotEmpty) {
      return FileImage(File(local));
    }
    final remote = remoteUrl;
    if (remote != null && remote.isNotEmpty) {
      if (_looksLikeLocalPath(remote)) {
        return FileImage(File(remote));
      }
      return NetworkImage(remote);
    }
    return null;
  }

  bool _looksLikeLocalPath(String value) {
    return value.startsWith('/') ||
        value.startsWith('file://') ||
        RegExp(r'^[A-Za-z]:\\').hasMatch(value);
  }
}
