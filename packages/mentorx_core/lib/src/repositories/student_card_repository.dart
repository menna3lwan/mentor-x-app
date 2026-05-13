part of 'package:mentorx_core/mentorx_core.dart';

enum StudentCardRepositoryExceptionCode {
  unknown,
  failedToLoadCard,
  failedToIssueCard,
}

final class StudentCardRepositoryException
    extends MentorXException<StudentCardRepositoryExceptionCode> {
  const StudentCardRepositoryException({required super.code, super.message});
}

abstract interface class StudentCardRepository {
  Future<void> initialize();

  /// Retrieves the current student's digital card.
  Future<StudentCardEntity> getMyCard();
}
