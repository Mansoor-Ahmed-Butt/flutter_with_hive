// Navigation Controller

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_with_hive/ads_implementation.dart';
import 'package:flutter_with_hive/view/ai_chat_bot/chat_screen.dart';
import 'package:flutter_with_hive/view/home_page/my_home_screens/my_home_screen.dart';
import 'package:flutter_with_hive/view/home_page/my_profile_screens/my_profile_screen.dart';
import 'package:flutter_with_hive/view/home_page/tamplet_screens/tamplet_screen.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MainHomeScreenController extends GetxController {
  static MainHomeScreenController get to => Get.find();
  var currentIndex = 0.obs;

  void changePage(int index) {
    currentIndex.value = index;
  }

  final List<Widget> screens = [
    const AnimatedHomeScreen(), const TemplatesScreen(),

    const AiChatbotScreen(),

    // const MyResumesScreen(),
   // AdsImplementationScreen(),
    const ProfileScreen(),
  ];
  // ---------- Resume Dialog Data ----------
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final jobTitleController = TextEditingController();
  final locationController = TextEditingController();
  final summaryController = TextEditingController();

  final Rx<File?> profileImage = Rx<File?>(null);
  final ImagePicker picker = ImagePicker();

  late AnimationController animationController;
  late Animation<double> scaleAnimation;

  // ---------- Pick Image ----------
  Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (image != null) {
      profileImage.value = File(image.path);
    }
  }

  // ---------- Initialize Animation ----------
  void initAnimation(TickerProvider vsync) {
    animationController = AnimationController(duration: const Duration(milliseconds: 300), vsync: vsync);
    scaleAnimation = CurvedAnimation(parent: animationController, curve: Curves.easeOutBack);
    animationController.forward();
  }

  // ---------- Clean Up ----------
  @override
  void onClose() {
    animationController.dispose();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    jobTitleController.dispose();
    locationController.dispose();
    summaryController.dispose();
    super.onClose();
  }
}
