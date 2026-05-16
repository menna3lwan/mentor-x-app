import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_ai_repository/mock_ai_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/ai_chat/pages/ai_chat/bloc/ai_chat_page_bloc.dart';

class _MockAnalyticsService implements AnalyticsService {
  @override
  Future<void> initialize() async {}
  @override
  Future<void> logEvent({required String name, Map<String, Object?>? parameters}) async {}
  @override
  Future<void> setCurrentScreen({required String screenName, String? screenClassOverride}) async {}
  @override
  Future<void> setUserId(String? id) async {}
  @override
  Future<void> setUserProperty({required String name, required String? value}) async {}
  @override
  Future<void> resetAnalyticsData() async {}
}

void main() {
  late MockAIRepository aiRepository;
  late _MockAnalyticsService analyticsService;

  setUp(() {
    aiRepository = const MockAIRepository(delay: Duration.zero);
    analyticsService = _MockAnalyticsService();
  });

  group('AiChatPageBloc', () {
    test('initial state is correct', () {
      final bloc = AiChatPageBloc(
        aiRepository: aiRepository,
        analyticsService: analyticsService,
      );
      expect(bloc.state, AiChatPageState.initial);
      expect(bloc.state.loadingState, LoadingState.initial);
      bloc.close();
    });

    blocTest<AiChatPageBloc, AiChatPageState>(
      'emits [loading, loaded] when AiChatPageLoadEvent is added',
      build: () => AiChatPageBloc(
        aiRepository: aiRepository,
        analyticsService: analyticsService,
      ),
      act: (bloc) => bloc.add(const AiChatPageLoadEvent()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        isA<AiChatPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loading,
        ),
        isA<AiChatPageState>().having(
          (s) => s.loadingState,
          'loadingState',
          LoadingState.loaded,
        ),
      ],
    );
  });
}
