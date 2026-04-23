part of 'package:mentorx_core/mentorx_core.dart';

enum RepositoryMode {
  mock,
  prod;

  static RepositoryMode fromString(String value) {
    for (final mode in values) {
      if (mode.name == value.toLowerCase()) {
        return mode;
      }
    }
    // As this is a developer error, we can throw an exception.
    throw Exception('Unknown repository mode: $value');
  }
}
