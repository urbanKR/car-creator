import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:carcreator/pages/collection.dart';
import 'package:carcreator/models/Car.dart';
import 'package:carcreator/database_helper.dart';
import 'package:mockito/mockito.dart';

class MockDatabase extends Mock implements CarsDatabase {}

void main() {


  testWidgets('collection items display test', (WidgetTester tester) async {
    final database = MockDatabase();
    final car = Car(name: 'Test Car', type: 'assets/graphics/Car1.svg');
    when(database.readAllCars()).thenAnswer((_) => Future.delayed(const Duration(seconds: 2), () => [car]));

    await tester.pumpWidget(
      const MaterialApp(
        home: Collection(),
      ),
    );

    await tester.pumpAndSettle();
    expect(find.text('Test Car'), findsOneWidget);
    expect(find.byWidgetPredicate((widget) => widget is SvgPicture), findsOneWidget);
  });

}
