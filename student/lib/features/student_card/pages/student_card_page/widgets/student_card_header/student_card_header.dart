import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

final class StudentCardHeader extends StatelessWidget {
  final dynamic t;

  const StudentCardHeader({super.key, required this.t});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: context.backgroundPrimaryColor.withValues(alpha: 0.8),
      elevation: 0,
      centerTitle: true,
      leading: MentorXIconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icons.arrow_back_ios_new_rounded,
        color: context.textPrimaryColor,
      ),
      title: Text(
        'Student ID Card',
        style: TextStyle(
          color: context.textPrimaryColor,
          fontSize: 18,
          fontWeight: FontWeight.w900,
          letterSpacing: -0.5,
        ),
      ),
      flexibleSpace: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}
