import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:robot_test/robot_test.dart';
import 'package:robot_test_bloc/robot_test_bloc.dart';
import 'package:robot_test_with_bloc_examples/example_widget.dart';

void main() {
  robotTest(
    'expect text with key',
    Robot.new,
    expect: (robot) => find.byKey(const Key('test')),
  );
}

/// Robot for the [ExampleWidget].
class Robot extends TestRobot with TestRobotBloc {
  Robot(super.tester);

  @override
  List<BlocProvider> get blocProviders => [];

  @override
  Widget get testWidget => const ExampleWidget();
}
