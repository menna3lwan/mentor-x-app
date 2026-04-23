part of 'package:mentorx_core/mentorx_core.dart';

class MarketplaceCategoryEntity extends Equatable {
  final String id;
  final String name;

  const MarketplaceCategoryEntity({
    required this.id,
    required this.name,
  });

  static const placeholder = MarketplaceCategoryEntity(
    id: '',
    name: '',
  );

  @override
  List<Object?> get props => [id, name];

  MarketplaceCategoryEntity copyWith({
    String? id,
    String? name,
  }) {
    return MarketplaceCategoryEntity(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
