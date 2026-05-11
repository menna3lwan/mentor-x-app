part of 'package:mentorx_core/mentorx_core.dart';

class LeaderboardEntryEntity extends Equatable {
  final int rank;
  final String studentId;
  final String studentName;
  final String? avatarUrl;
  final int points;
  final double score;
  final int? quizCount;
  final bool isCurrentUser;

  const LeaderboardEntryEntity({
    required this.rank,
    required this.studentId,
    required this.studentName,
    this.avatarUrl,
    required this.points,
    required this.score,
    this.quizCount,
    this.isCurrentUser = false,
  });

  static final placeholder = LeaderboardEntryEntity(
    rank: 0,
    studentId: '',
    studentName: '',
    points: 0,
    score: 0,
  );

  @override
  List<Object?> get props => [
        rank,
        studentId,
        studentName,
        avatarUrl,
        points,
        score,
        quizCount,
        isCurrentUser,
      ];

  LeaderboardEntryEntity copyWith({
    int? rank,
    String? studentId,
    String? studentName,
    String? avatarUrl,
    int? points,
    double? score,
    int? quizCount,
    bool? isCurrentUser,
  }) {
    return LeaderboardEntryEntity(
      rank: rank ?? this.rank,
      studentId: studentId ?? this.studentId,
      studentName: studentName ?? this.studentName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      points: points ?? this.points,
      score: score ?? this.score,
      quizCount: quizCount ?? this.quizCount,
      isCurrentUser: isCurrentUser ?? this.isCurrentUser,
    );
  }
}
