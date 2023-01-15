import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_test/flutter_test.dart' as flutter_test;
import 'package:meta/meta.dart';
import 'package:robot_test/src/util/test_robot.dart';

typedef RobotTestCallback<T> = FutureOr<dynamic> Function(T robot);

typedef RobotTestWidgetCallback<T> = FutureOr<Widget> Function(T robot);

/// Runs the robot test inside the Flutter test environment.
@isTest
void robotTest<T extends TestRobot>(
  String description,
  T Function(WidgetTester tester) robot, {
  RobotTestCallback<T>? test,
  RobotTestCallback<T>? setUp,
  RobotTestWidgetCallback<T>? build,
  RobotTestCallback<T>? act,
  RobotTestCallback<T>? expect,
  RobotTestCallback<T>? expectNever,
  RobotTestCallback<T>? verify,
  RobotTestCallback<T>? verifyNever,
  RobotTestCallback<T>? tearDown,
  Size? displaySize,
  TestVariant<Object?> variant = const DefaultTestVariant(),
}) {
  testWidgets(
    description,
    (WidgetTester tester) async {
      final T testRobot = robot(tester);

      if (test != null) {
        assert(
          setUp == null ||
              build == null ||
              act == null ||
              expect == null ||
              expectNever == null ||
              verifyNever == null ||
              verify == null,
          'If using test all other calls must be null',
        );

        return test.call(testRobot);
      }

      await setUp?.call(testRobot);

      await testRobot.pumpApp(
        child: await build?.call(testRobot),
        displaySize: displaySize,
      );

      await act?.call(testRobot);

      await _expect<T>(testRobot, expect, findsOneWidget);
      await _expect<T>(testRobot, expectNever, findsNothing);

      verify?.call(testRobot);

      verifyNever?.call(testRobot);

      tearDown?.call(testRobot);
      testRobot.tearDown();
    },
    variant: variant,
  );
}

/// Executes the expect and checks before whether it is a list or
/// a single object. If it is neither, the expect will only be executed.
Future<void> _expect<T>(
  T testRobot,
  RobotTestCallback<T>? expect,
  dynamic matcher,
) async {
  if (expect != null) {
    final dynamic result = await expect.call(testRobot);

    if (result is List) {
      for (final dynamic entry in result) {
        flutter_test.expect(entry, matcher);
      }
    } else if (result is Finder) {
      flutter_test.expect(result, matcher);
    }
  }
}
