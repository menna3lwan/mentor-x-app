import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'package:mentorx_ui/mentorx_ui.dart';
import 'package:parent/features/home/widgets/child_switcher/child_switcher_widget.dart';

void main() {
  const childA = ParentChildEntity(id: 'a', name: 'Ahmed Kamal');
  const childB = ParentChildEntity(id: 'b', name: 'Layla Hassan');

  Widget wrap(Widget child) {
    return MentorXTranslationProvider(
      child: MentorXThemeProvider(
        lightTheme: MentorXThemes.light,
        child: MaterialApp(
          home: Scaffold(body: child),
        ),
      ),
    );
  }

  group('ChildSwitcherWidget', () {
    testWidgets('renders all children + add-child button', (tester) async {
      var addPressed = false;
      ParentChildEntity? lastSelected;

      await tester.pumpWidget(wrap(ChildSwitcherWidget(
        children: const [childA, childB],
        selectedChildId: 'a',
        onChildSelected: (c) => lastSelected = c,
        onAddChildPressed: () => addPressed = true,
        addChildLabel: 'Add',
      )));
      await tester.pumpAndSettle();

      expect(find.text('Ahmed'), findsOneWidget);
      expect(find.text('Layla'), findsOneWidget);
      expect(find.text('Add'), findsOneWidget);

      await tester.tap(find.text('Layla'));
      expect(lastSelected, equals(childB));

      await tester.tap(find.text('Add'));
      expect(addPressed, isTrue);
    });

    testWidgets('empty children list renders nothing', (tester) async {
      await tester.pumpWidget(wrap(ChildSwitcherWidget(
        children: const [],
        selectedChildId: null,
        onChildSelected: (_) {},
        onAddChildPressed: () {},
        addChildLabel: 'Add',
      )));
      expect(find.byType(ListView), findsNothing);
    });

    testWidgets('long names are truncated, not overflow', (tester) async {
      const longName = ParentChildEntity(
        id: 'long',
        name: 'MuhammadAbdulrahmanAbdullahAhmedibnSulaymanAlMakkawi',
      );
      await tester.pumpWidget(wrap(ChildSwitcherWidget(
        children: const [longName],
        selectedChildId: 'long',
        onChildSelected: (_) {},
        onAddChildPressed: () {},
        addChildLabel: 'Add',
      )));
      // No render exceptions = pass.
      expect(tester.takeException(), isNull);
    });
  });
}
