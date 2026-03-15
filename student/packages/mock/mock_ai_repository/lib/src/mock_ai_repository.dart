import 'dart:async';

import 'package:student_core/student_core.dart';

final class MockAIRepository implements AIRepository {
  final Duration delay;

  const MockAIRepository({required this.delay});

  @override
  Future<List<AIConversationEntity>> getConversations({
    int page = 1,
    int limit = 20,
  }) async {
    await Future<void>.delayed(delay);
    final now = DateTime.now();
    return [
      AIConversationEntity(
        id: 'conv-1',
        title: 'Help with Quadratic Equations',
        subject: 'Algebra',
        messageCount: 8,
        createdAt: now.subtract(const Duration(hours: 2)),
        updatedAt: now.subtract(const Duration(hours: 1)),
      ),
      AIConversationEntity(
        id: 'conv-2',
        title: 'Newton\'s Laws Explanation',
        subject: 'Physics',
        messageCount: 12,
        createdAt: now.subtract(const Duration(days: 1)),
        updatedAt: now.subtract(const Duration(days: 1, hours: -2)),
      ),
      AIConversationEntity(
        id: 'conv-3',
        title: 'Essay Writing Tips',
        subject: 'English',
        messageCount: 5,
        createdAt: now.subtract(const Duration(days: 3)),
        updatedAt: now.subtract(const Duration(days: 3)),
      ),
    ];
  }

  @override
  Future<AIConversationEntity> createConversation({String? subject}) async {
    await Future<void>.delayed(delay);
    final now = DateTime.now();
    return AIConversationEntity(
      id: 'conv-new-${now.millisecondsSinceEpoch}',
      subject: subject,
      messageCount: 0,
      createdAt: now,
      updatedAt: now,
    );
  }

  @override
  Future<void> deleteConversation(String conversationId) async {
    await Future<void>.delayed(delay ~/ 2);
  }

  @override
  Future<void> renameConversation(
    String conversationId,
    String title,
  ) async {
    await Future<void>.delayed(delay ~/ 2);
  }

  @override
  Future<List<AIMessageEntity>> getMessages(
    String conversationId, {
    int page = 1,
    int limit = 30,
  }) async {
    await Future<void>.delayed(delay);
    final now = DateTime.now();
    return [
      AIMessageEntity(
        id: 'msg-1',
        conversationId: conversationId,
        role: AIMessageRole.user,
        content: 'Can you explain how to solve quadratic equations?',
        createdAt: now.subtract(const Duration(hours: 2)),
      ),
      AIMessageEntity(
        id: 'msg-2',
        conversationId: conversationId,
        role: AIMessageRole.assistant,
        content:
            'Of course! A quadratic equation has the form ax^2 + bx + c = 0. '
            'You can solve it using:\n\n'
            '1. **Factoring** — if the expression factors neatly.\n'
            '2. **Completing the square** — rewrite in vertex form.\n'
            '3. **The quadratic formula** — x = (-b +/- sqrt(b^2 - 4ac)) / 2a.\n\n'
            'Would you like me to walk through an example?',
        sources: ['Algebra Textbook Ch.4', 'Session 11 Notes'],
        confidence: 'high',
        createdAt: now.subtract(const Duration(hours: 1, minutes: 59)),
      ),
      AIMessageEntity(
        id: 'msg-3',
        conversationId: conversationId,
        role: AIMessageRole.user,
        content: 'Yes, please solve x^2 - 5x + 6 = 0 step by step.',
        createdAt: now.subtract(const Duration(hours: 1, minutes: 55)),
      ),
      AIMessageEntity(
        id: 'msg-4',
        conversationId: conversationId,
        role: AIMessageRole.assistant,
        content:
            'Let\'s solve x^2 - 5x + 6 = 0 by factoring:\n\n'
            '1. Find two numbers that multiply to 6 and add to -5.\n'
            '2. Those numbers are -2 and -3.\n'
            '3. Factor: (x - 2)(x - 3) = 0\n'
            '4. Set each factor to zero: x = 2 or x = 3.\n\n'
            'The solutions are **x = 2** and **x = 3**.',
        sources: ['Algebra Textbook Ch.4'],
        confidence: 'high',
        createdAt: now.subtract(const Duration(hours: 1, minutes: 54)),
      ),
    ];
  }

  @override
  Future<AIMessageEntity> sendMessage(
    String conversationId,
    String content,
  ) async {
    await Future<void>.delayed(delay);
    return AIMessageEntity(
      id: 'msg-resp-${DateTime.now().millisecondsSinceEpoch}',
      conversationId: conversationId,
      role: AIMessageRole.assistant,
      content:
          'That\'s a great question! Based on what we\'ve covered, '
          'the key concept here is to identify the pattern and apply '
          'the appropriate formula. Let me know if you need more details.',
      sources: ['Course Materials'],
      confidence: 'high',
      createdAt: DateTime.now(),
    );
  }

  @override
  Future<void> submitFeedback(
    String messageId, {
    int? rating,
    String? feedback,
  }) async {
    await Future<void>.delayed(delay ~/ 2);
  }
}
