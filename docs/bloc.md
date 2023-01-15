# Robot Test with Bloc

RobotTest supports [Bloc](https://pub.dev/packages/bloc) with an additional package to wrap test widgets more easily with BlocProviders.

## Installation

For RobotTest with Bloc add additionally the following to your `pubspec.yaml`:

```yaml
dev_dependencies:
  ...
  robot_test_bloc: ^[version]
```

## Usage

Use the `TestRobotBloc` mixin the `TestRobot` like this:

```dart
class Robot extends TestRobot with TestRobotBloc {
  Robot(super.tester);

  @override
  List<BlocProvider> get blocProviders => [];
  
  @override
  Widget get testWidget => const ExampleWidget();
}
```

There is an [example]([https://](https://github.com/DFelten/robot_test/tree/main/examples/robot_test_with_bloc)) for the usage of Bloc with RobotTest.
