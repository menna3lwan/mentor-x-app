import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

final class SectionHeaderWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;

  const SectionHeaderWidget({
    super.key,
    required this.title,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: palette.textPrimary,
            ),
          ),
        ),
        if (onSeeAll != null)
          TextButton(
            onPressed: onSeeAll,
            child: Text(
              context.t.ui.common.viewAll,
              style: TextStyle(color: palette.brandPrimary),
            ),
          ),
      ],
    );
  }
}
