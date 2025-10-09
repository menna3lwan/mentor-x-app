part of '../mentorx_core.dart';

class MentorXException<T> implements Exception {
  final T code;
  final String? message;

  const MentorXException({this.message, required this.code});

  static MentorXException<String> unknown({String? message}) {
    return MentorXException<String>(code: 'unknown', message: message);
  }

  static MentorXException fromError(
    Object? error, {
    String? unknownErrorMessage,
  }) {
    if (error is MentorXException) return error;
    return MentorXException.unknown(message: unknownErrorMessage);
  }

  @override
  String toString() => 'MentorXException(code: $code, message: $message)';
}
