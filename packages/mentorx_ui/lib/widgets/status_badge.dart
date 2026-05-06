part of '../mentorx_ui.dart';

enum StatusBadgeType {
  success,
  warning,
  danger,
  info,
}

class StatusBadge extends StatelessWidget {
  const StatusBadge({
    super.key,
    this.label,
    this.color,
    this.message,
    this.status,
    this.useSolidColor = false,
    this.isSmall = false,
  }) : assert(
          (label != null && color != null) || (message != null && status != null),
          'Either (label and color) or (message and status) must be provided',
        );

  final String? label;
  final Color? color;
  final String? message;
  final StatusBadgeType? status;
  final bool useSolidColor;
  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    if (message != null) {
      return _buildAlert(context);
    }
    return _buildPill(context);
  }

  Widget _buildPill(BuildContext context) {
    final effectiveColor = color!;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? 8 : 10,
        vertical: isSmall ? 2 : 4,
      ),
      decoration: BoxDecoration(
        color: useSolidColor ? effectiveColor : effectiveColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
        border: useSolidColor ? null : Border.all(color: effectiveColor.withValues(alpha: 0.2)),
      ),
      child: Text(
        label!,
        style: TextStyle(
          color: useSolidColor ? Colors.white : effectiveColor,
          fontSize: isSmall ? 10 : 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  Widget _buildAlert(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;
    
    final Color effectiveColor = switch (status!) {
      StatusBadgeType.success => palette.statusSuccess,
      StatusBadgeType.warning => palette.statusWarning,
      StatusBadgeType.danger => palette.statusDanger,
      StatusBadgeType.info => palette.brandPrimary,
    };

    return Container(
      width: isSmall ? null : double.infinity,
      padding: EdgeInsets.all(isSmall ? 8 : 12),
      decoration: BoxDecoration(
        color: useSolidColor ? effectiveColor : effectiveColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(isSmall ? 8 : 12),
        border: Border.all(
          color: effectiveColor.withValues(alpha: useSolidColor ? 0 : 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            _getIcon(),
            color: useSolidColor ? Colors.white : effectiveColor,
            size: isSmall ? 16 : 20,
          ),
          SizedBox(width: isSmall ? 8 : 12),
          if (isSmall)
            _LinkifiedText(
              text: message!,
              style: TextStyle(
                color: useSolidColor ? Colors.white : effectiveColor,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            )
          else
            Expanded(
              child: _LinkifiedText(
                text: message!,
                style: TextStyle(
                  color: useSolidColor ? Colors.white : effectiveColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }

  IconData _getIcon() {
    return switch (status!) {
      StatusBadgeType.success => Icons.check_circle_outline_rounded,
      StatusBadgeType.warning => Icons.warning_amber_rounded,
      StatusBadgeType.danger => Icons.error_outline_rounded,
      StatusBadgeType.info => Icons.info_outline_rounded,
    };
  }
}

class _LinkifiedText extends StatefulWidget {
  final String text;
  final TextStyle style;

  const _LinkifiedText({required this.text, required this.style});

  @override
  State<_LinkifiedText> createState() => _LinkifiedTextState();
}

class _LinkifiedTextState extends State<_LinkifiedText> {
  final List<TapGestureRecognizer> _recognizers = [];

  void _disposeRecognizers() {
    for (final recognizer in _recognizers) {
      recognizer.dispose();
    }
    _recognizers.clear();
  }

  @override
  void dispose() {
    _disposeRecognizers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _disposeRecognizers();
    
    // Improved regex to better match international and local phone numbers
    final phoneRegex = RegExp(r'\+?\d{8,15}');
    final matches = phoneRegex.allMatches(widget.text);

    if (matches.isEmpty) {
      return Text(widget.text, style: widget.style);
    }

    final spans = <TextSpan>[];
    int lastIndex = 0;

    for (final match in matches) {
      if (match.start > lastIndex) {
        spans.add(TextSpan(text: widget.text.substring(lastIndex, match.start)));
      }

      final phoneNumber = match.group(0)!;
      final recognizer = TapGestureRecognizer()
        ..onTap = () async {
          final uri = Uri.parse('tel:$phoneNumber');
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri);
          }
        };
      _recognizers.add(recognizer);

      spans.add(
        TextSpan(
          text: phoneNumber,
          style: widget.style.copyWith(
            decoration: TextDecoration.underline,
            decorationColor: widget.style.color?.withValues(alpha: 0.5),
            fontWeight: FontWeight.w700,
          ),
          recognizer: recognizer,
        ),
      );

      lastIndex = match.end;
    }

    if (lastIndex < widget.text.length) {
      spans.add(TextSpan(text: widget.text.substring(lastIndex)));
    }

    return Text.rich(
      TextSpan(children: spans),
      style: widget.style,
    );
  }
}
