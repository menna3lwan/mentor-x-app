part of 'package:mentorx_core/mentorx_core.dart';

class TenantEntity extends Equatable {
  final String id;
  final String name;

  const TenantEntity({
    required this.id,
    required this.name,
  });

  static const placeholder = TenantEntity(
    id: '',
    name: '',
  );

  @override
  List<Object?> get props => [id, name];

  TenantEntity copyWith({
    String? id,
    String? name,
  }) {
    return TenantEntity(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
