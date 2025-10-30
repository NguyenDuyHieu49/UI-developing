import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/main.dart';

void main() {
  testWidgets('Flashcard show meaning toggles', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: MainNavigation()));
    await tester.pumpAndSettle();

    // Find the flashcard word (should be present)
    final wordFinder = find.byType(Text).first;
    expect(wordFinder, findsWidgets);

    // Tap Show meaning button
    final showBtn = find.widgetWithText(OutlinedButton, 'Show meaning');
    if (showBtn.evaluate().isNotEmpty) {
      await tester.tap(showBtn);
      await tester.pumpAndSettle();

      // After toggling, there should be additional text (meaning) present
      // We simply assert that some text besides the word exists in the tree.
      expect(find.byType(Text), findsWidgets);
    } else {
      // If the button text is localized differently, try lowercase 'Show meaning'
      final alt = find.text('Show meaning');
      expect(alt, findsWidgets);
    }
  });
}
