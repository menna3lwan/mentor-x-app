part of '../../mock_data.dart';

final class MockParentGenerator {
  MockParentGenerator._();

  static ParentEntity generate({
    String? id,
    String? name,
    String? phoneNumber,
    String? profileImageUrl,
  }) {
    return ParentEntity(
      id: id ?? 'parent_${DateTime.now().millisecondsSinceEpoch}',
      name: name ?? 'John Doe (Parent)',
      phoneNumber: phoneNumber ?? '01000000000',
      profileImageUrl: profileImageUrl ?? 'https://picsum.photos/200/200?parent',
    );
  }

  static ParentEntity johnDoe() {
    return const ParentEntity(
      id: 'parent_1',
      name: 'John Doe',
      phoneNumber: '01012345678',
      profileImageUrl: 'https://i.pravatar.cc/150?u=parent_1',
    );
  }
}
