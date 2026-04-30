import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'bloc/verify_identity_bloc.dart';
import 'verify_identity_page_page.dart';

class VerifyIdentityPageWrapper extends StatefulWidget {
  const VerifyIdentityPageWrapper({super.key});

  @override
  State<VerifyIdentityPageWrapper> createState() => _VerifyIdentityPageWrapperState();
}

class _VerifyIdentityPageWrapperState extends State<VerifyIdentityPageWrapper> {
  String? _selectedImagePath;
  final _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 70,
    );
    if (image != null) {
      setState(() => _selectedImagePath = image.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;

    return BlocConsumer<VerifyIdentityBloc, VerifyIdentityState>(
      listener: (context, state) {
        if (state.status == VerifyIdentityStatus.success) {
          MentorXUI.showToast(
            message: t['verificationSubmitted'] ?? 'Verification submitted successfully!',
          );
          Navigator.pop(context);
        }
        if (state.status == VerifyIdentityStatus.error) {
          MentorXUI.showToast(
            message: state.errorMessage ?? 'Verification failed',
          );
        }
      },
      builder: (context, state) {
        return VerifyIdentityPagePage(
          selectedImagePath: _selectedImagePath,
          onPickImage: _pickImage,
          onSubmit: () {
            if (_selectedImagePath != null) {
              context.read<VerifyIdentityBloc>().add(VerifyIdentitySubmit(_selectedImagePath!));
            }
          },
          state: state,
        );
      },
    );
  }
}
