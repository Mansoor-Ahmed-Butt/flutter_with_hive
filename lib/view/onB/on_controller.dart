import 'package:flutter/material.dart';
import 'package:flutter_with_hive/view/onB/on_boarding_model.dart';
import 'package:get/get.dart';

// Onboarding Controller
class OnboardingController1 extends GetxController {
  var currentPage = 0.obs;
  final PageController pageController = PageController();

  void nextPage() async {
    if (currentPage.value < 2) {
      await pageController.animateToPage(currentPage.value + 1, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    } else {
      Get.snackbar(
        'Welcome!',
        'You have completed the onboarding process',
        backgroundColor: const Color(0xFF10B981),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(20),
        borderRadius: 10,
        duration: const Duration(seconds: 2),
      );
    }
  }

  void skipToEnd() {
    Get.snackbar(
      'Skipped',
      'Onboarding process skipped',
      backgroundColor: const Color(0xFF6366F1),
      colorText: Colors.white,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(20),
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
      lottieUrl: 'https://assets2.lottiefiles.com/packages/lf20_1pxqjqps.json',
      title: 'Create Professional CVs',
      description: 'Choose from 1000+ stunning templates designed by experts to make you stand out',
      gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)]),
      accentColor: const Color(0xFF6366F1),
    ),
    OnboardingData(
      lottieUrl: 'https://assets5.lottiefiles.com/packages/lf20_qmfs6c3i.json',
      title: 'AI-Powered Writing',
      description: 'Let our smart AI assistant help you write compelling content that gets you hired',
      gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFFEC4899), Color(0xFFF97316)]),
      accentColor: const Color(0xFFEC4899),
    ),
    OnboardingData(
      lottieUrl: 'https://assets9.lottiefiles.com/packages/lf20_z1sghrty.json',
      title: 'Export & Share Instantly',
      description: 'Download your resume as PDF and share it with recruiters in just one tap',
      gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF10B981), Color(0xFF3B82F6)]),
      accentColor: const Color(0xFF10B981),
    ),
  ];
}
