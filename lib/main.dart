import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_with_hive/core/app_router.dart';
import 'package:flutter_with_hive/core/themes.dart';
import 'package:get/get.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();

  var directory = getApplicationDocumentsDirectory();
  Hive.init((await directory).path);

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(const Duration(milliseconds: 200));
  int j=0;
  Stripe.publishableKey = "pk_test_51SIQ7T2ZnDzySriKV8vzDIRaLmNuDMpmreUQtq4TLskThdHh5qZQLxe8zWcPbHwl5eQgyw6ZYvxairkcF828wCFB00bttC5U6L";
  runApp(GlobalLoaderOverlay(child: MyApp()));

  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  final ColorScheme appColors = ColorScheme.fromSeed(seedColor: AppColors.primaryColor);
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp.router(
        routerDelegate: RouteConfig.routes.routerDelegate,
        routeInformationParser: RouteConfig.routes.routeInformationParser,
        routeInformationProvider: RouteConfig.routes.routeInformationProvider,
        // localizationsDelegates: context.localizationDelegates,
        // supportedLocales: context.supportedLocales,
        // locale: context.locale,
        title: "Hive with Flutter",
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.green,
          colorScheme: appColors,
          highlightColor: const Color(0xffFC9D74),
          textSelectionTheme: TextSelectionThemeData(
            selectionColor: AppColors.bodyText.withOpacity(0.4),
            cursorColor: AppColors.primaryColor,
            selectionHandleColor: AppColors.primaryColor,
          ),
        ),
        debugShowCheckedModeBanner: false,
        // builder: EasyLoading.init(),
      ),

      // MaterialApp.router(
      //   routerConfig: router,
      //   debugShowCheckedModeBanner: false,
      //   title: 'Hive with Flutter',
      //   theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      // ),
    );

    // return GetMaterialApp(title: "Responsive UI with GetX", debugShowCheckedModeBanner: false, home: const ResponsiveHomePage());
  }
}

class ResponsiveHomePage extends StatelessWidget {
  const ResponsiveHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width; // screen width
    final height = MediaQuery.of(context).size.height; // screen height

    String screenType;
    if (width < 400) {
      screenType = "📱 Small Mobile";
    } else if (width < 600) {
      screenType = "📱 Mobile";
    } else if (width < 1100) {
      screenType = "📱 Tablet";
    } else {
      screenType = "💻 Desktop";
    }

    return Scaffold(
      appBar: AppBar(title: Text("Responsive UI ($screenType)")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(screenType, style: const TextStyle(fontSize: 22)),
            const SizedBox(height: 20),
            Text("Width: $width px"),
            Text("Height: $height px"),
            const SizedBox(height: 20),
            Text(
              GetPlatform.isMobile
                  ? "Running on Mobile"
                  : GetPlatform.isDesktop
                  ? "Running on Desktop"
                  : GetPlatform.isWeb
                  ? "Running on Web"
                  : "Other",
            ),
          ],
        ),
      ),
    );
  }
}
