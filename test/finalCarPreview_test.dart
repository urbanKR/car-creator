import 'package:carcreator/pages/carColorSelection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:carcreator/pages/finalCarPreview.dart';
import 'package:carcreator/models/Car.dart';


void main() {
  testWidgets('FinalCarPreview displays car and navigates on button press',
          (WidgetTester tester) async {
        final car = Car(name: 'Test Car', type: 'assets/graphics/Car1.svg');

        await tester.pumpWidget(
          MaterialApp(
            home: FinalCarPreview(ourCar: car),
          ),
        );

        await tester.pumpAndSettle();

        expect(find.byType(SvgPicture), findsOneWidget);

        await tester.tap(find.byType(ElevatedButton));
        await tester.pumpAndSettle();

        expect(find.byType(CarColorSelection), findsOneWidget);
      });

  testWidgets('FinalCarPreview shows progress indicator on button press',
          (WidgetTester tester) async {
        final car = Car(name: 'Test Car', type: 'assets/graphics/Car1.svg');

        await tester.pumpWidget(
          MaterialApp(
            home: FinalCarPreview(ourCar: car),
          ),
        );

        await tester.pumpAndSettle();

        await tester.tap(find.byType(ElevatedButton));
        await tester.pump();

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      });
}
