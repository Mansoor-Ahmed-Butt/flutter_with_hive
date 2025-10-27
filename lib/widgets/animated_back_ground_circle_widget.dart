import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_with_hive/core/themes.dart';

class CustomBgAnimatedWidget extends StatelessWidget {
  const CustomBgAnimatedWidget({
    super.key,
    required this.rotationController,
    this.top = -100,
    this.right = -100,
    this.width = 300,
    this.height = 300,
    this.color = const Color(0xFF6366F1),
    this.opacity = 0.15,
    this.clockwise = true,
  });

  final AnimationController rotationController;
  final double top;
  final double right;
  final double width;
  final double height;
  final Color color;
  final double opacity;
  final bool clockwise;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: rotationController,
      builder: (context, child) {
        return Positioned(
          top: top,
          right: right,
          child: Transform.rotate(
            angle: (clockwise ? 1 : -1) * rotationController.value * 2 * math.pi,
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    color.withValues(alpha: opacity),
                    AppColors.transparent,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
