import 'package:flutter/material.dart';

class ExampleNetworkImage extends StatelessWidget {
  const ExampleNetworkImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      'https://testimages.org/img/testimages_screenshot.jpg',
    );
  }
}
