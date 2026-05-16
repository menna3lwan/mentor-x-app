part of 'package:mentorx_core/mentorx_core.dart';

class ParentHomeSummaryEntity extends Equatable {
  final String parentId;
  final String parentName;
  final int childrenCount;
  final int totalUnreadNotifications;
  final List<ParentChildSummaryEntity> children;

  const ParentHomeSummaryEntity({
    required this.parentId,
    required this.parentName,
    required this.childrenCount,
    required this.totalUnreadNotifications,
    required this.children,
  });

  static final placeholder = ParentHomeSummaryEntity(
    parentId: '',
    parentName: '',
    childrenCount: 0,
    totalUnreadNotifications: 0,
    children: const [],
  );

  @override
  List<Object?> get props => [
        parentId,
        parentName,
        childrenCount,
        totalUnreadNotifications,
        children,
      ];

  ParentHomeSummaryEntity copyWith({
    String? parentId,
    String? parentName,
    int? childrenCount,
    int? totalUnreadNotifications,
    List<ParentChildSummaryEntity>? children,
  }) {
    return ParentHomeSummaryEntity(
      parentId: parentId ?? this.parentId,
      parentName: parentName ?? this.parentName,
      childrenCount: childrenCount ?? this.childrenCount,
      totalUnreadNotifications:
          totalUnreadNotifications ?? this.totalUnreadNotifications,
      children: children ?? this.children,
    );
  }
}

class ParentChildSummaryEntity extends Equatable {
  final String studentId;
  final String studentName;
  final String? studentCode;
  final String grade;
  final String? studyType;
  final String? profileImageUrl;
  final int activeEnrollments;
  final int completedLessons;
  final int totalAttendance;
  final int unreadNotifications;

  const ParentChildSummaryEntity({
    required this.studentId,
    required this.studentName,
    this.studentCode,
    required this.grade,
    this.studyType,
    this.profileImageUrl,
    this.activeEnrollments = 0,
    this.completedLessons = 0,
    this.totalAttendance = 0,
    this.unreadNotifications = 0,
  });

  static const placeholder = ParentChildSummaryEntity(
    studentId: '',
    studentName: '',
    grade: '',
  );

  @override
  List<Object?> get props => [
        studentId,
        studentName,
        studentCode,
        grade,
        studyType,
        profileImageUrl,
        activeEnrollments,
        completedLessons,
        totalAttendance,
        unreadNotifications,
      ];

  ParentChildSummaryEntity copyWith({
    String? studentId,
    String? studentName,
    String? studentCode,
    String? grade,
    String? studyType,
    String? profileImageUrl,
    int? activeEnrollments,
    int? completedLessons,
    int? totalAttendance,
    int? unreadNotifications,
  }) {
    return ParentChildSummaryEntity(
      studentId: studentId ?? this.studentId,
      studentName: studentName ?? this.studentName,
      studentCode: studentCode ?? this.studentCode,
      grade: grade ?? this.grade,
      studyType: studyType ?? this.studyType,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      activeEnrollments: activeEnrollments ?? this.activeEnrollments,
      completedLessons: completedLessons ?? this.completedLessons,
      totalAttendance: totalAttendance ?? this.totalAttendance,
      unreadNotifications: unreadNotifications ?? this.unreadNotifications,
    );
  }
}

class ParentChildDashboardSummaryEntity extends Equatable {
  final String studentId;
  final String studentName;
  final String? studentCode;
  final String grade;
  final String? governorate;
  final String? schoolName;
  final String? studyType;
  final String? centerName;
  final String? profileImageUrl;

  final int totalAttendance;
  final int centerAttendance;
  final int onlineAttendance;

  final int activeEnrollments;
  final int completedLessons;
  final int inProgressLessons;
  final int lockedLessons;

  const ParentChildDashboardSummaryEntity({
    required this.studentId,
    required this.studentName,
    this.studentCode,
    required this.grade,
    this.governorate,
    this.schoolName,
    this.studyType,
    this.centerName,
    this.profileImageUrl,
    this.totalAttendance = 0,
    this.centerAttendance = 0,
    this.onlineAttendance = 0,
    this.activeEnrollments = 0,
    this.completedLessons = 0,
    this.inProgressLessons = 0,
    this.lockedLessons = 0,
  });

  static final placeholder = ParentChildDashboardSummaryEntity(
    studentId: '',
    studentName: '',
    grade: '',
  );

  @override
  List<Object?> get props => [
        studentId,
        studentName,
        studentCode,
        grade,
        governorate,
        schoolName,
        studyType,
        centerName,
        profileImageUrl,
        totalAttendance,
        centerAttendance,
        onlineAttendance,
        activeEnrollments,
        completedLessons,
        inProgressLessons,
        lockedLessons,
      ];

  ParentChildDashboardSummaryEntity copyWith({
    String? studentId,
    String? studentName,
    String? studentCode,
    String? grade,
    String? governorate,
    String? schoolName,
    String? studyType,
    String? centerName,
    String? profileImageUrl,
    int? totalAttendance,
    int? centerAttendance,
    int? onlineAttendance,
    int? activeEnrollments,
    int? completedLessons,
    int? inProgressLessons,
    int? lockedLessons,
  }) {
    return ParentChildDashboardSummaryEntity(
      studentId: studentId ?? this.studentId,
      studentName: studentName ?? this.studentName,
      studentCode: studentCode ?? this.studentCode,
      grade: grade ?? this.grade,
      governorate: governorate ?? this.governorate,
      schoolName: schoolName ?? this.schoolName,
      studyType: studyType ?? this.studyType,
      centerName: centerName ?? this.centerName,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      totalAttendance: totalAttendance ?? this.totalAttendance,
      centerAttendance: centerAttendance ?? this.centerAttendance,
      onlineAttendance: onlineAttendance ?? this.onlineAttendance,
      activeEnrollments: activeEnrollments ?? this.activeEnrollments,
      completedLessons: completedLessons ?? this.completedLessons,
      inProgressLessons: inProgressLessons ?? this.inProgressLessons,
      lockedLessons: lockedLessons ?? this.lockedLessons,
    );
  }
}

class ParentRecentActivityEntity extends Equatable {
  final String id;
  final String type;
  final String title;
  final String description;
  final DateTime timestamp;
  final Map<String, dynamic> metadata;

  const ParentRecentActivityEntity({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.timestamp,
    this.metadata = const {},
  });

  static final placeholder = ParentRecentActivityEntity(
    id: '',
    type: '',
    title: '',
    description: '',
    timestamp: DateTime.fromMillisecondsSinceEpoch(0),
  );

  @override
  List<Object?> get props => [
    id,
    type,
    title,
    description,
    timestamp,
    metadata,
  ];

  ParentRecentActivityEntity copyWith({
    String? id,
    String? type,
    String? title,
    String? description,
    DateTime? timestamp,
    Map<String, dynamic>? metadata,
  }) {
    return ParentRecentActivityEntity(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      timestamp: timestamp ?? this.timestamp,
      metadata: metadata ?? this.metadata,
    );
  }
}
