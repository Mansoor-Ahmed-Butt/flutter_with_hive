import 'package:flutter/material.dart';
import 'package:flutter_with_hive/core/constants.dart';
import 'package:flutter_with_hive/core/themes.dart';
import 'package:flutter_with_hive/view/home_page/main_home_screen_controller.dart';
import 'package:flutter_with_hive/widgets/text/app_style.dart';
import 'package:get/get.dart';

// Main Screen with Bottom Navigation
class MainHomeScreen extends StatelessWidget {
  const MainHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MainHomeScreenController mainHomeScreenController = Get.put(MainHomeScreenController());

    return Scaffold(
      extendBody: true,
      body: Obx(() => mainHomeScreenController.screens[mainHomeScreenController.currentIndex.value]),
      bottomNavigationBar: Obx(() {
        // Hide bottom bar when index is 3
        if (mainHomeScreenController.currentIndex.value == 2) {
          return const SizedBox.shrink(); // hides it completely
        }
        return _buildFloatingNavBar(mainHomeScreenController);
      }),
      //bottomNavigationBar: Obx(() => _buildFloatingNavBar(mainHomeScreenController)),
    );
  }

  Widget _buildFloatingNavBar(MainHomeScreenController controller) {
    return Container(
      margin: EdgeInsets.all(20.r),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [AppColors.bottomNavColor1.withValues(alpha: 0.95), AppColors.bottomNavColor2.withValues(alpha: 0.95)]),
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [
          BoxShadow(color: AppColors.bottomNavShadowColor1.withValues(alpha: 0.3), blurRadius: 30, offset: const Offset(0, 10)),
          BoxShadow(color: AppColors.bottomNavShadowColor2.withValues(alpha: 0.5), blurRadius: 20, offset: const Offset(0, 5)),
        ],
        border: Border.all(color: AppColors.whiteColor.withValues(alpha: 0.1), width: 1.5.h),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(0, Icons.home_rounded, 'Home', controller),
          _buildNavItem(1, Icons.grid_view_rounded, 'Templates', controller),
          _buildCenterCreateButton(),
          _buildNavItem(2, Icons.folder_open_rounded, 'My CVs', controller),
          _buildNavItem(3, Icons.person_rounded, 'Profile', controller),
        ],
      ),
    );
  }

  Widget _buildCenterCreateButton() {
    return Container(
      width: 60.w,
      height: 60.h,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.bottomNavCenterButtonColor1, AppColors.bottomNavCenterButtonColor2, AppColors.bottonNavCenterButtonColor3],
        ),
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: AppColors.bottomNavCenterButtonShadowColor1.withValues(alpha: 0.6), blurRadius: 20, spreadRadius: 2)],
      ),
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30.r),
          onTap: () {},
          child: Icon(Icons.add_rounded, color: Colors.white, size: 32.r),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label, MainHomeScreenController controller) {
    final isSelected = controller.currentIndex.value == index;

    return GestureDetector(
      onTap: () => controller.changePage(index),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: isSelected ? 1 : 0),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        builder: (context, value, child) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              gradient: value > 0
                  ? LinearGradient(
                      colors: [
                        Color.lerp(AppColors.transparent, AppColors.bottomNavCenterButtonColor1, value)!.withValues(alpha: 0.2),
                        Color.lerp(AppColors.transparent, AppColors.bottomNavCenterButtonColor2, value)!.withValues(alpha: 0.2),
                      ],
                    )
                  : null,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: Color.lerp(AppColors.bottomNavIconColor1, AppColors.bottomNavIconColor2, value), size: 26),
                const SizedBox(height: 4),
                if (value > 0.3)
                  Opacity(
                    opacity: value,
                    child: Text(label, style: AppStyle.style11w600(color: Color.lerp(AppColors.transparent, AppColors.bottomNavIconColor2, value))),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
