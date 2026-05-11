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
    return LeaderboardEntryModel(
      rank: ModelParser.asInt(json['rank']),
      studentId: ModelParser.asString(json['studentId'] ?? json['id']),
      studentName: ModelParser.asString(json['studentName'] ?? json['name']),
      avatarUrl: ModelParser.asString(json['avatarUrl']).isEmpty
          ? null
          : ModelParser.asString(json['avatarUrl']),
      points: ModelParser.asInt(json['points']),
      score: ModelParser.asDouble(json['score']),
      quizCount: ModelParser.asInt(json['quizCount']) == 0
          ? null
          : ModelParser.asInt(json['quizCount']),
      isCurrentUser: ModelParser.asBool(json['isCurrentUser']),
    );
  }

  Map<String, dynamic> toJson() => {
        'rank': rank,
        'studentId': studentId,
        'studentName': studentName,
        'avatarUrl': avatarUrl,
        'points': points,
        'score': score,
        'quizCount': quizCount,
        'isCurrentUser': isCurrentUser,
      };
}
