part of '../../mentorx_core.dart';

final class BannerEntity extends Equatable {
  final String id;
  final String imageUrl;
  final String? title;
  final String actionType;
  final String actionValue;

  const BannerEntity({
    required this.id,
    required this.imageUrl,
    required this.actionType,
    required this.actionValue,
    this.title,
  });


  static final placeholder = BannerEntity(
    id: '',
    imageUrl: '',
    actionType: '',
    actionValue: '',
  );
  @override
  List<Object?> get props => [id, imageUrl, title, actionType, actionValue];
}
