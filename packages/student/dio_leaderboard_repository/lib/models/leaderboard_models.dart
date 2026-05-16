import 'package:mentorx_core/mentorx_core.dart';

final class LeaderboardEntryModel extends LeaderboardEntryEntity {
  const LeaderboardEntryModel({
    required super.rank,
    required super.studentId,
    required super.studentName,
    super.avatarUrl,
    required super.points,
    required super.score,
    super.quizCount,
    super.isCurrentUser,
  });

  factory LeaderboardEntryModel.fromJson(Map<String, dynamic> json) {
    // Matches LeaderboardEntryResponse schema
    return LeaderboardEntryModel(
      rank: ModelParser.asInt(json['rank']),
      studentId: ModelParser.asString(json['studentId'] ?? json['id']),
      studentName: ModelParser.asString(
        json['studentName'] ?? json['name'] ?? json['fullName'],
      ),
      avatarUrl:
          ModelParser.asString(
            json['avatarUrl'] ?? json['profileImageUrl'] ?? json['image'],
          ).isEmpty
          ? null
          : ModelParser.asString(
              json['avatarUrl'] ?? json['profileImageUrl'] ?? json['image'],
            ),
      points: ModelParser.asInt(
        json['score'] ?? json['points'],
      ), // API uses 'score' for points/marks
      score: ModelParser.asDouble(
        json['percentage'] ?? json['score'],
      ), // percentage is the double score
      quizCount: ModelParser.asInt(
        json['totalMarks'],
      ), // Use as proxy if quizCount missing
      isCurrentUser: ModelParser.asBool(json['isCurrentUser'] ?? json['isMe']),
    );
  }

  Map<String, dynamic> toJson() => {
    'rank': rank,
    'studentId': studentId,
    'studentName': studentName,
    'avatarUrl': avatarUrl,
    'points': points,
    'score': score,
    'isCurrentUser': isCurrentUser,
  };
}
