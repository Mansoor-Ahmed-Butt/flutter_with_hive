import 'package:flutter/material.dart';

class CustomToolTip extends StatefulWidget {
  final String? message; // plain text
  final InlineSpan? richMessage; // rich text
  final Widget child;

  // Extra params
  final double verticalOffset;
  final bool preferBelow;
  final Duration showDuration;
  final Duration waitDuration;
  final TextStyle? textStyle;

  const CustomToolTip({
    super.key,
    this.message,
    this.richMessage,
    required this.child,
    this.verticalOffset = 24.0,
    this.preferBelow = true,
    this.showDuration = const Duration(seconds: 2),
    this.waitDuration = const Duration(milliseconds: 0),
    this.textStyle,
  }) : assert(
          message != null || richMessage != null,
          'Either message or richMessage must be provided',
        );

  @override
  State<CustomToolTip> createState() => _CustomToolTipState();
}

class _CustomToolTipState extends State<CustomToolTip> with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: widget.message,
      richMessage: widget.richMessage,
      verticalOffset: widget.verticalOffset,
      preferBelow: widget.preferBelow,
      showDuration: widget.showDuration,
      waitDuration: widget.waitDuration,
      textStyle: widget.textStyle, // forward it
      child: widget.child,
    );
  }
}
