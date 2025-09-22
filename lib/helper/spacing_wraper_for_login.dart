import 'package:flutter/material.dart';

class SpacingWrapper extends StatelessWidget {
  const SpacingWrapper({
    super.key,
    required this.child,
    this.heightFactor = 0.5,
    this.widthFactor = 0.7,
    this.backgroundColor = Colors.lightBlue,
    this.borderRadius = 10,
    this.padding = const EdgeInsets.all(24.0),
  });

  final Widget child;
  final double heightFactor;
  final double widthFactor;
  final Color backgroundColor;
  final double borderRadius;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Container(
            height: screenHeight * heightFactor,
            width: screenWidth * widthFactor,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              color: backgroundColor,
            ),
            child: Padding(
              padding: padding,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
