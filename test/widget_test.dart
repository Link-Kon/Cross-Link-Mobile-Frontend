// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:cross_link/src/domain/repositories/gyro_info_api_repository.dart';
import 'package:cross_link/src/domain/repositories/heart_info_api_repository.dart';
import 'package:cross_link/src/domain/repositories/user_api_repository.dart';
import 'package:cross_link/src/locator.dart';
import 'package:cross_link/src/presentation/cubits/gyro_info/gyro_info_cubit.dart';
import 'package:cross_link/src/presentation/cubits/heart_info/heart_info_cubit.dart';
import 'package:cross_link/src/presentation/cubits/user/user_cubit.dart';
import 'package:cross_link/src/presentation/cubits/wearable/wearable_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cross_link/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    WearableCubit wearableCubit = WearableCubit();
    GyroInfoCubit gyroInfoCubit = GyroInfoCubit(locator<GyroInfoApiRepository>(),);
    HeartInfoCubit heartInfoCubit = HeartInfoCubit(locator<HeartInfoApiRepository>(),);
    UserCubit userCubit = UserCubit(
      locator<UserApiRepository>(),
    );

    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp(wearableCubit: wearableCubit, gyroInfoCubit: gyroInfoCubit, heartInfoCubit: heartInfoCubit, userCubit: userCubit, token: '',));

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
