import 'package:flutter/material.dart';

class AnimatedTextShader extends StatefulWidget {
  /// The text you want to display.
  final String text;

  /// The text style (default: white, 26px bold).
  final TextStyle? style;

  /// The first color in the gradient animation.
  final Color beginColor1;

  /// The end color for the first gradient color.
  final Color endColor1;

  /// The first color in the second gradient animation.
  final Color beginColor2;

  /// The end color for the second gradient color.
  final Color endColor2;

  /// Animation duration (default: 4 seconds)
  final Duration duration;

  const AnimatedTextShader({
    super.key,
    required this.text,
    this.style,
    this.beginColor1 = Colors.purple,
    this.endColor1 = Colors.pinkAccent,
    this.beginColor2 = Colors.blue,
    this.endColor2 = Colors.orange,
    this.duration = const Duration(seconds: 4),
  });

  @override
  State<AnimatedTextShader> createState() => _AnimatedTextShaderState();
}

class _AnimatedTextShaderState extends State<AnimatedTextShader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> color1;
  late Animation<Color?> color2;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: widget.duration)
          ..repeat(reverse: true);

    color1 = ColorTween(begin: widget.beginColor1, end: widget.endColor1)
        .animate(_controller);
    color2 = ColorTween(begin: widget.beginColor2, end: widget.endColor2)
        .animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return ShaderMask(
          shaderCallback: (bounds) => LinearGradient(
            colors: [color1.value!, color2.value!],
          ).createShader(bounds),
          child: Text(
            widget.text,
            style: widget.style ??
                const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
          ),
        );
      },
    );
  }
}
