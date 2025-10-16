import 'dart:io';

class AdsHelper {
  /// banner add
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-6604577602748066/8245543912";
    } else if (Platform.isIOS) {
      return "ca-app-pub-6604577602748066/9515421221";
    } else {
      throw UnsupportedError("Unsupported Platform");
    }
  }

  ///  interstitialTestId
  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-6604577602748066/8245543912";
    } else if (Platform.isIOS) {
      return "ca-app-pub-6604577602748066/9515421221";
    } else {
      throw UnsupportedError("Unsupported Platform");
    }
  }

  ///  rewardedTestId
  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-6604577602748066/8245543912";
    } else if (Platform.isIOS) {
      return "ca-app-pub-6604577602748066/9515421221";
    } else {
      throw UnsupportedError("Unsupported Platform");
    }
  }
}
