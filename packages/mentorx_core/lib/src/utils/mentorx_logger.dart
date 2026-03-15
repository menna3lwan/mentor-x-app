part of '../../mentorx_core.dart';

/// A wrapper around the Logger class that provides convenience methods for logging
/// and uses dart:developer log function for console output.
class MentorXLogger {
  static bool enabled = false;

  /// The name of the logger instance
  final String name;

  MentorXLogger(this.name);

  String messageWithName(String message) => '[$name] $message';

  /// Log a message at level [Level.debug].
  void debug(
    String message, [
    Object? error,
    StackTrace? stackTrace,
    DateTime? time,
  ]) {
    if (!enabled) return;
    log(
      messageWithName(message),
      level: 1,
      time: time,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Log a message at level [Level.info].
  void info(
    String message, [
    Object? error,
    StackTrace? stackTrace,
    DateTime? time,
  ]) {
    if (!enabled) return;
    log(
      messageWithName(message),
      time: time,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Log a message at level [Level.warning].
  void warning(
    String message, [
    Object? error,
    StackTrace? stackTrace,
    DateTime? time,
  ]) {
    if (!enabled) return;
    log(
      messageWithName(message),
      time: time,
      level: 10,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Log a message at level [Level.error].
  void error(
    String message, [
    Object? error,
    StackTrace? stackTrace,
    DateTime? time,
  ]) {
    if (!enabled) return;
    log(
      messageWithName(message),
      level: 20,
      time: time,
      error: error,
      stackTrace: stackTrace,
    );
  }

  /// Log a message at level [Level.fatal].
  void fatal(
    String message, [
    Object? error,
    StackTrace? stackTrace,
    DateTime? time,
  ]) {
    if (!enabled) return;

    log(
      messageWithName(message),
      level: 30,
      time: time,
      error: error,
      stackTrace: stackTrace,
    );
  }
}
