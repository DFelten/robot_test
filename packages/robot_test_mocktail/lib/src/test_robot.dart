import 'package:flutter/material.dart';
import 'package:mocktail_image_network/mocktail_image_network.dart' as mocktail;
import 'package:robot_test/robot_test.dart' as robot_test;

/// Abstract class for the test robot. With its help, tests can be standardized
/// and simplified.
///
/// The helper method robotTest should be used together with the robot.
///
/// The method [configureDependencies] is called directly when the robot
/// is built.
abstract class TestRobot extends robot_test.TestRobot {
  TestRobot(super.tester);

  /// Mocks network images with Mocktail.
  bool mockNetworkImages = true;

  @override
  Future<void> pumpApp({Widget? child, Size? displaySize}) => mockNetworkImages
      ? mocktail.mockNetworkImages(
          () => super.pumpApp(
            child: child,
            displaySize: displaySize,
          ),
        )
      : super.pumpApp(
          child: child,
          displaySize: displaySize,
        );
}
