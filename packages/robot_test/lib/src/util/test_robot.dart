import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:robot_test/src/widgets/test_app.dart';

/// Abstract class for the test robot. With its help, tests can be standardized
/// and simplified.
///
/// The helper method robotTest should be used together with the robot.
///
/// The method [configureDependencies] is called directly when the robot
/// is built.
abstract class TestRobot {
  TestRobot(this.tester) {
    configureDependencies();
  }

  /// Tester for interacting with widgets.
  final WidgetTester tester;

  /// The context of the TestApp.
  late BuildContext context;

  /// The widget that will be tested in the test.
  Widget get testWidget;

  /// Configures dependencies for the test. This method is called directly
  /// when the robot is built.
  void configureDependencies() {}

  /// Tear down method which is called after each test.
  void tearDown() {}

  /// List of LocalizationsDelegate for the TestApp.
  List<LocalizationsDelegate<dynamic>> get localizationsDelegates => [];

  /// The widget that will be tested in the test.
  Widget testApp({required Widget child, Size? displaySize}) => TestApp(
        tester: tester,
        localizationsDelegates: localizationsDelegates,
        child: child,
      );

  /// Pumps a test app with default values.
  /// Optionally, a child can be passed in, otherwise the [testWidget] is built.
  Future<void> pumpApp({Widget? child, Size? displaySize}) async {
    await tester.pumpWidget(
      testApp(
        displaySize: displaySize,
        child: Builder(
          builder: (testContext) {
            context = testContext;

            return child ?? testWidget;
          },
        ),
      ),
    );
  }
}
