import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class TestRobotApp extends StatefulWidget {
  const TestRobotApp({
    required this.child,
    required this.tester,
    this.displaySize,
    required this.localizationsDelegates,
    super.key,
  });

  /// The widget to be tested. This is loaded into the app as Home.
  final Widget child;

  /// Widget tester for manipulating display size.
  final WidgetTester tester;

  /// Size for define the surface size.
  final Size? displaySize;

  /// Localization delegates for providing localizations.
  final List<LocalizationsDelegate<dynamic>>? localizationsDelegates;

  @override
  State<TestRobotApp> createState() => _TestRobotAppState();
}

class _TestRobotAppState extends State<TestRobotApp> {
  @override
  void initState() {
    widget.tester.binding.setSurfaceSize(widget.displaySize);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: widget.localizationsDelegates,
      home: widget.child,
    );
  }

  /// Set the surface size to the default size when the widget is disposed.
  @override
  void dispose() {
    widget.tester.binding.setSurfaceSize(null);
    super.dispose();
  }
}
