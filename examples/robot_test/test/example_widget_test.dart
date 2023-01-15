import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:robot_test/robot_test.dart';
import 'package:robot_test_examples/example_widget.dart';

void main() {
  robotTest(
    'expect text with key',
    Robot.new,
    expect: (robot) => find.byKey(const Key('test')),
  );
}

/// Robot for the [ExampleWidget].
class Robot extends TestRobot {
  Robot(super.tester);

  @override
  Widget get testWidget => const ExampleWidget();
}
