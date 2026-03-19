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
      padding: const EdgeInsetsDirectional.only(end: 10),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? palette.brandPrimary
                : palette.backgroundSecondary,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected
                  ? palette.brandPrimary
                  : palette.textTertiary.withOpacity(0.1),
              width: 1.5,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: palette.brandPrimary.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: isSelected
                    ? palette.textForeground
                    : palette.textSecondary,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
