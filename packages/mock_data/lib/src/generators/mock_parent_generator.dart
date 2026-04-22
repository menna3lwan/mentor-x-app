part of '../../mock_data.dart';

final class MockParentGenerator {
  MockParentGenerator._();

  static ParentEntity generate({
    String? id,
    String? firstName,
    String? lastName,
    String? name,
    String? phoneNumber,
    String? profileImageUrl,
  }) {
    // Support legacy `name` parameter by splitting it
    String resolvedFirst = firstName ?? 'John';
    String resolvedLast = lastName ?? 'Doe';
    if (name != null && firstName == null && lastName == null) {
      final parts = name.split(' ');
      resolvedFirst = parts.first;
      resolvedLast = parts.length > 1 ? parts.sublist(1).join(' ') : '';
    }

    final now = DateTime.now();
    return ParentEntity(
      id: id ?? 'parent_${now.millisecondsSinceEpoch}',
      firstName: resolvedFirst,
      lastName: resolvedLast,
      email: 'parent@example.com',
      phoneNumber: phoneNumber ?? '01000000000',
      profileImageUrl: profileImageUrl ?? 'https://picsum.photos/200/200?parent',
      status: ParentStatus.active,
      createdAt: now,
      updatedAt: now,
    );
  }

  static ParentEntity johnDoe() {
    final now = DateTime.now();
    return ParentEntity(
      id: 'parent_1',
      firstName: 'John',
      lastName: 'Doe',
      email: 'johndoe@example.com',
      phoneNumber: '01012345678',
      profileImageUrl: 'https://i.pravatar.cc/150?u=parent_1',
      status: ParentStatus.active,
      createdAt: now,
      updatedAt: now,
    );
  }
}
