import 'package:flutter/material.dart';

class GradientPrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final IconData? icon;
  final List<Color> colors;
  final double borderRadius;
  final EdgeInsetsGeometry padding;
  final double? width;

  const GradientPrimaryButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.colors = const [Color(0xFF6366F1), Color(0xFF8B5CF6), Color(0xFFEC4899)],
    this.borderRadius = 16,
    this.padding = const EdgeInsets.symmetric(vertical: 18),
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: colors),
        boxShadow: [BoxShadow(color: const Color(0xFF6366F1).withValues(alpha: 0.4), blurRadius: 20, offset: const Offset(0, 8))],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          shadowColor: Colors.transparent,
          padding: padding,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[Icon(icon, size: 22), const SizedBox(width: 10)],
            Text(text, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, letterSpacing: 0.3)),
          ],
        ),
      ),
    );
  }
}
