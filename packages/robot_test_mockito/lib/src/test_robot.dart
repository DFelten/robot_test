import 'package:flutter/material.dart';
import 'package:robot_test/robot_test.dart' as robot_test;
import 'package:robot_test_mockito/src/mocks/mocks.mocks.dart';
import 'package:robot_test_mockito/src/mocks/network_image_mock.dart'
    as network_image_mock;

///
abstract class TestRobot extends robot_test.TestRobot {
  TestRobot(super.tester);

  /// Mocks network images with Mockito.
  bool mockNetworkImages = true;

  late MockHttpClient mockHttpClient;

  @override
  Future<void> pumpApp({Widget? child, Size? displaySize}) {
    if (mockNetworkImages) {
      return network_image_mock.mockNetworkImages(
        () => super.pumpApp(
          child: child,
          displaySize: displaySize,
        ),
      );
    }

    return super.pumpApp(
      child: child,
      displaySize: displaySize,
    );
  }
}
