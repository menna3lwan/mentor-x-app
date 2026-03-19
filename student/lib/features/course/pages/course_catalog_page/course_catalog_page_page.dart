import 'package:flutter/material.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

import 'bloc/course_catalog_page_bloc.dart';
import 'widgets/widgets.dart';

final class CourseCatalogPagePage extends StatelessWidget {
  final TextEditingController searchController;
  final List<CourseSummaryEntity> courses;
  final List<CategoryEntity> categories;
  final String? selectedCategoryId;
  final CatalogSortOption sortOption;
  final bool isLoading;
  final String? errorMessage;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String?> onCategoryChanged;
  final ValueChanged<CatalogSortOption> onSortChanged;
  final Future<void> Function() onRefresh;
  final ValueChanged<String> onCourseTap;

  const CourseCatalogPagePage({
    super.key,
    required this.searchController,
    required this.courses,
    required this.categories,
    required this.selectedCategoryId,
    required this.sortOption,
    required this.isLoading,
    required this.errorMessage,
    required this.onSearchChanged,
    required this.onCategoryChanged,
    required this.onSortChanged,
    required this.onRefresh,
    required this.onCourseTap,
  });

  @override
  Widget build(BuildContext context) {
    final palette = MentorXThemeColorPalette.light;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(context.t.course.courseCatalog),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: TextField(
                controller: searchController,
                onChanged: onSearchChanged,
                style: TextStyle(
                  color: palette.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: context.t.course.catalog.searchHint,
                  hintStyle: TextStyle(color: palette.textTertiary),
                  prefixIcon: Icon(Icons.search_rounded, color: palette.brandPrimary),
                  isDense: true,
                  filled: true,
                  fillColor: palette.backgroundPrimary,
                  contentPadding: const EdgeInsets.symmetric(vertical: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: palette.textTertiary.withOpacity(0.1)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: palette.brandPrimary.withOpacity(0.5), width: 1.5),
                  ),
                ),
              ),
            ),
          ),
          if (categories.isNotEmpty) ...[
            const SizedBox(height: 12),
            CategoryFilterChips(
              categories: categories,
              selectedCategoryId: selectedCategoryId,
              onCategoryChanged: onCategoryChanged,
            ),
          ],
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _SortDropdown(
                  sortOption: sortOption,
                  onChanged: onSortChanged,
                ),
              ],
            ),
          ),
          Expanded(
            child: _buildBody(context, palette),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, MentorXThemeColorPalette palette) {
    if (errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: palette.statusDanger),
            const SizedBox(height: 12),
            Text(
              errorMessage!,
              style: TextStyle(color: palette.statusDanger),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (courses.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: palette.textSecondary,
            ),
            const SizedBox(height: 16),
            Text(
              context.t.course.catalog.noCourses,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              context.t.course.catalog.noCoursesDescription,
              style: TextStyle(color: palette.textSecondary),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: GridView.builder(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.72,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return CatalogCourseCard(
            course: course,
            onTap: () => onCourseTap(course.id),
          );
        },
      ),
    );
  }
}

final class _SortDropdown extends StatelessWidget {
  final CatalogSortOption sortOption;
  final ValueChanged<CatalogSortOption> onChanged;

  const _SortDropdown({
    required this.sortOption,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<CatalogSortOption>(
      onSelected: onChanged,
      initialValue: sortOption,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.sort, size: 18),
          const SizedBox(width: 4),
          Text(
            context.t.course.catalog.sortBy,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: CatalogSortOption.newest,
          child: Text(context.t.course.catalog.sortNewest),
        ),
        PopupMenuItem(
          value: CatalogSortOption.priceAsc,
          child: Text(context.t.course.catalog.sortPriceAsc),
        ),
        PopupMenuItem(
          value: CatalogSortOption.priceDesc,
          child: Text(context.t.course.catalog.sortPriceDesc),
        ),
        PopupMenuItem(
          value: CatalogSortOption.popular,
          child: Text(context.t.course.catalog.sortPopular),
        ),
      ],
    );
  }
}
