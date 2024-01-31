import 'package:carcreator/pages/carColorSelection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:carcreator/pages/soundSelection.dart';
import 'package:carcreator/models/Car.dart';


void main() {
  testWidgets('next button test',
          (WidgetTester tester) async {
        final car = Car(name: 'Test Car', type: 'assets/graphics/Car1.svg');

        await tester.pumpWidget(
          MaterialApp(
            home: SoundSelection(ourCar: car),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.byType(InkWell), findsNWidgets(4));

        await tester.tap(find.byType(InkWell).at(0));
        await tester.pump();

        expect(find.byWidgetPredicate((widget) => widget is Icon && widget.icon == Icons.volume_up), findsOneWidget);
        expect(find.byType(ElevatedButton), findsOneWidget);

        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        expect(find.byType(CarColorSelection), findsOneWidget);
      });

  testWidgets('button select test',
          (WidgetTester tester) async {
        final car = Car(name: 'Test Car', type: 'assets/graphics/Car1.svg');

        await tester.pumpWidget(
          MaterialApp(
            home: SoundSelection(ourCar: car),
          ),
        );

        await tester.pumpAndSettle();

        await tester.tap(find.byType(InkWell).at(0));
        await tester.pump();

        expect(find.byWidgetPredicate((widget) => widget is Icon && widget.icon == Icons.volume_up), findsOneWidget);
      });

  testWidgets('next button disabled when no sound is selected test',
          (WidgetTester tester) async {
        final car = Car(name: 'Test Car', type: 'assets/graphics/Car1.svg');

        await tester.pumpWidget(
          MaterialApp(
            home: SoundSelection(ourCar: car),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.byType(ElevatedButton), findsOneWidget);
        final elevatedButton = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
        expect(elevatedButton.enabled, isFalse);
      });
}
