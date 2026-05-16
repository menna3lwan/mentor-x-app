part of '../mentorx_ui.dart';

class MentorXReadMoreText extends StatefulWidget {
  const MentorXReadMoreText(
    this.text, {
    super.key,
    this.trimLines = 3,
    this.color,
    this.textAlign,
  });

  final String text;
  final int trimLines;
  final Color? color;
  final TextAlign? textAlign;

  @override
  State<MentorXReadMoreText> createState() => _MentorXReadMoreTextState();
}

class _MentorXReadMoreTextState extends State<MentorXReadMoreText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final textStyle = context.bodySecondaryStyle.copyWith(
      color: widget.color ?? context.textPrimaryColor,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.text,
          style: textStyle,
          maxLines: _isExpanded ? null : widget.trimLines,
          overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
          textAlign: widget.textAlign,
        ),
        const Gap(4),
        GestureDetector(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              _isExpanded ? t_ui.common.readLess : t_ui.common.readMore,
              style: context.smallTextStyle.copyWith(
                color: context.brandPrimaryColor,
                fontWeight: FontWeight.w900,
                fontSize: 13,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
