part of 'courses_bloc.dart';

final class CoursesState extends Equatable {
  final bool isLoading;
  final List<ParentCourseProgress> courses;
  final String? selectedCourseId;
  final String? errorMessage;

  const CoursesState({
    this.isLoading = false,
    this.courses = const [],
    this.selectedCourseId,
    this.errorMessage,
  });

  ParentCourseProgress? get selectedCourse {
    if (selectedCourseId == null) {
      return null;
    }
    for (final item in courses) {
      if (item.id == selectedCourseId) {
        return item;
      }
    }
    return null;
  }

  CoursesState copyWith({
    bool? isLoading,
    List<ParentCourseProgress>? courses,
    String? selectedCourseId,
    String? errorMessage,
  }) {
    return CoursesState(
      isLoading: isLoading ?? this.isLoading,
      courses: courses ?? this.courses,
      selectedCourseId: selectedCourseId ?? this.selectedCourseId,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    courses,
    selectedCourseId,
    errorMessage,
  ];
}
