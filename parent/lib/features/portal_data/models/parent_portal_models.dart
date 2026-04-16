import 'package:equatable/equatable.dart';

final class ParentChild extends Equatable {
  final String id;
  final String fullName;
  final String gradeName;
  final String tenantName;
  final String studentCode;
  final String relationship;
  final bool isVerified;
  final DateTime linkedAt;
  final String? avatarUrl;

  const ParentChild({
    required this.id,
    required this.fullName,
    required this.gradeName,
    required this.tenantName,
    required this.studentCode,
    required this.relationship,
    required this.isVerified,
    required this.linkedAt,
    this.avatarUrl,
  });

  @override
  List<Object?> get props => [
    id,
    fullName,
    gradeName,
    tenantName,
    studentCode,
    relationship,
    isVerified,
    linkedAt,
    avatarUrl,
  ];
}

final class ParentCourseProgress extends Equatable {
  final String id;
  final String title;
  final String teacherName;
  final int progressPercent;
  final int completedSessions;
  final int totalSessions;
  final double timeSpentHours;
  final DateTime lastAccessedAt;
  final DateTime? expiresAt;

  const ParentCourseProgress({
    required this.id,
    required this.title,
    required this.teacherName,
    required this.progressPercent,
    required this.completedSessions,
    required this.totalSessions,
    required this.timeSpentHours,
    required this.lastAccessedAt,
    this.expiresAt,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    teacherName,
    progressPercent,
    completedSessions,
    totalSessions,
    timeSpentHours,
    lastAccessedAt,
    expiresAt,
  ];
}

final class ParentAssessmentRecord extends Equatable {
  final String id;
  final String title;
  final String courseName;
  final String type;
  final double score;
  final double totalScore;
  final DateTime date;
  final String status;
  final int attempts;

  const ParentAssessmentRecord({
    required this.id,
    required this.title,
    required this.courseName,
    required this.type,
    required this.score,
    required this.totalScore,
    required this.date,
    required this.status,
    required this.attempts,
  });

  double get percentage =>
      totalScore == 0 ? 0 : ((score / totalScore) * 100).clamp(0, 100);

  @override
  List<Object?> get props => [
    id,
    title,
    courseName,
    type,
    score,
    totalScore,
    date,
    status,
    attempts,
  ];
}

final class ParentAttendanceRecord extends Equatable {
  final String id;
  final DateTime date;
  final String sessionName;
  final String centerName;
  final String startTime;
  final String endTime;
  final String status;
  final String? checkInTime;
  final String? teacherNotes;

  const ParentAttendanceRecord({
    required this.id,
    required this.date,
    required this.sessionName,
    required this.centerName,
    required this.startTime,
    required this.endTime,
    required this.status,
    this.checkInTime,
    this.teacherNotes,
  });

  @override
  List<Object?> get props => [
    id,
    date,
    sessionName,
    centerName,
    startTime,
    endTime,
    status,
    checkInTime,
    teacherNotes,
  ];
}

final class ParentFinancialTransaction extends Equatable {
  final String id;
  final String description;
  final double amount;
  final double balanceAfter;
  final DateTime createdAt;
  final String type;
  final String paymentMethod;
  final String status;

  const ParentFinancialTransaction({
    required this.id,
    required this.description,
    required this.amount,
    required this.balanceAfter,
    required this.createdAt,
    required this.type,
    required this.paymentMethod,
    required this.status,
  });

  bool get isCredit => amount > 0;

  @override
  List<Object?> get props => [
    id,
    description,
    amount,
    balanceAfter,
    createdAt,
    type,
    paymentMethod,
    status,
  ];
}

final class ParentNotificationItem extends Equatable {
  final String id;
  final String studentName;
  final String type;
  final String title;
  final String body;
  final bool isRead;
  final DateTime createdAt;

  const ParentNotificationItem({
    required this.id,
    required this.studentName,
    required this.type,
    required this.title,
    required this.body,
    required this.isRead,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    studentName,
    type,
    title,
    body,
    isRead,
    createdAt,
  ];
}

final class ParentAnnouncementItem extends Equatable {
  final String id;
  final String title;
  final String content;
  final bool isPinned;
  final String priority;
  final DateTime publishedAt;

  const ParentAnnouncementItem({
    required this.id,
    required this.title,
    required this.content,
    required this.isPinned,
    required this.priority,
    required this.publishedAt,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    content,
    isPinned,
    priority,
    publishedAt,
  ];
}

final class ParentWhatsappGroup extends Equatable {
  final String id;
  final String name;
  final String targetType;
  final String inviteUrl;

  const ParentWhatsappGroup({
    required this.id,
    required this.name,
    required this.targetType,
    required this.inviteUrl,
  });

  @override
  List<Object?> get props => [id, name, targetType, inviteUrl];
}

final class ParentProfileData extends Equatable {
  final String fullName;
  final String phone;
  final String email;
  final DateTime createdAt;
  final String? photoUrl;
  final Map<String, String> relationships;

  const ParentProfileData({
    required this.fullName,
    required this.phone,
    required this.email,
    required this.createdAt,
    this.photoUrl,
    required this.relationships,
  });

  ParentProfileData copyWith({
    String? fullName,
    String? phone,
    String? email,
    DateTime? createdAt,
    String? photoUrl,
    Map<String, String>? relationships,
  }) {
    return ParentProfileData(
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      photoUrl: photoUrl ?? this.photoUrl,
      relationships: relationships ?? this.relationships,
    );
  }

  @override
  List<Object?> get props => [
    fullName,
    phone,
    email,
    createdAt,
    photoUrl,
    relationships,
  ];
}

final class ParentSettingsData extends Equatable {
  final String languageCode;
  final String themeMode;
  final bool pushNotificationsEnabled;
  final Map<String, bool> categoryPreferences;

  const ParentSettingsData({
    required this.languageCode,
    required this.themeMode,
    required this.pushNotificationsEnabled,
    required this.categoryPreferences,
  });

  ParentSettingsData copyWith({
    String? languageCode,
    String? themeMode,
    bool? pushNotificationsEnabled,
    Map<String, bool>? categoryPreferences,
  }) {
    return ParentSettingsData(
      languageCode: languageCode ?? this.languageCode,
      themeMode: themeMode ?? this.themeMode,
      pushNotificationsEnabled:
          pushNotificationsEnabled ?? this.pushNotificationsEnabled,
      categoryPreferences: categoryPreferences ?? this.categoryPreferences,
    );
  }

  @override
  List<Object?> get props => [
    languageCode,
    themeMode,
    pushNotificationsEnabled,
    categoryPreferences,
  ];
}
