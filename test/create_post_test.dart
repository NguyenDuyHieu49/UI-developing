import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile/main.dart';

void main() {
  testWidgets('Creating a post adds it to the feed', (tester) async {
    // pump a MaterialApp with the MainNavigation as home so we land on the feed
    await tester.pumpWidget(const MaterialApp(home: MainNavigation()));
    await tester.pumpAndSettle();

    // tap the create button in the app bar
    final createButton = find.byIcon(Icons.create);
    expect(createButton, findsOneWidget);
    await tester.tap(createButton);
    await tester.pumpAndSettle();

    // enter text into the post text field
    final postField = find.byType(TextField).first;
    await tester.enterText(postField, 'Test post from widget test');

    // submit by tapping Post (ElevatedButton)
    final postButton = find.widgetWithText(ElevatedButton, 'Post');
    expect(postButton, findsOneWidget);
    await tester.tap(postButton);

    await tester.pumpAndSettle();

    // check that a new post with our content appears in the feed
    expect(find.text('Test post from widget test'), findsOneWidget);
  });
}
