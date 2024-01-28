import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:carcreator/pages/home.dart';

void main() {
  testWidgets('HomePage widget test', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: HomePage(),
    ));

    expect(
        find.byIcon(
          Icons.directions_car,
        ),
        findsOneWidget);

    expect(find.byKey(const Key('app_name')), findsOneWidget);

    expect(find.byKey(const Key('chessboard')), findsOneWidget);

    expect(find.byKey(const Key('left_circle')), findsOneWidget);

    expect(find.byKey(const Key('right_circle')), findsOneWidget);

    expect(find.byKey(const Key('main_section')), findsOneWidget);

    expect(find.byKey(const Key('collection_button')), findsOneWidget);

    expect(find.byKey(const Key('create_a_car_button')), findsOneWidget);
  });
}
