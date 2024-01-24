import 'package:carcreator/pages/carTypeSelection.dart';
import 'package:carcreator/pages/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:carcreator/pages/home.dart';

void main() {
  testWidgets('HomePage widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(
      home: HomePage(),
    ));

    // Verify that logo icon is present.
    expect(
        find.byIcon(
          Icons.directions_car,
        ),
        findsOneWidget);

    // Verify that app name is present.
    expect(find.byKey(const Key('app_name')), findsOneWidget);

    // Verify that the chessboard pattern is present.
    expect(find.byKey(const Key('chessboard')), findsOneWidget);

    // Verify that left circle widget is present.
    expect(find.byKey(const Key('left_circle')), findsOneWidget);

    // Verify that right circle widget is present.
    expect(find.byKey(const Key('right_circle')), findsOneWidget);

    // Verify that main section is present.
    expect(find.byKey(const Key('main_section')), findsOneWidget);

    // Verify that collection button is present.
    expect(find.byKey(const Key('collection_button')), findsOneWidget);

    // Verify that create a car button is present.
    expect(find.byKey(const Key('create_a_car_button')), findsOneWidget);
  });
}
