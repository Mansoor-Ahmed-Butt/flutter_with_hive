import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_with_hive/core/app_router.dart';
import 'package:flutter_with_hive/core/themes.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

const String _stripePublishableKey = String.fromEnvironment('STRIPE_PUBLISHABLE_KEY', defaultValue: '');

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // Keep native splash until app is ready.
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Initialize services
  await _initializeServices();

  // Apply Stripe publishable key if provided via --dart-define
  if (_stripePublishableKey.isNotEmpty) {
    Stripe.publishableKey = _stripePublishableKey;
  }

  runApp(GlobalLoaderOverlay(child: MyApp()));

  // Initialize AdMob after the Flutter engine is running so the plugin is registered.
  // Calling plugin methods before an attached engine can cause MissingPluginException.
  MobileAds.instance.initialize();

  // Remove splash after first frame so UI has drawn
  WidgetsBinding.instance.addPostFrameCallback((_) {
    FlutterNativeSplash.remove();
  });
}

Future<void> _initializeServices() async {
  // Initialize Hive storage
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  // Add other async inits here (analytics, remote config, etc.)
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ColorScheme appColors = ColorScheme.fromSeed(seedColor: AppColors.primaryColor);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp.router(
          routerDelegate: RouteConfig.routes.routerDelegate,
          routeInformationParser: RouteConfig.routes.routeInformationParser,
          routeInformationProvider: RouteConfig.routes.routeInformationProvider,
          title: "Hive with Flutter",
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: Colors.green,
            colorScheme: appColors,
            highlightColor: const Color(0xffFC9D74),
            textSelectionTheme: TextSelectionThemeData(
              selectionColor: AppColors.bodyText.withValues(alpha: 0.4),
              cursorColor: AppColors.primaryColor,
              selectionHandleColor: AppColors.primaryColor,
            ),
          ),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
