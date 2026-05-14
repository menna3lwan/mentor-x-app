import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

void main() {
  group('MentorXIconButton', () {
    testWidgets('renders correctly with given icon', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: MentorXThemeProvider(
            child: Scaffold(
              body: MentorXIconButton(
                icon: Icons.add,
                onPressed: () {},
              ),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('triggers onPressed when tapped', (tester) async {
      bool tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: MentorXThemeProvider(
            child: Scaffold(
              body: Center(
                child: MentorXIconButton(
                  icon: Icons.add,
                  onPressed: () {
                    tapped = true;
                  },
                ),
              ),
            ),
          ),
        ),
      );

      // Find by icon to ensure we hit the center of the widget
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();
      expect(tapped, isTrue);
    });
  });
}
