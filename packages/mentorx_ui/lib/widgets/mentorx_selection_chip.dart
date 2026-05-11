part of '../mentorx_ui.dart';

class MentorXSelectionChip extends StatelessWidget {
  const MentorXSelectionChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onSelected,
    this.icon,
  });

  final String label;
  final bool isSelected;
  final ValueChanged<bool> onSelected;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return PressableBox(
      onPress: () => onSelected(!isSelected),
      style: Style(
        $box.padding.vertical(8),
        $box.padding.horizontal(16),
        $box.borderRadius(12),
        $box.color(
          isSelected
              ? context.brandPrimaryColor
              : context.backgroundSecondaryColor,
        ),
        $box.border.all.color(
          isSelected
              ? context.brandPrimaryColor
              : context.borderPrimaryColor.withValues(alpha: 0.1),
        ),
        $box.border.all.width(1.5),
        $on.hover(
          $box.color(
            isSelected
                ? context.brandPrimaryColor.withValues(alpha: 0.9)
                : context.backgroundTertiaryColor.withValues(alpha: 0.5),
          ),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 16,
              color: isSelected ? Colors.white : context.textSecondaryColor,
            ),
            const Gap(8),
          ],
          Text(
            label,
            style: context.smallTextStyle.copyWith(
              color: isSelected ? Colors.white : context.textPrimaryColor,
              fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class MentorXSelectionChipGroup<T> extends StatelessWidget {
  const MentorXSelectionChipGroup({
    super.key,
    required this.items,
    required this.labelBuilder,
    required this.selectedValue,
    required this.onSelected,
    this.iconBuilder,
    this.spacing = 8,
    this.runSpacing = 8,
  });

  final List<T> items;
  final String Function(T item) labelBuilder;
  final T? selectedValue;
  final ValueChanged<T> onSelected;
  final IconData? Function(T item)? iconBuilder;
  final double spacing;
  final double runSpacing;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: spacing,
      runSpacing: runSpacing,
      children: items.map((item) {
        return MentorXSelectionChip(
          label: labelBuilder(item),
          isSelected: item == selectedValue,
          onSelected: (_) => onSelected(item),
          icon: iconBuilder?.call(item),
        );
      }).toList(),
    );
  }
}
