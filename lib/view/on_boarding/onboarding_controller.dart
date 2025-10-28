import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_with_hive/core/app_router.dart';
import 'package:flutter_with_hive/core/themes.dart';
import 'package:flutter_with_hive/helper/app_assets.dart';
import 'package:flutter_with_hive/view/on_boarding/onboarding_model.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';


// Onboarding Controller
class OnboardingController1 extends GetxController {
  var currentPage = 0.obs;
  final PageController pageController = PageController();

  void nextPage(BuildContext context) async {
    if (currentPage.value < 2) {
      await pageController.animateToPage(currentPage.value + 1, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    } else {
      context.go(RouteConfig.mainHomeScreen);
      // Hive.box('settings').put('onboarding_completed', true);

      Get.snackbar(
        'Welcome!',
        'You have completed the onboarding process',
        backgroundColor: AppColors.appGreenC,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(20.r),
        borderRadius: 10,
        duration: const Duration(seconds: 3),
      );
    }
  }

  void skipToEnd() async {
    // Calculate last page index
    final lastPageIndex = pages.length - 1;

    // Animate to the last page
    await pageController.animateToPage(lastPageIndex, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    Get.snackbar(
      'Skipped',
      'Onboarding process skipped',
      backgroundColor: AppColors.appBlue,
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(20.r),
      borderRadius: 10,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  final List<OnboardingData> pages = [
    OnboardingData(
      lottieUrl: AppAssets.jobCv, // 'https://assets2.lottiefiles.com/packages/lf20_1pxqjqps.json',
      title: 'Create Professional CVs',
      description: 'Choose from 1000+ stunning templates designed by experts to make you stand out',
      gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [AppColors.appBlue, AppColors.appPurple]),
      accentColor: AppColors.appBlue,
    ),
    OnboardingData(
      lottieUrl: AppAssets.liveChatBot, //'https://assets5.lottiefiles.com/packages/lf20_qmfs6c3i.json',
      title: 'AI-Powered Writing',
      description: 'Let our smart AI assistant help you write compelling content that gets you hired',
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [AppColors.appPink, AppColors.getStartedButtonColor22],
      ),
      accentColor: AppColors.appPink,
    ),
    OnboardingData(
      lottieUrl: AppAssets.screening, //'https://assets9.lottiefiles.com/packages/lf20_z1sghrty.json',
      title: 'Export & Share Instantly',
      description: 'Download your resume as PDF and share it with recruiters in just one tap',
      gradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [AppColors.appGreenC, AppColors.getStartedButtonColor33],
      ),
      accentColor: AppColors.appGreenC,
    ),
  ];
}
