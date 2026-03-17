part of '../../student_core.dart';

base class MarketplaceCategoryEntity extends Equatable {
  final String id;
  final String name;

  const MarketplaceCategoryEntity({
    required this.id,
    required this.name,
  });


  static final placeholder = MarketplaceCategoryEntity(
    id: '',
    name: '',
  );

  @override
  List<Object?> get props => [id, name];
}
