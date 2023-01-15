import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:robot_test/robot_test.dart';

/// Mixin for wrapping the app of [TestRobot] with a list of BlocProviders.
mixin TestRobotBloc on TestRobot {
  /// List of BlocProvider, which are placed around the entire TestApp.
  List<BlocProvider> get blocProviders => [];

  /// Wraps the test app with a list of BlocProviders.
  @override
  Widget testApp({required Widget child, Size? displaySize}) {
    return _BlocProviderWrapper(
      blocProviders: blocProviders,
      child: super.testApp(
        child: child,
        displaySize: displaySize,
      ),
    );
  }
}

/// Wraps the test app with a list of BlocProviders if the list is not empty.
/// Otherwise, returns the child.
class _BlocProviderWrapper extends StatelessWidget {
  const _BlocProviderWrapper({
    required this.child,
    required this.blocProviders,
  });

  /// Child of the BlocProvider.
  final Widget child;

  /// List of BlocProvider, which are placed around the entire TestApp.
  final List<BlocProvider> blocProviders;

  @override
  Widget build(BuildContext context) {
    return blocProviders.isNotEmpty
        ? MultiBlocProvider(
            providers: blocProviders,
            child: child,
          )
        : child;
  }
}
