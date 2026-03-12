part of '../../parent_core.dart';

final class ParentEntity extends Equatable {
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

  factory ParentEntity.fromJson(Map<String, dynamic> json) {
    return ParentEntity(
      id: json['id'] as String,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      profileImageUrl: json['profileImageUrl'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'phoneNumber': phoneNumber,
    'profileImageUrl': profileImageUrl,
  };

  @override
  List<Object?> get props => [id, name, phoneNumber, profileImageUrl];
}
