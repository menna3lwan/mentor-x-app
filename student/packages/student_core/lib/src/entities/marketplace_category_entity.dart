part of '../../student_core.dart';

final class MarketplaceCategoryEntity extends Equatable {
  final String id;
  final String name;

  const MarketplaceCategoryEntity({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
