import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_with_hive/core/themes.dart';

// Animated Home Screen with Glassmorphism Premium Background
class AnimatedBgWrapper extends StatelessWidget {
  const AnimatedBgWrapper({super.key, this.child});
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        // Rich, vibrant gradient background
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1a0033), // Deep purple
            Color(0xFF0f0820), // Dark violet
            Color(0xFF1a1035), // Navy purple
            Color(0xFF0a0615), // Almost black purple
          ],
          stops: [0.0, 0.35, 0.65, 1.0],
        ),
      ),
      child: Stack(
        children: [
          // Large vibrant glow - top right
          Positioned(
            top: -250.h,
            right: -180.w,
            child: Container(
              width: 600.w,
              height: 600.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF6366F1).withValues(alpha: 0.35),
                    const Color(0xFF8B5CF6).withValues(alpha: 0.25),
                    const Color(0xFF6366F1).withValues(alpha: 0.15),
                    AppColors.transparent,
                  ],
                  stops: const [0.0, 0.3, 0.6, 1.0],
                ),
                boxShadow: [BoxShadow(color: const Color(0xFF6366F1).withValues(alpha: 0.3), blurRadius: 100, spreadRadius: 50)],
              ),
            ),
          ),

          // Bottom left pink/purple glow
          Positioned(
            bottom: -300.h,
            left: -200.w,
            child: Container(
              width: 700.w,
              height: 700.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFFEC4899).withValues(alpha: 0.3),
                    const Color(0xFFC026D3).withValues(alpha: 0.2),
                    const Color(0xFF8B5CF6).withValues(alpha: 0.1),
                    AppColors.transparent,
                  ],
                  stops: const [0.0, 0.4, 0.7, 1.0],
                ),
                boxShadow: [BoxShadow(color: const Color(0xFFEC4899).withValues(alpha: 0.25), blurRadius: 120, spreadRadius: 60)],
              ),
            ),
          ),

          // Center accent glow
          Positioned(
            top: MediaQuery.of(context).size.height * 0.4,
            right: -120.w,
            child: Container(
              width: 450.w,
              height: 450.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [const Color(0xFF10B981).withValues(alpha: 0.2), const Color(0xFF059669).withValues(alpha: 0.12), AppColors.transparent],
                  stops: const [0.0, 0.5, 1.0],
                ),
                boxShadow: [BoxShadow(color: const Color(0xFF10B981).withValues(alpha: 0.2), blurRadius: 80, spreadRadius: 30)],
              ),
            ),
          ),

          // Small accent glow - left middle
          Positioned(
            top: MediaQuery.of(context).size.height * 0.25,
            left: -80.w,
            child: Container(
              width: 300.w,
              height: 300.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [const Color(0xFFF59E0B).withValues(alpha: 0.15), const Color(0xFFEAB308).withValues(alpha: 0.08), AppColors.transparent],
                  stops: const [0.0, 0.5, 1.0],
                ),
              ),
            ),
          ),

          // Floating orbs with glow
          ...List.generate(5, (index) {
            final positions = [
              {'top': 150.0, 'left': 80.0, 'size': 120.0, 'color': const Color(0xFF6366F1)},
              {'top': 380.0, 'right': 60.0, 'size': 90.0, 'color': const Color(0xFFEC4899)},
              {'top': 580.0, 'left': 150.0, 'size': 70.0, 'color': const Color(0xFF8B5CF6)},
              {'top': 280.0, 'left': 280.0, 'size': 50.0, 'color': const Color(0xFF10B981)},
              {'top': 720.0, 'right': 180.0, 'size': 110.0, 'color': const Color(0xFFC026D3)},
            ];

            final pos = positions[index];
            return Positioned(
              top: pos['top'] as double,
              left: pos['left'] as double?,
              right: pos['right'] as double?,
              child: Container(
                width: pos['size'] as double,
                height: pos['size'] as double,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [(pos['color'] as Color).withValues(alpha: 0.15), (pos['color'] as Color).withValues(alpha: 0.05), AppColors.transparent],
                    stops: const [0.0, 0.5, 1.0],
                  ),
                ),
              ),
            );
          }),

          // Shimmer lines overlay
          Positioned.fill(child: CustomPaint(painter: ShimmerLinesPainter())),

          // Subtle noise texture overlay for realism
          Positioned.fill(
            child: Opacity(
              opacity: 0.03,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNk+M9QDwADhgGAWjR9awAAAABJRU5ErkJggg==',
                    ),
                    fit: BoxFit.cover,
                    repeat: ImageRepeat.repeat,
                  ),
                ),
              ),
            ),
          ),

          // Main Content
          SafeArea(child: child ?? Container()),
        ],
      ),
    );
  }
}

// Custom Painter for Shimmer Lines
class ShimmerLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Diagonal shimmer lines
    final lines = [
      {'start': Offset(0, size.height * 0.2), 'end': Offset(size.width * 0.3, 0), 'opacity': 0.08},
      {'start': Offset(size.width * 0.7, size.height), 'end': Offset(size.width, size.height * 0.8), 'opacity': 0.06},
      {'start': Offset(0, size.height * 0.6), 'end': Offset(size.width * 0.2, size.height * 0.4), 'opacity': 0.05},
    ];

    for (var line in lines) {
      paint.shader = LinearGradient(
        colors: [
          Colors.white.withValues(alpha: line['opacity'] as double),
          Colors.white.withValues(alpha: (line['opacity'] as double) * 0.3),
          AppColors.transparent,
        ],
        stops: const [0.0, 0.5, 1.0],
      ).createShader(Rect.fromPoints(line['start'] as Offset, line['end'] as Offset));

      canvas.drawLine(line['start'] as Offset, line['end'] as Offset, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
