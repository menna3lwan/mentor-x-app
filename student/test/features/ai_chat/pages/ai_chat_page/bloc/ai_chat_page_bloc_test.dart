import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_ai_repository/mock_ai_repository.dart';

import 'package:mentorx_student/core/core.dart';
import 'package:mentorx_student/features/ai_chat/pages/ai_chat_page/bloc/ai_chat_page_bloc.dart';

void main() {
  late MockAIRepository aiRepository;

  setUp(() {
    aiRepository = const MockAIRepository(delay: Duration.zero);
  });

  group('AiChatPageBloc', () {
    test('initial state is correct', () {
      final bloc = AiChatPageBloc(aiRepository: aiRepository);
      expect(bloc.state, AiChatPageState.initial);
      expect(bloc.state.loadingState, LoadingState.initial);
      bloc.close();
    });

    blocTest<AiChatPageBloc, AiChatPageState>(
      'emits [loading, loaded] when AiChatPageLoadEvent is added',
      build: () => AiChatPageBloc(aiRepository: aiRepository),
      act: (bloc) => bloc.add(const AiChatPageLoadEvent()),
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
