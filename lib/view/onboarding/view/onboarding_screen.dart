import 'package:flutter/material.dart';
import 'package:flutter_with_hive/view/onboarding/controller/onboarding_controller.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class OnboardingScreen extends StatelessWidget {
  final controller = Get.put(OnboardingController());

  OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: PageView.builder(
          controller: controller.pageController,
          onPageChanged: controller.setPage,
          itemCount: controller.pages.length,

          itemBuilder: (context, index) {
            final page = controller.pages[index];
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: screenHeight * 0.2),
                  page.isLottie ? Lottie.asset(page.image, height: 250) : Image.asset(page.image, height: 250),
                  SizedBox(height: 10),
                  Text(page.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      page.description,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    ),
                  ),
                ],
              ),
            );
          },
        ),

        bottomNavigationBar: Obx(
          () => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Skip Button
                controller.isLastPage ? Container() : TextButton(onPressed: controller.skip, child: const Text("Skip")),

                //  Page Indicator (clickable dots)
                Row(
                  children: List.generate(
                    controller.pages.length,
                    (index) => GestureDetector(
                      onTap: () => controller.jumpToPage(index), //go to page on tap
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.all(4),
                        width: controller.currentPage.value == index ? 16 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: controller.currentPage.value == index ? Colors.blue : Colors.grey,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                ),

                // Next / Done Button
                TextButton(onPressed: () => controller.next(context), child: Text(controller.isLastPage ? "Done" : "Next")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
