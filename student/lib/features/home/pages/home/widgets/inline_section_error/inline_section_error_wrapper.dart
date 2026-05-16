import 'package:flutter/material.dart';

import 'inline_section_error_widget.dart';

final class InlineSectionError extends StatelessWidget {
  final VoidCallback onRetry;

  const InlineSectionError({
    super.key,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return InlineSectionErrorWidget(onRetry: onRetry);
  }
}
