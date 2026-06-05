import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import '../../../core/blocs/app_authentication_cubit/app_authentication_cubit.dart';
import '../../../core/routing/app_routes.dart';
import '../bloc/profile_bloc.dart';
import 'edit_profile_page.dart';

/// Hosts [ProfileBloc] lifecycle for the edit-profile screen, listens for
/// presentation events (save success/failure/unauthorized), and pipes user
/// input into the bloc.
class EditProfilePageWrapper extends StatelessWidget {
  const EditProfilePageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final initial = context.read<AppAuthenticationCubit>().state.user;
        return ProfileBloc(
          profileRepository: context.read<ParentProfileRepository>(),
          initialProfile: initial,
        )..add(const ProfileLoadRequested());
      },
      child: const _EditProfileView(),
    );
  }
}

class _EditProfileView extends StatefulWidget {
  const _EditProfileView();

  @override
  State<_EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends State<_EditProfileView> {
  final TextEditingController _nameController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();

  // Tracks the locally-picked avatar for an instant preview before the
  // upload completes; cleared once the bloc returns the new server URL.
  String? _localAvatarPath;

  bool _initialNameSet = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).parent;

    return BlocPresentationListener<ProfileBloc, ProfilePresentationEvent>(
      listener: _onPresentationEvent,
      child: BlocConsumer<ProfileBloc, ProfileState>(
        listenWhen: (prev, curr) =>
            prev.profile?.fullName != curr.profile?.fullName ||
            (!_initialNameSet && curr.profile != null),
        listener: (context, state) {
          // Seed the controller from the bloc only the first time profile
          // arrives; afterwards the user is in control of the text.
          if (!_initialNameSet && state.profile != null) {
            _nameController.text = state.draftName;
            _initialNameSet = true;
          }
        },
        buildWhen: (prev, curr) =>
            prev.loadStatus != curr.loadStatus ||
            prev.saveStatus != curr.saveStatus ||
            prev.avatarStatus != curr.avatarStatus ||
            prev.profile?.profileImageUrl != curr.profile?.profileImageUrl,
        builder: (context, state) {
          if (state.loadStatus == ProfileLoadStatus.loading &&
              state.profile == null) {
            return Scaffold(
              backgroundColor: context.backgroundPrimaryColor,
              appBar: AppBar(
                title: Text(t.profile.editTitle),
                backgroundColor: context.backgroundSecondaryColor,
                elevation: 0,
              ),
              body: const _EditingSkeleton(),
            );
          }

          if (state.loadStatus == ProfileLoadStatus.failure &&
              state.profile == null) {
            return Scaffold(
              backgroundColor: context.backgroundPrimaryColor,
              appBar: AppBar(
                title: Text(t.profile.editTitle),
                backgroundColor: context.backgroundSecondaryColor,
                elevation: 0,
              ),
              body: AppErrorView(
                message: t.profile.editLoadFailed,
                onRetry: () => context.read<ProfileBloc>().add(
                  const ProfileLoadRequested(),
                ),
              ),
            );
          }

          // Clear the local preview once the bloc's profile catches up with
          // the freshly-uploaded image (server URL or mock-path).
          if (state.avatarStatus == ProfileSaveStatus.success &&
              _localAvatarPath != null &&
              state.profile?.profileImageUrl != null) {
            _localAvatarPath = null;
          }

          return EditProfilePage(
            title: t.profile.editTitle,
            fullNameLabel: t.profile.editFullNameLabel,
            fullNameHint: t.profile.editFullNameHint,
            saveLabel: t.profile.editSaveAction,
            avatarChangeLabel: t.profile.avatarChangeAction,
            avatarUploadingLabel: t.profile.avatarUploading,
            avatarUrl: state.profile?.profileImageUrl,
            localAvatarPath: _localAvatarPath,
            nameController: _nameController,
            isSaving: state.isSaving,
            isUploadingAvatar: state.isUploadingAvatar,
            nameValidator: (value) {
              final trimmed = value?.trim() ?? '';
              if (trimmed.length < 4) {
                return t.profile.editFullNameTooShort;
              }
              return null;
            },
            onSavePressed: () {
              FocusScope.of(context).unfocus();
              context.read<ProfileBloc>().add(
                ProfileNameChanged(_nameController.text),
              );
              context.read<ProfileBloc>().add(
                const ProfileSaveRequested(),
              );
            },
            onChangeAvatarPressed: () => _showAvatarSheet(context, t),
            onBackPressed: () {
              context.read<ProfileBloc>().add(
                const ProfileEditCancelled(),
              );
              const ProfileRoute().go(context);
            },
          );
        },
      ),
    );
  }

  Future<void> _showAvatarSheet(
    BuildContext context,
    TranslationsParentEn t,
  ) async {
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      backgroundColor: context.backgroundSecondaryColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: ctx.textTertiaryColor.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const Gap(16),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: ctx.brandPrimaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.photo_library_rounded,
                      color: ctx.brandPrimaryColor,
                      size: 20,
                    ),
                  ),
                  title: Text(
                    t.profile.avatarPickFromGallery,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: ctx.textPrimaryColor,
                    ),
                  ),
                  onTap: () => Navigator.of(ctx).pop(ImageSource.gallery),
                ),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: ctx.brandPrimaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.camera_alt_rounded,
                      color: ctx.brandPrimaryColor,
                      size: 20,
                    ),
                  ),
                  title: Text(
                    t.profile.avatarTakePhoto,
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: ctx.textPrimaryColor,
                    ),
                  ),
                  onTap: () => Navigator.of(ctx).pop(ImageSource.camera),
                ),
              ],
            ),
          ),
        );
      },
    );

    if (source == null || !mounted) return;

    try {
      final picked = await _imagePicker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      if (picked == null || !mounted) return;
      setState(() => _localAvatarPath = picked.path);
      // ignore: use_build_context_synchronously
      context.read<ProfileBloc>().add(ProfileAvatarSelected(picked.path));
    } catch (e) {
      if (!mounted) return;
      MentorXUI.showToast(
        message: t.profile.avatarInvalidImage,
        isError: true,
      );
    }
  }

  void _onPresentationEvent(
    BuildContext context,
    ProfilePresentationEvent event,
  ) {
    final t = Translations.of(context).parent;
    switch (event) {
      case ProfileSavedPresentationEvent(:final user):
        // Update the auth cubit so every other screen sees the new data
        // immediately (the profile screen, dashboard header, etc.).
        context.read<AppAuthenticationCubit>().update(user);
        MentorXUI.showToast(
          message: t.profile.editSaveSuccess,
        );
      case ProfileFailurePresentationEvent(:final kind):
        MentorXUI.showToast(
          message: _messageFor(t, kind),
          isError: true,
        );
      case ProfileUnauthorizedPresentationEvent():
        context.read<AppAuthenticationCubit>().logout();
        const LoginPageRoute().go(context);
    }
  }

  String _messageFor(TranslationsParentEn t, ProfileFailureKind kind) {
    return switch (kind) {
      ProfileFailureKind.nameTooShort => t.profile.editFullNameTooShort,
      ProfileFailureKind.network => t.profile.editNetworkError,
      ProfileFailureKind.unauthorized => t.profile.editUnauthorized,
      ProfileFailureKind.invalidImage => t.profile.avatarInvalidImage,
      ProfileFailureKind.uploadFailed => t.profile.avatarUploadFailed,
      ProfileFailureKind.loadFailed => t.profile.editLoadFailed,
      ProfileFailureKind.saveFailed ||
      ProfileFailureKind.unknown => t.profile.editSaveFailed,
    };
  }
}

class _EditingSkeleton extends StatelessWidget {
  const _EditingSkeleton();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      children: const [
        Center(
          child: MentorXSkeleton(width: 124, height: 124, borderRadius: 62),
        ),
        SizedBox(height: 32),
        MentorXSkeleton(width: double.infinity, height: 56, borderRadius: 12),
        SizedBox(height: 32),
        MentorXSkeleton(width: double.infinity, height: 52, borderRadius: 12),
      ],
    );
  }
}
