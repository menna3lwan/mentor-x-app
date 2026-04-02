part of '../../mentorx_core.dart';

base class AnnouncementEntity extends Equatable {
  final String id;
  final String title;
  final String preview;
  final String? imageUrl;
  final bool isPinned;
  final DateTime createdAt;
  final DateTime? expireAt;

  const AnnouncementEntity({
    required this.id,
    required this.title,
    required this.preview,
    required this.createdAt,
    this.imageUrl,
    this.isPinned = false,
    this.expireAt,
  });


  static final placeholder = AnnouncementEntity(
    id: '',
    title: '',
    preview: '',
    createdAt: DateTime.fromMillisecondsSinceEpoch(0),
  );
  @override
  List<Object?> get props => [
        id,
        title,
        preview,
        imageUrl,
        isPinned,
        createdAt,
        expireAt,
      ];
}
