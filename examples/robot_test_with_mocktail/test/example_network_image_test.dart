import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:robot_test_mocktail/robot_test_mocktail.dart';
import 'package:robot_test_with_mocktail_examples/example_network_image.dart';

void main() {
  robotTest(
    'expect to find an image',
    Robot.new,
    expect: (robot) => find.byType(Image),
  );
}

/// Robot for the [ExampleNetworkImage].
class Robot extends TestRobot {
  Robot(super.tester);

  @override
  Widget get testWidget => const ExampleNetworkImage();
}
