import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:animate_do/animate_do.dart';
import 'package:gap/gap.dart';

import 'bloc/course_catalog_page_bloc.dart';
import 'widgets/widgets.dart';

final class CourseCatalogPagePage extends StatelessWidget {
  final TextEditingController searchController;
  final List<CourseSummaryEntity> courses;
  final List<GradeEntity> grades;
  final List<CategoryEntity> categories;
  final String? selectedGradeId;
  final String? selectedCategoryId;
  final CatalogSortOption sortOption;
  final bool isLoading;
  final String? errorMessage;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<String?> onGradeChanged;
  final ValueChanged<String?> onCategoryChanged;
  final ValueChanged<CatalogSortOption> onSortChanged;
  final Future<void> Function() onRefresh;
  final ValueChanged<String> onCourseTap;

  const CourseCatalogPagePage({
    super.key,
    required this.searchController,
    required this.courses,
    required this.grades,
    required this.categories,
    required this.selectedGradeId,
    required this.selectedCategoryId,
    required this.sortOption,
    required this.isLoading,
    required this.errorMessage,
    required this.onSearchChanged,
    required this.onGradeChanged,
    required this.onCategoryChanged,
    required this.onSortChanged,
    required this.onRefresh,
    required this.onCourseTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.backgroundPrimaryColor,
      body: Stack(
        children: [
          const _BackgroundDecorations(),
          Positioned.fill(child: _buildContent(context)),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: [
        Gap(MediaQuery.paddingOf(context).top + 20),
        _buildHeader(context),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: FadeInDown(
            duration: const Duration(milliseconds: 600),
            child: _SearchBar(
              controller: searchController,
              onChanged: onSearchChanged,
              t: context.t.student,
            ),
          ),
        ),
        if (grades.isNotEmpty) ...[
          const Gap(24),
          FadeInUp(
            duration: const Duration(milliseconds: 600),
            delay: const Duration(milliseconds: 200),
            child: LevelFilterChips(
              grades: grades,
              selectedGradeId: selectedGradeId,
              onGradeChanged: onGradeChanged,
            ),
          ),
        ],
        if (categories.isNotEmpty) ...[
          const Gap(20),
          FadeInUp(
            duration: const Duration(milliseconds: 600),
            delay: const Duration(milliseconds: 300),
            child: CategoryFilterChips(
              categories: categories,
              selectedCategoryId: selectedCategoryId,
              onCategoryChanged: onCategoryChanged,
            ),
          ),
        ],
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 12),
          child: Row(
            children: [
              Text(
                context.t.course.catalog.coursesFound(count: courses.length),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: context.textPrimaryColor.withValues(alpha: 0.5),
                  letterSpacing: -0.2,
                ),
              ),
              const Spacer(),
              _SortDropdown(
                sortOption: sortOption,
                onChanged: onSortChanged,
              ),
            ],
          ),
        ),
        Expanded(
          child: _buildBody(context),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: context.borderPrimaryColor.withValues(alpha: 0.1),
              ),
            ),
            child: MentorXIconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icons.arrow_back_ios_new_rounded,
              color: context.textPrimaryColor,
              size: MentorXIconButtonSize.small,
            ),
          ),
          const Gap(20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FadeInLeft(
                  duration: const Duration(milliseconds: 600),
                  child: Text(
                    'ACADEMY',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: context.brandPrimaryColor,
                      letterSpacing: 2.0,
                    ),
                  ),
                ),
                const Gap(4),
                FadeInLeft(
                  duration: const Duration(milliseconds: 800),
                  delay: const Duration(milliseconds: 100),
                  child: Text(
                    context.t.course.courseCatalog,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w900,
                      color: context.textPrimaryColor,
                      letterSpacing: -0.8,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (errorMessage != null) {
      return AppErrorView(
        message: errorMessage!,
        onRetry: onRefresh,
      );
    }

    if (isLoading) {
      return GridView.builder(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.72,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: 6,
        itemBuilder: (context, index) => const MentorXSkeleton(
          borderRadius: 20,
        ),
      );
    }

    if (courses.isEmpty) {
      return AppEmptyView(
        title: context.t.course.catalog.noCourses,
        message: context.t.course.catalog.noCoursesDescription,
        icon: Icons.search_off_rounded,
      );
    }

    return RefreshIndicator(
      color: context.brandPrimaryColor,
      onRefresh: onRefresh,
      child: GridView.builder(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.72,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return FadeInUp(
            duration: const Duration(milliseconds: 500),
            delay: Duration(milliseconds: 50 * index),
            child: CatalogCourseCard(
              course: course,
              onTap: () => onCourseTap(course.id),
            ),
          );
        },
      ),
    );
  }
}

class _BackgroundDecorations extends StatelessWidget {
  const _BackgroundDecorations();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -100,
          right: -50,
          child: _BlurredBlob(
            color: context.brandPrimaryColor.withValues(alpha: 0.12),
            size: 350,
          ),
        ),
        Positioned(
          top: 300,
          left: -150,
          child: _BlurredBlob(
            color: context.brandSecondaryColor.withValues(alpha: 0.08),
            size: 400,
          ),
        ),
        Positioned(
          bottom: -50,
          right: -100,
          child: _BlurredBlob(
            color: context.brandPrimaryColor.withValues(alpha: 0.1),
            size: 300,
          ),
        ),
      ],
    );
  }
}

class _BlurredBlob extends StatelessWidget {
  final Color color;
  final double size;

  const _BlurredBlob({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 70, sigmaY: 70),
        child: const SizedBox.expand(),
      ),
    );
  }
}

final class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final dynamic t;

  const _SearchBar({
    required this.controller,
    required this.onChanged,
    required this.t,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.backgroundSecondaryColor.withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: context.borderPrimaryColor.withValues(alpha: 0.1),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: TextField(
            controller: controller,
            onChanged: onChanged,
            style: TextStyle(
              color: context.textPrimaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
            decoration: InputDecoration(
              hintText: context.t.course.catalog.searchHint,
              hintStyle: TextStyle(
                color: context.textPrimaryColor.withValues(alpha: 0.3),
                fontWeight: FontWeight.w600,
              ),
              prefixIcon: Icon(
                Icons.search_rounded,
                color: context.brandPrimaryColor,
                size: 22,
              ),
              filled: true,
              fillColor: Colors.transparent,
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(22),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
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
      color: context.backgroundSecondaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: context.borderPrimaryColor.withValues(alpha: 0.05),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: context.brandPrimaryColor.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.sort_rounded,
              size: 16,
              color: context.brandPrimaryColor,
            ),
            const Gap(6),
            Text(
              context.t.course.catalog.sortBy,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w900,
                color: context.brandPrimaryColor,
              ),
            ),
          ],
        ),
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          value: CatalogSortOption.newest,
          child: Text(
            context.t.course.catalog.sortNewest,
            style: TextStyle(
              color: context.textPrimaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        PopupMenuItem(
          value: CatalogSortOption.priceAsc,
          child: Text(
            context.t.course.catalog.sortPriceAsc,
            style: TextStyle(
              color: context.textPrimaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        PopupMenuItem(
          value: CatalogSortOption.priceDesc,
          child: Text(
            context.t.course.catalog.sortPriceDesc,
            style: TextStyle(
              color: context.textPrimaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        PopupMenuItem(
          value: CatalogSortOption.popular,
          child: Text(
            context.t.course.catalog.sortPopular,
            style: TextStyle(
              color: context.textPrimaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

