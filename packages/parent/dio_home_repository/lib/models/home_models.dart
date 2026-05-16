import 'package:mentorx_core/mentorx_core.dart';

final class ParentHomeSummaryModel extends ParentHomeSummaryEntity {
  const ParentHomeSummaryModel({
    required super.parentId,
    required super.parentName,
    required super.childrenCount,
    required super.totalUnreadNotifications,
    required super.children,
  });

  factory ParentHomeSummaryModel.fromJson(Map<String, dynamic> json) {
    final data = ModelParser.extractData(json);

    final children = ModelParser.asList(data['children'])
        .map((e) => ParentChildSummaryModel.fromJson(ModelParser.asMap(e)))
        .toList();

    return ParentHomeSummaryModel(
      parentId: ModelParser.asString(data['parentId']),
      parentName: ModelParser.asString(data['parentName']),
      childrenCount: ModelParser.asInt(data['childrenCount']),
      totalUnreadNotifications: ModelParser.asInt(
        data['totalUnreadNotifications'],
      ),
      children: children,
    );
  }
}

final class ParentRecentActivityModel extends ParentRecentActivityEntity {
  const ParentRecentActivityModel({
    required super.id,
    required super.type,
    required super.title,
    required super.description,
    required super.timestamp,
    super.metadata,
  });

  factory ParentRecentActivityModel.fromJson(Map<String, dynamic> json) {
    return ParentRecentActivityModel(
      id: ModelParser.asString(json['id']),
      type: ModelParser.asString(json['type'], fallback: 'system'),
      title: ModelParser.asString(json['title']),
      description: ModelParser.asString(json['description']),
      timestamp:
          ModelParser.asDateTime(json['timestamp'] ?? json['created_at']) ??
          DateTime.now(),
      metadata: ModelParser.asMap(json['metadata']),
    );
  }
}

final class ParentChildSummaryModel extends ParentChildSummaryEntity {
  const ParentChildSummaryModel({
    required super.studentId,
    required super.studentName,
    super.studentCode,
    required super.grade,
    super.studyType,
    super.profileImageUrl,
    super.activeEnrollments = 0,
    super.completedLessons = 0,
    super.totalAttendance = 0,
    super.unreadNotifications = 0,
  });

  factory ParentChildSummaryModel.fromJson(Map<String, dynamic> json) {
    return ParentChildSummaryModel(
      studentId: ModelParser.asString(json['studentId']),
      studentName: ModelParser.asString(json['studentName']),
      studentCode: ModelParser.asString(json['studentCode']),
      grade: ModelParser.asString(json['grade']),
      studyType: ModelParser.asString(json['studyType']),
      profileImageUrl: ModelParser.asString(json['profileImageUrl']),
      activeEnrollments: ModelParser.asInt(json['activeEnrollments']),
      completedLessons: ModelParser.asInt(json['completedLessons']),
      totalAttendance: ModelParser.asInt(json['totalAttendance']),
      unreadNotifications: ModelParser.asInt(json['unreadNotifications']),
    );
  }
}

final class ParentChildDashboardSummaryModel
    extends ParentChildDashboardSummaryEntity {
  const ParentChildDashboardSummaryModel({
    required super.studentId,
    required super.studentName,
    super.studentCode,
    required super.grade,
    super.governorate,
    super.schoolName,
    super.studyType,
    super.centerName,
    super.profileImageUrl,
    super.totalAttendance = 0,
    super.centerAttendance = 0,
    super.onlineAttendance = 0,
    super.activeEnrollments = 0,
    super.completedLessons = 0,
    super.inProgressLessons = 0,
    super.lockedLessons = 0,
  });

  factory ParentChildDashboardSummaryModel.fromJson(Map<String, dynamic> json) {
    final data = ModelParser.extractData(json);

    return ParentChildDashboardSummaryModel(
      studentId: ModelParser.asString(data['studentId']),
      studentName: ModelParser.asString(data['studentName']),
      studentCode: ModelParser.asString(data['studentCode']),
      grade: ModelParser.asString(data['grade']),
      governorate: ModelParser.asString(data['governorate']),
      schoolName: ModelParser.asString(data['schoolName']),
      studyType: ModelParser.asString(data['studyType']),
      centerName: ModelParser.asString(data['centerName']),
      profileImageUrl: ModelParser.asString(data['profileImageUrl']),
      totalAttendance: ModelParser.asInt(data['totalAttendance']),
      centerAttendance: ModelParser.asInt(data['centerAttendance']),
      onlineAttendance: ModelParser.asInt(data['onlineAttendance']),
      activeEnrollments: ModelParser.asInt(data['activeEnrollments']),
      completedLessons: ModelParser.asInt(data['completedLessons']),
      inProgressLessons: ModelParser.asInt(data['inProgressLessons']),
      lockedLessons: ModelParser.asInt(data['lockedLessons']),
    );
  }
}
