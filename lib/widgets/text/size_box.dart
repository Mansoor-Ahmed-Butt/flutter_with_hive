import 'package:flutter/material.dart';

class SizedH extends StatelessWidget {
  const SizedH(
    this.height, {
    super.key,
  });
  final double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}

class SizedW extends StatelessWidget {
 const SizedW(
    this.width, {
    super.key,
  });
  final double width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
    );
  }
}
