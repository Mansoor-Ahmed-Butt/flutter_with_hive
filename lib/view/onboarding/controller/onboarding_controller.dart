import 'package:flutter/material.dart';
import 'package:flutter_with_hive/core/app_router.dart';
import 'package:flutter_with_hive/helper/app_assets.dart';
import 'package:flutter_with_hive/view/onboarding/model/onboarding_model.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart';

class OnboardingController extends GetxController {
  // PageController for navigation
  final pageController = PageController(initialPage: 0);

  // List of onboarding pages
  RxList pages = <OnboardingModel>[
    OnboardingModel(image: AppAssets.jobCv, title: "Welcome", description: "Discover the best way to manage your tasks easily.", isLottie: true),
    OnboardingModel(
      image: AppAssets.liveChatBot,
      title: "Stay Organized",
      description: "Keep track of your work with smart task lists.",
      isLottie: true,
    ),
    OnboardingModel(image: AppAssets.aiBot, title: "Achieve Goals", description: "Boost productivity and achieve your goals faster.", isLottie: true),
  ].obs;

  // Track current page index
  var currentPage = 0.obs;

  void setPage(int index) {
    currentPage.value = index;
  }

  bool get isLastPage => currentPage.value == pages.length - 1;

  void skip() {
    pageController.jumpToPage(pages.length - 1);
  }

  next(BuildContext context) {
    if (isLastPage) {
      context.go(RouteConfig.logInScreenRoute);
    } else {
      pageController.nextPage(duration: const Duration(seconds: 5), curve: Curves.easeIn);
    }
  }

  void jumpToPage(int index) {
    pageController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }
}
