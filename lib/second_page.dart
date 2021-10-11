import 'package:flutter/material.dart';

class ImageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InteractiveViewer(
            minScale: 0.1,
            maxScale: 1.5,
            child: Image.asset('assets/image.jpg')),
      ),
    );
  }
}
