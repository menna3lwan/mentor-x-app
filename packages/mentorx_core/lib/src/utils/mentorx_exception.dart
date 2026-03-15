part of '../../mentorx_core.dart';

abstract class MentorXException<T extends Enum> extends Equatable
    implements Exception {
  final T code;
  final String? message;

  const MentorXException({required this.code, this.message});

  @override
  List<Object?> get props => [code, message];
}
