part of '../../mentorx_core.dart';

base class ParentEntity extends Equatable {
  final String id;
  final String name;
  final String phoneNumber;
  final String? profileImageUrl;

  const ParentEntity({
    required this.id,
    required this.name,
    required this.phoneNumber,
    this.profileImageUrl,
  });

  /// Placeholder for skeleton/loading states.
  static const placeholder = ParentEntity(
    id: '',
    name: '',
    phoneNumber: '',
  );

  ParentEntity copyWith({
    String? id,
    String? name,
    String? phoneNumber,
    String? profileImageUrl,
  }) {
    return ParentEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    );
  }

  @override
  List<Object?> get props => [id, name, phoneNumber, profileImageUrl];
}
