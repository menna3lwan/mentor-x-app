import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:gap/gap.dart';

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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: context.textPrimaryColor,
              letterSpacing: -1.0,
              height: 1,
            ),
          ),
        ),
        if (onSeeAll != null)
          GestureDetector(
            onTap: onSeeAll,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: context.brandPrimaryColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    context.t.ui.common.viewAll,
                    style: TextStyle(
                      color: context.brandPrimaryColor,
                      fontWeight: FontWeight.w900,
                      fontSize: 12,
                      letterSpacing: -0.2,
                    ),
                  ),
                  const Gap(4),
                  Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 10,
                    color: context.brandPrimaryColor,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
