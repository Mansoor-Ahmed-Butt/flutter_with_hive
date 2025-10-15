import 'package:flutter/material.dart';
import 'package:flutter_with_hive/core/constants.dart';
import 'package:flutter_with_hive/core/themes.dart';
import 'package:flutter_with_hive/helper/spacing_wraper_for_login.dart';
import 'package:flutter_with_hive/stripint_testing_controller.dart';

import 'package:flutter_with_hive/widgets/custom_button/custom_button.dart';
import 'package:flutter_with_hive/widgets/custom_icon_button.dart';
import 'package:flutter_with_hive/widgets/my_single_line_text_field.dart';
import 'package:flutter_with_hive/widgets/text/app_style.dart';
import 'package:flutter_with_hive/widgets/text/size_box.dart';
import 'package:get/get.dart';

class StripTesting extends StatefulWidget {
  const StripTesting({super.key});

  @override
  State<StripTesting> createState() => _StripTestingState();
}

class _StripTestingState extends State<StripTesting> {
  final controller = Get.put(StripintTestingController());
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
              Text("Strip Implement", style: AppStyle.style30w700(color: Colors.white)),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 60.r),
                child: Obx(
                  () => CustomButton(
                    onTap: controller.isLoadingStripe.value
                        ? null
                        : () async {
                            await controller.postStripData(context, 3000);
                          },
                    btnText: controller.isLoadingStripe.value ? "Processing..." : "Pay Now",
                    backgroundColor: controller.isLoadingStripe.value ? Colors.grey : Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
