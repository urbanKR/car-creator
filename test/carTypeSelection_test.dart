import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:carcreator/pages/carTypeSelection.dart';

void main() {
  testWidgets('Buttons test', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: CarTypeSelection(),
      ),
    );

    expect(find.byType(InkWell), findsNWidgets(6));
  });

  testWidgets('Selected car index update', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: CarTypeSelection(),
      ),
    );

    await tester.tap(find.byType(InkWell).first);
    await tester.pump();

    CarTypeSelectionState state = tester.state(find.byType(CarTypeSelection));
    expect(state.selectedButtonIndex, 0);
  });
}
