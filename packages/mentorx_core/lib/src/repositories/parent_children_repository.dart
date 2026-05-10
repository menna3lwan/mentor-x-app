part of 'package:mentorx_core/mentorx_core.dart';

// ——— Exception ———

enum ParentChildrenRepositoryExceptionCode {
  unknown,
  fetchError,
  studentNotFound,
  registrationFailed,
}

final class ParentChildrenRepositoryException
    extends MentorXException<ParentChildrenRepositoryExceptionCode> {
  const ParentChildrenRepositoryException({required super.code, super.message});
}

// ——— Repository ———

abstract interface class ParentChildrenRepository {
  Future<void> initialize();

  Future<List<ParentChildEntity>> getChildren();

  Future<ParentStudentLookupEntity> findStudentByChildQuery({
    required String query,
  });

  Future<ParentChildEntity> linkChild({
    required String studentId,
    required String relationship,
  });

  Future<void> unlinkChild(String childId);
}
