// Navigation Controller

import 'package:flutter/material.dart';
import 'package:flutter_with_hive/view/home_page/my_home_screens/my_home_screen.dart';
import 'package:flutter_with_hive/view/home_page/my_profile_screens/my_profile_screen.dart';
import 'package:flutter_with_hive/view/home_page/my_resume_screens/my_resume_screen.dart';
import 'package:flutter_with_hive/view/home_page/tamplet_screens/tamplet_screen.dart';
import 'package:get/get.dart';

class MainHomeScreenController extends GetxController {
  var currentIndex = 0.obs;

  void changePage(int index) {
    currentIndex.value = index;
  }
   final List<Widget> screens = [
      const AniHomeScreen(),
      const TemplatesScreen(),
      const MyResumesScreen(),
      const ProfileScreen(),
    ];

 }
