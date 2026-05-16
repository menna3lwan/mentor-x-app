import 'package:mentorx_core/mentorx_core.dart';

final class MockStudentCardRepository implements StudentCardRepository {
  final Duration delay;

  MockStudentCardRepository({this.delay = const Duration(milliseconds: 500)});

  @override
  Future<void> initialize() async {}

  @override
  Future<StudentCardEntity> getMyCard() async {
    await Future.delayed(delay);
    return StudentCardEntity(
      id: 'card_123',
      studentName: 'Kamal Ayman',
      studentCode: 'MX-2026-001',
      qrToken: 'SECURE_QR_TOKEN_ABC123',
      issuedAt: DateTime.now().subtract(const Duration(days: 30)),
      expiresAt: DateTime.now().add(const Duration(days: 335)),
      grade: 'Grade 12',
      center: 'Main Education Center',
      school: 'International School of Cairo',
    );
  }

  @override
  Future<StudentCardEntity> validateQr(String qrToken) async {
    await Future.delayed(delay);
    return getMyCard();
  }
}
