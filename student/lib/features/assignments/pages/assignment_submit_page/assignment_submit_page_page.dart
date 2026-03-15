import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

class AssignmentSubmitPage extends StatefulWidget {
  const AssignmentSubmitPage({super.key});
  @override
  State<AssignmentSubmitPage> createState() => _AssignmentSubmitPageState();
}

class _AssignmentSubmitPageState extends State<AssignmentSubmitPage> {
  bool _fileUploaded = false;

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        title: Text(
          t['submitAssignment']!,
          style: const TextStyle(fontSize: 15),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => setState(() => _fileUploaded = true),
              child: Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: _fileUploaded ? AppColors.greenLight : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _fileUploaded
                        ? AppColors.green
                        : AppColors.greyLight,
                    width: 2,
                    strokeAlign: BorderSide.strokeAlignCenter,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _fileUploaded
                          ? Icons.check_circle
                          : Icons.cloud_upload_outlined,
                      size: 40,
                      color: _fileUploaded ? AppColors.green : AppColors.grey,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _fileUploaded
                          ? 'assignment_solution.pdf'
                          : t['uploadFile']!,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: _fileUploaded
                            ? AppColors.green
                            : AppColors.greyDark,
                      ),
                    ),
                    if (!_fileUploaded)
                      Text(
                        t['uploadHint']!,
                        style: TextStyle(fontSize: 11, color: AppColors.grey),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              t['notesOptional']!,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                hintText: t['notesHint']!,
                hintStyle: TextStyle(fontSize: 12, color: AppColors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColors.greyLight),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: AppColors.greyLight),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _fileUploaded
                    ? () {
                        context
                            .read<AppSessionCubit>()
                            .decrementPendingAssignment();
                        context.push('/assignment-result');
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(t['submitAssignment']!),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
