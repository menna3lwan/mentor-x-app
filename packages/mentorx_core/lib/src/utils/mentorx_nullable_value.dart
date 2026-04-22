part of 'package:mentorx_core/mentorx_core.dart';

/// Wrapper for explicitly passing null in [copyWith] methods.
///
/// Usage:
/// ```dart
/// entity.copyWith(optionalField: const MentorXNullableValue(null));
/// ```
final class MentorXNullableValue<T> {
  final T value;
  const MentorXNullableValue(this.value);
}
