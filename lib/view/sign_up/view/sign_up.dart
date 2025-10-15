import 'package:flutter/material.dart';
import 'package:flutter_with_hive/core/constants.dart';
import 'package:flutter_with_hive/core/themes.dart';
import 'package:flutter_with_hive/helper/spacing_wraper_for_login.dart';
import 'package:flutter_with_hive/view/log_in/controller/log_in_controller.dart';
import 'package:flutter_with_hive/widgets/custom_button/custom_button.dart';
import 'package:flutter_with_hive/widgets/custom_icon_button.dart';
import 'package:flutter_with_hive/widgets/my_single_line_text_field.dart';
import 'package:flutter_with_hive/widgets/text/app_style.dart';
import 'package:flutter_with_hive/widgets/text/size_box.dart';
import 'package:get/get.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final controller = Get.put(LogInController());
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => SpacingWrapper(
            heightFactor: 0.5,
            widthFactor: screenWidth < 600 ? 0.9 : 0.4,
            backgroundColor: AppColors.primaryColor,
            borderRadius: 20,
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 12,
              children: [
                Text("Sign Up", style: AppStyle.style30w700(color: Colors.white)),
                SizedH(6),
                MyTextFieldForSingleLine(
                  isCustomHeight: true,
                  containerHeight: 35,
                  hintText: 'Enter Name',
                  labelText: "Email",
                  controller: controller.emailController,
                  isRequired: true,
                  prefixIcon: CustomIcon(size: 16.sp, iconOnly: true, iconColor: AppColors.greyColor, icon: Icons.email),
                ),
                MyTextFieldForSingleLine(
                  isCustomHeight: true,
                  containerHeight: 35,
                  hintText: 'Enter Email',
                  labelText: "Email",
                  controller: controller.emailController,
                  isRequired: true,
                  prefixIcon: CustomIcon(size: 16.sp, iconOnly: true, iconColor: AppColors.greyColor, icon: Icons.email),
                ),

                MyTextFieldForSingleLine(
                  hintText: 'Enter Password',
                  labelText: "Password",
                  controller: controller.passwordController,
                  isRequired: true,
                  isCustomHeight: true,
                  containerHeight: 35,
                  isPassword: controller.isPasswordVisible.isTrue ? false : true,
                  prefixIcon: CustomIcon(size: 16.sp, iconOnly: true, iconColor: AppColors.greyColor, icon: Icons.password),

                  suffixIcon: CustomIcon(
                    onTap: () {
                      controller.isPasswordVisible.value = !controller.isPasswordVisible.value;
                    },
                    size: 16.sp,
                    iconOnly: true,
                    iconColor: AppColors.greyColor,
                    icon: controller.isPasswordVisible.isTrue ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  ),
                ),
                SizedH(6),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60.r),
                  child: CustomButton(onTap: () {}, btnText: "Login", textColor: Colors.lightBlue),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 60.r),
                  child: CustomButton(onTap: () {}, btnText: "Sign Up", textColor: Colors.lightBlue),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
