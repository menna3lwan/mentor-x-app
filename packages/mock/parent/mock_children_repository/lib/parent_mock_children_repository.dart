import 'package:mentorx_core/mentorx_core.dart';

final class MockChildrenRepository implements ParentChildrenRepository {
  final Duration delay;

  MockChildrenRepository({
    this.delay = const Duration(milliseconds: 800),
  });

  @override
  Future<List<ParentChildEntity>> getChildren() async {
    await Future.delayed(delay);
    return const [
      ParentChildEntity(
        id: '42',
        name: 'Ahmed Mohamed',
        gradeName: 'Grade 10',
        centerName: 'MentorX Maadi',
        isVerified: true,
        studentCode: 'AHM-2025-00142',
      ),
      ParentChildEntity(
        id: '84',
        name: 'Sara Ali',
        gradeName: 'Grade 7',
        centerName: 'MentorX Maadi',
        isVerified: false,
        studentCode: 'SAR-2025-00184',
      ),
    ];
  }

  @override
  Future<ParentStudentLookupEntity> findStudentByChildQuery({
    required String query,
  }) async {
    await Future.delayed(delay);
    if (query == 'MX-1001' || query == '01012345678') {
      return const ParentStudentLookupEntity(
        studentId: '42',
        maskedName: 'Ah** Mo**',
        gradeName: 'Grade 10',
        centerName: 'MentorX Maadi',
        canAutoVerify: true,
      );
    }
    throw const AuthenticationException(
      code: AuthenticationExceptionCode.studentNotFound,
      message: 'No student found matching query.',
    );
  }

  @override
  Future<ParentChildEntity> linkChild({
    required String studentId,
    required String relationship,
  }) async {
    await Future.delayed(delay);
    return ParentChildEntity(
      id: studentId,
      name: 'Linked Student',
      gradeName: 'Some Grade',
      centerName: 'Some Tenant',
      isVerified: true,
    );
  }

  @override
  Future<void> unlinkChild(String childId) async {
    await Future.delayed(delay);
  }
}
