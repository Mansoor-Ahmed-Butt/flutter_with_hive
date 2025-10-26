import 'package:flutter/material.dart';



// Templates Screen (Placeholder)
class TemplatesScreen extends StatelessWidget {
  const TemplatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0A0E27), Color(0xFF1A1F3A), Color(0xFF2D1B69)],
        ),
      ),
      child: const Center(
        child: Text('Templates Screen', style: TextStyle(color: Colors.white, fontSize: 24)),
      ),
    );
  }
}