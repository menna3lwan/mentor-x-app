part of 'course_detail_page_bloc.dart';

enum DetailSectionStatus { initial, loading, loaded, failure }

enum CourseDetailTab { description, sessions }

enum EnrollActionStatus { initial, loading, success, failure }

final class CourseDetailPageState extends Equatable {
  final String courseId;
  final DetailSectionStatus courseStatus;
  final DetailSectionStatus sessionsStatus;
  final CourseEntity? course;
  final List<SessionEntity> sessions;
  final Map<String, List<SessionItemEntity>> sessionItems;
  final EnrollmentEntity? enrollment;
  final CourseDetailTab selectedTab;
  final EnrollActionStatus enrollStatus;
  final String? errorMessage;
  final String? enrollErrorMessage;

  const CourseDetailPageState({
    required this.courseId,
    this.courseStatus = DetailSectionStatus.initial,
    this.sessionsStatus = DetailSectionStatus.initial,
    this.course,
    this.sessions = const [],
    this.sessionItems = const {},
    this.enrollment,
    this.selectedTab = CourseDetailTab.description,
    this.enrollStatus = EnrollActionStatus.initial,
    this.errorMessage,
    this.enrollErrorMessage,
  });

  bool get isCourseLoading =>
      courseStatus == DetailSectionStatus.loading ||
      courseStatus == DetailSectionStatus.initial;
  bool get isCourseLoaded => courseStatus == DetailSectionStatus.loaded;
  bool get isCourseFailure => courseStatus == DetailSectionStatus.failure;
  bool get isSessionsLoading =>
      sessionsStatus == DetailSectionStatus.loading ||
      sessionsStatus == DetailSectionStatus.initial;

  bool get isEnrolled => enrollment != null;
  bool get isEnrolling => enrollStatus == EnrollActionStatus.loading;
  bool get isEnrollSuccess => enrollStatus == EnrollActionStatus.success;
  bool get isEnrollFailure => enrollStatus == EnrollActionStatus.failure;

  CourseDetailPageState copyWith({
    String? courseId,
    DetailSectionStatus? courseStatus,
    DetailSectionStatus? sessionsStatus,
    CourseEntity? course,
    List<SessionEntity>? sessions,
    Map<String, List<SessionItemEntity>>? sessionItems,
    EnrollmentEntity? enrollment,
    bool clearEnrollment = false,
    CourseDetailTab? selectedTab,
    EnrollActionStatus? enrollStatus,
    String? errorMessage,
    String? enrollErrorMessage,
  }) {
    return CourseDetailPageState(
      courseId: courseId ?? this.courseId,
      courseStatus: courseStatus ?? this.courseStatus,
      sessionsStatus: sessionsStatus ?? this.sessionsStatus,
      course: course ?? this.course,
      sessions: sessions ?? this.sessions,
      sessionItems: sessionItems ?? this.sessionItems,
      enrollment: clearEnrollment ? null : (enrollment ?? this.enrollment),
      selectedTab: selectedTab ?? this.selectedTab,
      enrollStatus: enrollStatus ?? this.enrollStatus,
      errorMessage: errorMessage,
      enrollErrorMessage: enrollErrorMessage,
    );
  }

  @override
  List<Object?> get props => [
    courseId,
    courseStatus,
    sessionsStatus,
    course,
    sessions,
    sessionItems,
    enrollment,
    selectedTab,
    enrollStatus,
    errorMessage,
    enrollErrorMessage,
  ];
}
