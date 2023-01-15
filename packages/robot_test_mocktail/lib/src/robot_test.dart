import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meta/meta.dart';
import 'package:mocktail/mocktail.dart' as mocktail;
import 'package:robot_test/robot_test.dart';
import 'package:robot_test/robot_test.dart' as robot_test;

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
  robot_test.robotTest(
    description,
    robot,
    test: test,
    setUp: setUp,
    build: build,
    act: act,
    expect: expect,
    expectNever: expectNever,
    tearDown: tearDown,
    displaySize: displaySize,
    variant: variant,
    verify: (robot) => _verify(robot, verify),
    verifyNever: (robot) => _verifyNever(robot, verify),
  );
}

/// Verify that provided verifyCall method on a mock object was called
/// with the given arguments.
Future<void> _verify<T>(T testRobot, RobotTestCallback<T>? verifyCall) async {
  if (verifyCall != null) {
    mocktail.verify(() => verifyCall.call(testRobot));
  }
}

/// Verify that provided verifyCall method on a mock object was never called
/// with the given arguments.
Future<void> _verifyNever<T>(
  T testRobot,
  RobotTestCallback<T>? verifyNeverCall,
) async {
  if (verifyNeverCall != null) {
    mocktail.verifyNever(() => verifyNeverCall.call(testRobot));
  }
}
