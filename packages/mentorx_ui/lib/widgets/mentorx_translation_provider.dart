part of '../mentorx_ui.dart';

final class MentorXTranslationProvider extends StatelessWidget {
  final Widget child;

  const MentorXTranslationProvider({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return TranslationProvider(child: child);
  }
}
