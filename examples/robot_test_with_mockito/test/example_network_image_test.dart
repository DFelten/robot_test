import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:robot_test_mockito/robot_test_mockito.dart';
import 'package:robot_test_with_mockito_examples/example_network_image.dart';

void main() {
  robotTest(
    'expect to find an image',
    Robot.new,
    act: (robot) => robot.tester.pumpAndSettle(),
    expect: (robot) => find.byType(Image),
  );
}

/// Robot for the [ExampleNetworkImage].
class Robot extends TestRobot {
  Robot(super.tester);

  @override
  Widget get testWidget => const ExampleNetworkImage();
}
