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
      backgroundColor: palette.backgroundSecondary,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                palette.brandPrimary,
                palette.brandPrimary.withOpacity(0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(24),
            ),
            boxShadow: [
              BoxShadow(
                color: palette.brandPrimary.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            foregroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              context.t.course.courseCatalog,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _SearchBar(
              controller: searchController,
              onChanged: onSearchChanged,
              palette: palette,
              t: context.t.student,
            ),
          ),
          if (categories.isNotEmpty) ...[
            const SizedBox(height: 20),
            CategoryFilterChips(
              categories: categories,
              selectedCategoryId: selectedCategoryId,
              onCategoryChanged: onCategoryChanged,
            ),
          ],
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
            child: Row(
              children: [
                Text(
                  '${courses.length} Courses Found',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: palette.textSecondary,
                  ),
                ),
                const Spacer(),
                _SortDropdown(
                  sortOption: sortOption,
                  onChanged: onSortChanged,
                  palette: palette,
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
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline_rounded,
                size: 64,
                color: Colors.red.withOpacity(0.3),
              ),
              const SizedBox(height: 24),
              Text(
                errorMessage!,
                style: TextStyle(
                  color: palette.textSecondary,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (courses.isEmpty) {
      return _EmptyCatalog(palette: palette, t: context.t.student);
    }

    return RefreshIndicator(
      color: palette.brandPrimary,
      onRefresh: onRefresh,
      child: GridView.builder(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.72,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
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

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final MentorXThemeColorPalette palette;
  final dynamic t;

  const _SearchBar({
    required this.controller,
    required this.onChanged,
    required this.palette,
    required this.t,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: TextStyle(
          color: palette.textPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          hintText: context.t.course.catalog.searchHint,
          hintStyle: TextStyle(
            color: palette.textTertiary,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: palette.brandPrimary,
            size: 22,
          ),
          filled: true,
          fillColor: Colors.transparent,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

final class _SortDropdown extends StatelessWidget {
  final CatalogSortOption sortOption;
  final ValueChanged<CatalogSortOption> onChanged;
  final MentorXThemeColorPalette palette;

  const _SortDropdown({
    required this.sortOption,
    required this.onChanged,
    required this.palette,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<CatalogSortOption>(
      onSelected: onChanged,
      initialValue: sortOption,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: palette.brandPrimary.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.sort_rounded, size: 16, color: palette.brandPrimary),
            const SizedBox(width: 6),
            Text(
              context.t.course.catalog.sortBy,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: palette.brandPrimary,
              ),
            ),
          ],
        ),
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

class _EmptyCatalog extends StatelessWidget {
  final MentorXThemeColorPalette palette;
  final dynamic t;

  const _EmptyCatalog({required this.palette, required this.t});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: palette.backgroundPrimary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                ),
              ],
            ),
            child: Icon(
              Icons.search_off_rounded,
              size: 80,
              color: palette.textTertiary.withOpacity(0.2),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            context.t.course.catalog.noCourses,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: palette.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            context.t.course.catalog.noCoursesDescription,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14, color: palette.textSecondary),
          ),
        ],
      ),
    );
  }
}
