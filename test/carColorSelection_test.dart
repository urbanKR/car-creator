import 'package:carcreator/pages/glassColorSelection.dart';
import 'package:carcreator/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:carcreator/pages/carColorSelection.dart';
import 'package:carcreator/models/Car.dart';

void main() {
  testWidgets('car preview test', (WidgetTester tester) async {
    final Car car = Car(type: 'assets/graphics/Car1.svg');

    await tester.pumpWidget(
      MaterialApp(
        home: CarColorSelection(ourCar: car),
      ),
    );
    expect(find.byType(SvgPicture), findsOneWidget);
  });

  testWidgets('color update test', (WidgetTester tester) async {
    final Car car = Car(type: 'assets/graphics/Car1.svg');

    await tester.pumpWidget(
      MaterialApp(
        home: CarColorSelection(ourCar: car),
      ),
    );

    await tester.tap(find.byType(GestureDetector).first);
    await tester.pump();

    expect(car.bodyColor, red);
  });

  testWidgets('navigation test', (WidgetTester tester) async {
    final Car car = Car(type: 'assets/graphics/Car1.svg');

    await tester.pumpWidget(
      MaterialApp(
        home: CarColorSelection(ourCar: car),
      ),
    );

    await tester.tap(find.byType(GestureDetector).first);
    await tester.pump();

    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    expect(find.byType(GlassColorSelection), findsOneWidget);
  });
}
