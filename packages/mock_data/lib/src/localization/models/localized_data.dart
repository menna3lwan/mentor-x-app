part of '../../../mock_data.dart';

/// A base class for bilingual mock values.
base class BilingualValues<T> {
  final T ar;
  final T en;

  const BilingualValues({required this.ar, required this.en});

  /// Get the value corresponding to a language code.
  T get(String languageCode) => (languageCode == 'ar') ? ar : en;
}

/// A wrapper for entity data that supports multiple languages.
/// 
/// This is used to define hand-crafted mock data in both Arabic and English
/// before passing it to a generator.
abstract class LocalizedData<T> {
  const LocalizedData();

  /// Resolve to a specific entity instance based on language.
  T resolve(String languageCode);
}
