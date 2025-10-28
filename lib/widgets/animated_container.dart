import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedGradientButton extends StatelessWidget {
  /// Duration of the animation.
  final Duration duration;

  /// Gradient background for the button.
  final Gradient gradient;

  /// The accent color used for shadow.
  final Color accentColor;

  /// The text displayed on the button.
  final String label;

  /// Icon to display at the end (optional).
  final IconData? icon;

  /// Tap callback.
  final VoidCallback onTap;

  /// Button height.
  final double height;

  /// Corner radius.
  final double borderRadius;

  /// Text style.
  final TextStyle? textStyle;

  const AnimatedGradientButton({
    super.key,
    required this.gradient,
    required this.accentColor,
    required this.label,
    required this.onTap,
    this.duration = const Duration(milliseconds: 300),
    this.height = 60,
    this.borderRadius = 20,
    this.icon,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: duration,
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [BoxShadow(color: accentColor.withValues(alpha: 0.4), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: onTap,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label,
                  style: textStyle ?? const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                if (icon != null) ...[const SizedBox(width: 8), Icon(icon, color: Colors.white, size: 24.r)],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
