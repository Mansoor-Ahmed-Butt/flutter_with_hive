import 'package:flutter/material.dart';
import 'package:flutter_with_hive/view/ads_display/ads_implement_controller.dart';
import 'package:flutter_with_hive/core/constants.dart';
import 'package:flutter_with_hive/core/themes.dart';
import 'package:flutter_with_hive/helper/spacing_wraper_for_login.dart';

import 'package:flutter_with_hive/widgets/custom_button/custom_button.dart';

import 'package:flutter_with_hive/widgets/text/app_style.dart';

import 'package:get/get.dart';

class AdsImplementationScreen extends StatefulWidget {
  const AdsImplementationScreen({super.key});

  @override
  State<AdsImplementationScreen> createState() => _AdsImplementationScreenState();
}

class _AdsImplementationScreenState extends State<AdsImplementationScreen> {
  final controller = Get.put(AdsImplementController());
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: SpacingWrapper(
          heightFactor: 0.5,
          widthFactor: screenWidth < 600 ? 0.9 : 0.4,
          backgroundColor: AppColors.activityColor,
          borderRadius: 20,
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 12,
            children: [
              Text("Adds Implement", style: AppStyle.style30w700(color: Colors.white)),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 60.r),
                child: Column(
                  children: [
                    CustomButton(
                      onTap: () {
                        controller.showInterstitial();
                        Get.snackbar('Ads', 'Requested interstitial ad', snackPosition: SnackPosition.BOTTOM);
                      },
                      btnText: "Show Interstitial",
                      backgroundColor: Colors.grey,
                    ),
                    SizedBox(height: 30),
                    CustomButton(
                      onTap: () {
                        controller.showRewarded(() {
                          // reward earned callback
                          Get.snackbar('Reward', 'You earned a reward');
                        });
                        Get.snackbar('Ads', 'Requested rewarded ad', snackPosition: SnackPosition.BOTTOM);
                      },
                      btnText: "Show Rewarded",
                      backgroundColor: Colors.grey,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
