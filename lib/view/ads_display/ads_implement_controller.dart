import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_with_hive/helper/ads_helper.dart';
import 'package:flutter/material.dart';

class AdsImplementController extends GetxController {
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;
  BannerAd? _bannerAd;
  bool _isBannerLoaded = false;
  bool _pendingShowInterstitial = false;
  bool _pendingShowRewarded = false;
  @override
  void onInit() {
    super.onInit();
    _loadInterstitial();
    _loadRewarded();
    // loadBanner();
  }

  void loadBanner() {
    _bannerAd = BannerAd(
      adUnitId: AdsHelper.bannerAdUnitId,
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          _isBannerLoaded = true;
          debugPrint('Banner ad loaded');
        },
        onAdFailedToLoad: (ad, err) {
          _isBannerLoaded = false;
          ad.dispose();
          debugPrint('Banner ad failed to load: ${err.message}');
        },
      ),
    );
    _bannerAd!.load();
  }

  void _loadInterstitial() {
    InterstitialAd.load(
      adUnitId: AdsHelper.interstitialAdUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          // If user requested show while loading, show now
          if (_pendingShowInterstitial) {
            _pendingShowInterstitial = false;
            showInterstitial();
            return;
          }
          debugPrint('Interstitial loaded');
        },
        onAdFailedToLoad: (err) {
          _interstitialAd = null;
          debugPrint('Interstitial failed to load: ${err.message}');
        },
      ),
    );
  }

  void _loadRewarded() {
    RewardedAd.load(
      adUnitId: AdsHelper.rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          if (_pendingShowRewarded) {
            _pendingShowRewarded = false;
            showRewarded(null);
            return;
          }
          debugPrint('Rewarded ad loaded');
        },
        onAdFailedToLoad: (err) {
          _rewardedAd = null;
          debugPrint('Rewarded failed to load: ${err.message}');
        },
      ),
    );
  }

  Widget showBanner() {
    if (_isBannerLoaded && _bannerAd != null) {
      return Container(
        alignment: Alignment.center,
        width: _bannerAd!.size.width.toDouble(),
        height: _bannerAd!.size.height.toDouble(),
        child: AdWidget(ad: _bannerAd!),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  void showInterstitial() {
    if (_interstitialAd == null) {
      // Start loading and mark pending show so it will display when ready
      _pendingShowInterstitial = true;
      _loadInterstitial();
      debugPrint('Interstitial not ready yet, loading...');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _interstitialAd = null;
        _loadInterstitial();
      },
      onAdFailedToShowFullScreenContent: (ad, err) {
        ad.dispose();
        _interstitialAd = null;
        _loadInterstitial();
      },
    );
    _interstitialAd!.show();
  }

  void showRewarded(VoidCallback? onEarned) {
    if (_rewardedAd == null) {
      _pendingShowRewarded = true;
      _loadRewarded();
      debugPrint('Rewarded ad not ready yet, loading...');
      return;
    }
    _rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _rewardedAd = null;
        _loadRewarded();
      },
      onAdFailedToShowFullScreenContent: (ad, err) {
        ad.dispose();
        _rewardedAd = null;
        _loadRewarded();
      },
    );
    _rewardedAd!.show(
      onUserEarnedReward: (ad, reward) {
        if (onEarned != null) onEarned();
      },
    );
  }

  @override
  void onClose() {
    _interstitialAd?.dispose();
    _rewardedAd?.dispose();
    // _bannerAd?.dispose();
    super.onClose();
  }
}
