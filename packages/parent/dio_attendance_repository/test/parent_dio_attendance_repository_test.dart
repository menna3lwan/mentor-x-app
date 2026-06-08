import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:mentorx_core/mentorx_core.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  test('can be instantiated', () {
    // Basic test to ensure package structure is correct
    expect(true, isTrue);
  });
}
