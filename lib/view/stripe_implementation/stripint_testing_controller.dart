import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_with_hive/Services/ResponseModel/resonse_model.dart';
import 'package:flutter_with_hive/Services/post_requests.dart';
import 'package:flutter_with_hive/core/utils/api_urls.dart';
import 'package:flutter_with_hive/core/utils/print_log.dart';
import 'package:flutter_with_hive/widgets/progress_dialog/progress_dialog.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class StripintTestingController extends GetxController {
  RxInt amountInCents = 0.obs;
  RxBool isLoadingStripe = false.obs;
  static const bannerTestId = 'ca-app-pub-3940256099942544/2934735716';
  static const interstitialTestId = 'ca-app-pub-3940256099942544/4411468910';
  static const rewardedTestId = 'ca-app-pub-3940256099942544/1712485313';
  Future<void> postStripData(BuildContext context, int amount) async {
    dynamic data = {'amount': amount};
    isLoadingStripe.value = true;

    ResponseModel response = await APIsCallPost.payStripWithBody(ApiUrls.payStripPayment, data);
    isLoadingStripe.value = false;

    if (response.statusCode == 200 || response.statusCode == 201) {
      dynamic stripResponse = jsonDecode(response.data);
      final clientSecrtKey = stripResponse["clientSecret"] ?? "";
      printLog("This is response of strip : $clientSecrtKey");
      try {
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(paymentIntentClientSecret: clientSecrtKey, merchantDisplayName: "Strip testing"),
        );
        await Stripe.instance.presentPaymentSheet();
      } on StripeException catch (e) {
        // User cancelled or Stripe-specific error
        // Log and return gracefully
        printLog('StripeException: ${e.error.localizedMessage}');
        return;
      } catch (e) {
        printLog('Unexpected error presenting payment sheet: $e');
        return;
      }

      // MyDelightFullToast.succss(templist["message"].toString(), context);
    } else {}
  }
}
