import 'package:flutter/material.dart';

import 'section_header_widget.dart';

final class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;

  const SectionHeader({
    super.key,
    required this.title,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return SectionHeaderWidget(title: title, onSeeAll: onSeeAll);
  }
}
