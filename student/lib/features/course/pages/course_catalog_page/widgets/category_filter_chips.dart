import 'package:flutter/material.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

final class CategoryFilterChips extends StatelessWidget {
  final List<CategoryEntity> categories;
  final String? selectedCategoryId;
  final ValueChanged<String?> onCategoryChanged;

  const CategoryFilterChips({
    super.key,
    required this.categories,
    required this.selectedCategoryId,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;

    return SizedBox(
      height: 38,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _buildChip(
            context: context,
            palette: palette,
            label: context.t.course.catalog.allCategories,
            isSelected: selectedCategoryId == null,
            onTap: () => onCategoryChanged(null),
          ),
          ...categories.map(
            (category) => _buildChip(
              context: context,
              palette: palette,
              label: category.name,
              isSelected: category.id == selectedCategoryId,
              onTap: () => onCategoryChanged(category.id),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip({
    required BuildContext context,
    required MentorXThemeColorPalette palette,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 8),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? palette.brandPrimary
                : palette.backgroundSecondary,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: isSelected ? palette.textForeground : palette.textPrimary,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
