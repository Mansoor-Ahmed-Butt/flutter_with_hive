import 'package:flutter/material.dart';
import 'package:flutter_with_hive/core/constants.dart';
import 'package:flutter_with_hive/core/themes.dart';

// Custom Bottom Navigation Bar Widget
class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final Color backgroundColor;
  final Color selectedColor;
  final Color unselectedColor;
  final List<BottomNavItem> items;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.backgroundColor = const Color(0xFF1A1A2E),
    this.selectedColor = const Color(0xFF4A90E2),
    this.unselectedColor = const Color(0xFF6B7280),
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: backgroundColor,
        boxShadow: [BoxShadow(color: AppColors.blackColor.withValues(alpha: 0.3), blurRadius: 20, offset: const Offset(0, -5))],
      ),
      child: SafeArea(
        top: false,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: List.generate(items.length, (index) => _buildNavItem(index))),
      ),
    );
  }

  Widget _buildNavItem(int index) {
    final isSelected = currentIndex == index;
    final item = items[index];

    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? selectedColor.withValues(alpha: 0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: isSelected ? LinearGradient(colors: [selectedColor, selectedColor.withValues(alpha: 0.7)]) : null,
                borderRadius: BorderRadius.circular(12),
                boxShadow: isSelected ? [BoxShadow(color: selectedColor.withValues(alpha: 0.4), blurRadius: 12, offset: const Offset(0, 4))] : null,
              ),
              child: Icon(item.icon, color: isSelected ? Colors.white : unselectedColor, size: 24),
            ),
            const SizedBox(height: 4),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: TextStyle(
                color: isSelected ? selectedColor : unselectedColor,
                fontSize: isSelected ? 12 : 11,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
              child: Text(item.label),
            ),
          ],
        ),
      ),
    );
  }
}

// Bottom Nav Item Model
class BottomNavItem {
  final IconData icon;
  final String label;

  BottomNavItem({required this.icon, required this.label});
}

// Alternative Style 1: Floating Style with Center Button
class FloatingBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final Color backgroundColor;
  final Color selectedColor;
  final Color unselectedColor;
  final List<BottomNavItem> items;

  const FloatingBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.backgroundColor = const Color(0xFF1A1A2E),
    this.selectedColor = const Color(0xFF4A90E2),
    this.unselectedColor = const Color(0xFF6B7280),
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      height: 75.h,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [BoxShadow(color: AppColors.blackColor.withValues(alpha: 0.3), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: List.generate(items.length, (index) => _buildNavItem(index))),
    );
  }

  Widget _buildNavItem(int index) {
    final isSelected = currentIndex == index;
    final item = items[index];

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        child: Container(
          color: Colors.transparent,
          padding: const EdgeInsets.only(top: 11),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: isSelected ? 1 : 0),
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: 1 + (value * 0.2),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: value > 0
                            ? LinearGradient(
                                colors: [
                                  selectedColor.withValues(alpha: value),
                                  selectedColor.withValues(alpha: value * 0.7),
                                ],
                              )
                            : null,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: value > 0
                            ? [
                                BoxShadow(
                                  color: selectedColor.withValues(alpha: 0.4 * value),
                                  blurRadius: 12 * value,
                                  offset: Offset(0, 4 * value),
                                ),
                              ]
                            : null,
                      ),
                      child: Icon(item.icon, color: Color.lerp(unselectedColor, Colors.white, value), size: 24),
                    ),
                  );
                },
              ),
              const SizedBox(height: 4),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                style: TextStyle(
                  color: isSelected ? selectedColor : unselectedColor,
                  fontSize: isSelected ? 12 : 11,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
                child: Text(item.label),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Alternative Style 2: Minimal with Indicator
class MinimalBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final Color backgroundColor;
  final Color selectedColor;
  final Color unselectedColor;
  final List<BottomNavItem> items;

  const MinimalBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.backgroundColor = const Color(0xFF1A1A2E),
    this.selectedColor = const Color(0xFF4A90E2),
    this.unselectedColor = const Color(0xFF6B7280),
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border(top: BorderSide(color: AppColors.whiteColor.withValues(alpha: 0.1), width: 1)),
      ),
      child: SafeArea(
        top: false,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: List.generate(items.length, (index) => _buildNavItem(index))),
      ),
    );
  }

  Widget _buildNavItem(int index) {
    final isSelected = currentIndex == index;
    final item = items[index];

    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(index),
        child: Container(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(item.icon, color: isSelected ? selectedColor : unselectedColor, size: 26),
              const SizedBox(height: 4),
              Text(
                item.label,
                style: TextStyle(
                  color: isSelected ? selectedColor : unselectedColor,
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 3,
                width: isSelected ? 20 : 0,
                decoration: BoxDecoration(color: selectedColor, borderRadius: BorderRadius.circular(2)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchTab extends StatelessWidget {
  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Search Screen', style: TextStyle(color: Colors.white, fontSize: 24)),
    );
  }
}

class FavoriteTab extends StatelessWidget {
  const FavoriteTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Favorites Screen', style: TextStyle(color: Colors.white, fontSize: 24)),
    );
  }
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Profile Screen', style: TextStyle(color: Colors.white, fontSize: 24)),
    );
  }
}
