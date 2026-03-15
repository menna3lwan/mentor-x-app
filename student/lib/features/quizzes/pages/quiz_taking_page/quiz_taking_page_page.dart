import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import '../../widgets/quiz_ui.dart';

class QuizTakingPage extends StatefulWidget {
  const QuizTakingPage({super.key});
  @override
  State<QuizTakingPage> createState() => _QuizTakingPageState();
}

class _QuizTakingPageState extends State<QuizTakingPage> {
  int _currentQuestion = 0;
  final int _totalQuestions = 20;
  final Map<int, int> _answers = {};
  int _remainingSeconds = 1475;
  Timer? _timer;

  final List<Map<String, dynamic>> _questions = List.generate(
    20,
    (i) => {
      'textAr':
          '\u0633\u0624\u0627\u0644 ${i + 1}: \u0645\u0627 \u0647\u0648 \u0627\u0644\u0641\u0631\u0642 \u0628\u064A\u0646 \u0627\u0644\u0645\u0648\u062C\u0627\u062A \u0627\u0644\u0637\u0648\u0644\u064A\u0629 \u0648\u0627\u0644\u0645\u0633\u062A\u0639\u0631\u0636\u0629\u061F',
      'textEn':
          'Question ${i + 1}: What is the difference between longitudinal and transverse waves?',
      'options': ['Option A', 'Option B', 'Option C', 'Option D'],
    },
  );

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      if (_remainingSeconds <= 0) {
        _timer?.cancel();
        context.push('/quiz-review');
        return;
      }
      setState(() => _remainingSeconds--);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _timerText {
    final m = _remainingSeconds ~/ 60;
    final s = _remainingSeconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final t = context.t.student;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final q = _questions[_currentQuestion];
    final progress = (_currentQuestion + 1) / _totalQuestions;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: AppColors.primary,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: AppColors.backgroundLight,
          body: Column(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(
                  20,
                  MediaQuery.paddingOf(context).top + 12,
                  20,
                  16,
                ),
                decoration: const BoxDecoration(color: AppColors.primary),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        QuizTimerPill(text: _timerText, icon: Icons.schedule),
                        _ReviewPillButton(
                          label: t['review']!,
                          onPressed: () => context.push('/quiz-review'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(3),
                            child: Container(
                              height: 6,
                              color: Colors.white.withValues(alpha: 0.15),
                              child: Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: FractionallySizedBox(
                                  widthFactor: progress.clamp(0.0, 1.0),
                                  child: Container(color: AppColors.accent),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${_currentQuestion + 1} / $_totalQuestions',
                          textDirection: TextDirection.ltr,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: QuizCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t
                              ['questionOf']!
                              .replaceFirst('%s', '${_currentQuestion + 1}')
                              .replaceFirst('%s', '$_totalQuestions'),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            color: AppColors.accent,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          isAr ? q['textAr'] : q['textEn'],
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                            height: 1.8,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ...List.generate(4, (i) {
                          final isSelected = _answers[_currentQuestion] == i;
                          final labels = ['A', 'B', 'C', 'D'];
                          return _OptionTile(
                            label: labels[i],
                            text: q['options'][i],
                            isSelected: isSelected,
                            onTap: () =>
                                setState(() => _answers[_currentQuestion] = i),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: QuizOutlineButton(
                        label: t['commonPrevious']!,
                        onPressed: _currentQuestion == 0
                            ? null
                            : () => setState(() => _currentQuestion--),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: QuizGradientButton(
                        label: _currentQuestion < _totalQuestions - 1
                            ? t['commonNext']!
                            : t['review']!,
                        onPressed: () {
                          if (_currentQuestion < _totalQuestions - 1) {
                            setState(() => _currentQuestion++);
                          } else {
                            context.push('/quiz-review');
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ReviewPillButton extends StatelessWidget {
  const _ReviewPillButton({required this.label, required this.onPressed});
  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(QuizUi.radiusSm),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(QuizUi.radiusSm),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class _OptionTile extends StatelessWidget {
  const _OptionTile({
    required this.label,
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(QuizUi.radiusSm),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.background : Colors.white,
              borderRadius: BorderRadius.circular(QuizUi.radiusSm),
              border: Border.all(
                color: isSelected ? AppColors.accent : AppColors.greyLight,
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? AppColors.accent : Colors.transparent,
                    border: Border.all(
                      color: isSelected
                          ? AppColors.accent
                          : AppColors.greyLight,
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: isSelected ? Colors.white : AppColors.greyDark,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
