part of '../../mock_data.dart';

/// A mock implementation of [LocalizedClient] that allows switching language
/// for mock data generation.
final class MockLocalizedClient implements LocalizedClient {
  String _languageCode;

  MockLocalizedClient({required String languageCode}) : _languageCode = languageCode;

  String get languageCode => _languageCode;

  @override
  void setLocale(String languageCode) {
    _languageCode = languageCode;
  }

  /// Helper to check if current mode is Arabic
  bool get isArabic => _languageCode == 'ar';

  /// Helper to check if current mode is English
  bool get isEnglish => _languageCode == 'en';
}
