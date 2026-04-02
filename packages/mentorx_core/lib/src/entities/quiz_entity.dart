part of '../../mentorx_core.dart';

base class QuizEntity extends Equatable {
  final String id;
  final String title;
  final int durationMinutes;
  final int totalMarks;
  final int maxAttempts;
  final double passPercentage;
  final bool shuffleQuestions;
  final bool shuffleOptions;
  final int? questionsPerAttempt;
  final bool showCorrectAnswers;
  final bool showExplanations;
  final bool showScoreImmediately;
  final DateTime? availableFrom;
  final DateTime? availableUntil;

  const QuizEntity({
    required this.id,
    required this.title,
    required this.durationMinutes,
    required this.totalMarks,
    this.maxAttempts = 1,
    this.passPercentage = 50,
    this.shuffleQuestions = false,
    this.shuffleOptions = false,
    this.questionsPerAttempt,
    this.showCorrectAnswers = true,
    this.showExplanations = true,
    this.showScoreImmediately = true,
    this.availableFrom,
    this.availableUntil,
  });


  static final placeholder = QuizEntity(
    id: '',
    title: '',
    durationMinutes: 0,
    totalMarks: 0,
  );
  @override
  List<Object?> get props => [
        id,
        title,
        durationMinutes,
        totalMarks,
        maxAttempts,
        passPercentage,
        shuffleQuestions,
        shuffleOptions,
        questionsPerAttempt,
        showCorrectAnswers,
        showExplanations,
        showScoreImmediately,
        availableFrom,
        availableUntil,
      ];
}
