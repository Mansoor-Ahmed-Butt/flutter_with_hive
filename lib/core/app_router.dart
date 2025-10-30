import 'package:flutter_with_hive/view/ads_display/ads_implementation.dart';
import 'package:flutter_with_hive/view/ai_chat_bot/chat_screen.dart';
import 'package:flutter_with_hive/view/home_page/main_home_screen.dart';
import 'package:flutter_with_hive/view/on_boarding/onboarding_screen.dart';
import 'package:flutter_with_hive/view/log_in/view/log_in.dart';
import 'package:flutter_with_hive/view/user_testing/user_screen.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_with_hive/view/voice_vapi/vapi_voice_real_time.dart';

class RouteConfig {
  //Signup
  static const String paymentPlanRoute = "/Login";
  static const String logInScreenRoute = "/Login";
  static const String onboardingScreen = "/onBoarding";
  static const String adsScreen = "/adsScreen";
  static const String aiChatBotScreen = "/aiChatBotScreen";
  static const String userScreen = "/userScreen";
  static const String bottomNavigation = "/bottomNavigation";
  static const String vapiChatScreen = "/vapiChatScreen";
  static const String mainHomeScreen = "/mainHomeScreen";

  static GoRouter routes = GoRouter(
    initialLocation: "/",
    navigatorKey: Get.key,
    routes: [
      // GoRoute(path: '/', builder: (context, state) => MainHomeScreen()),
         GoRoute(path: '/', builder: (context, state) => OnboardingScreen()),

      // GoRoute(path: '/', builder: (context, state) => VapiChatScreen()),
      // GoRoute(path: '/', builder: (context, state) => MainScreen()),
      // GoRoute(path: '/', builder: (context, state) => UserScreen()),
      // GoRoute(path: '/', builder: (context, state) => AiChatbotScreen()),
      // GoRoute(path: '/', builder: (context, state) => AdsImplementationScreen()),
      // GoRoute(path: '/', builder: (context, state) => StripTesting()),
      // GoRoute(path: '/', builder: (context, state) => OnboardingScreen()),
      GoRoute(
        path: '/vapiChatScreen',
        name: vapiChatScreen,

        builder: (context, state) {
          return VapiChatScreen();
        },
      ),
      GoRoute(
        path: '/onboardingScreen',
        name: onboardingScreen,

        builder: (context, state) {
          return OnboardingScreen();
        },
      ),
      GoRoute(
        path: '/mainHomeScreen',
        name: mainHomeScreen,

        builder: (context, state) {
          return MainHomeScreen();
        },
      ),
      GoRoute(
        path: '/userScreen',
        name: userScreen,
        builder: (context, state) {
          return UserScreen();
        },
      ),
     
      GoRoute(
        path: '/adsScreen',
        name: adsScreen,
        builder: (context, state) {
          return AdsImplementationScreen();
        },
      ),
      GoRoute(
        path: '/aiChatBotScreen',
        name: aiChatBotScreen,
        builder: (context, state) {
          return AiChatbotScreen();
        },
      ),
      GoRoute(
        path: '/Login',
        name: logInScreenRoute,
        //  builder: (context, state) => SignUp()
        builder: (context, state) {
          // print("This is state $state \n This is context ${Get.key}");
          return const LogIn();
        },
      ),
     
      // GoRoute(
      //   path: redirectOrganizationSetup,
      //   name: redirectOrganizationSetup,
      //   pageBuilder: (context, state) {
      //     // printLog("Redirecting to organization setup with params: ${state.uri.queryParameters}");
      //     return transitionsBuilder(
      //         context,
      //         state,
      //         RedirectOrganizationSetup(
      //           organizationId: state.uri.queryParameters['organizationId'],
      //           organizationName: state.uri.queryParameters['organizationName'],
      //           accessToken: state.uri.queryParameters['token'] ?? "",
      //           phoneNumber: state.uri.queryParameters['phoneNumber'] ?? "",
      //         ));
      //   },
      // ),
     
      // GoRoute(
      //   path: "/administrationMainScreen",
      //   name: administrationMainScreen,
      //   pageBuilder: (context, state) {
      //     final index = int.tryParse(state.uri.queryParameters['index'] ?? '0') ?? 0;

      //              final extra = state.extra as Map<String, dynamic>? ?? {};
      //     final tabIndexForSetup = extra["tabIndexForSetup"] ?? 0;
      //     final subIndexForTable = extra["subIndexForTable"] ?? 0;
      //     final fromPrintCheck = extra["fromPrintCheck"] ?? false;
      //     final bankId = extra["bankId"] ?? 0;
      //     return transitionsBuilder(
      //         context,
      //         state,
      //         AdministrationMainScreen(
      //           tabIndexForSetup: tabIndexForSetup,
      //           subIndexForTable: index,
      //           fromPrintCheck: fromPrintCheck,
      //           bankId: bankId,
      //         )
      //         );
      //   },
      //   redirect: (context, state) async {
      //     return await authMiddlewareGoRoute() ? null : loginUsaPageRoute;
      //   },
      // ),
   
      // GoRoute(
      //   path: "/processPayroll",
      //   name: processPayroll,
      //   pageBuilder: (context, state) => transitionsBuilder(context, state, const ProcessPayRollMain()),
      //   redirect: (context, state) async {
      //     return await authMiddlewareGoRoute() ? null : loginUsaPageRoute;
      //   },
      // ),
      // GoRoute(
      //   path: "/employeeDirectory",
      //   name: employeeDirectory,
      //   pageBuilder: (context, state) => transitionsBuilder(context, state, const EmployeeDirectoryMainScreen()),
      //   redirect: (context, state) async {
      //     return await authMiddlewareGoRoute() ? null : loginUsaPageRoute;
      //   },
      // ),
      // GoRoute(
      //   path: "/printChecks",
      //   name: printChecks,
      //   pageBuilder: (context, state) => transitionsBuilder(context, state, const PrintChecks()),
      //   redirect: (context, state) async {
      //     return await authMiddlewareGoRoute() ? null : loginUsaPageRoute;
      //   },
      // ),
      // GoRoute(
      //   path: "/taxHubMain",
      //   name: taxHubMain,
      //   pageBuilder: (context, state) => transitionsBuilder(context, state, const TaxHubMain()),
      //   redirect: (context, state) async {
      //     return await authMiddlewareGoRoute() ? null : loginUsaPageRoute;
      //   },
      // ),
      // // GoRoute(
      // //   path: "/pendingTaxes",
      // //   name: pendingTaxes,
      // //   pageBuilder: (context, state) => transitionsBuilder(context, state, const PendingTaxesMain()),
      // // ),
      // // GoRoute(
      // //   path: "/completedFilings",
      // //   name: completedFilings,
      // //   pageBuilder: (context, state) => transitionsBuilder(context, state, const CompletedFilingsMain()),
      // // ),
      // GoRoute(
      //   path: "/payStubDetailedView",
      //   name: payStubDetailedView,
      //   pageBuilder: (context, state) => transitionsBuilder(context, state, const PaystubsDetailedView()),
      //   redirect: (context, state) async {
      //     return await authMiddlewareGoRoute() ? null : loginUsaPageRoute;
      //   },
      // ),

      // GoRoute(
      //   path: timeOffReport,
      //   name: timeOffReport,
      //   pageBuilder: (context, state) => transitionsBuilder(context, state, const TimeOffReport()),
      // ),
    ],
  );
  static dynamic transitionsBuilder(context, state, child) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }
}

// Future<bool> authMiddlewareInviteGoRoute() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   bool isOpenApp = prefs.getBool('isAppOpen') ?? false;
//   printLog("Middleware triggered: isAppOpen = $isOpenApp");

//   if (isOpenApp) {
//     accessToken = prefs.getString("accessToken") ?? "";
//     // userEmail = prefs.getString("usernameforInvitationCompare") ?? "";
//     companyId = prefs.getString("companyId") ?? "0";
//     // companyId = companyId;
//     companyNameForGlobals.value = prefs.getString("companyName") ?? "";
//     userNameForGlobals.value = prefs.getString("userFirstName") ?? "";
//     companyLogo.value = prefs.getString("companyLogo") ?? "";
//     final jsonString = prefs.getString("loggedCompanyModel");
//     // permissions = pr.Permissions.fromJson(jsonDecode(prefs.getString("permissions") ?? ""));

//     return true;
//   }
//   return true;
// }

// Future<bool> authMiddlewareGoRoute() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   bool isOpenApp = prefs.getBool('isAppOpen') ?? false;
//   printLog("Middleware triggered: isAppOpen = $isOpenApp");

//   if (isOpenApp) {
//     accessToken = prefs.getString("accessToken") ?? "";
//     companyId = int.parse(prefs.getString("companyId") ?? "0").toString();
//     companyNameForGlobals = (prefs.getString("companyName") ?? "").obs;
//     userNameForGlobals = (prefs.getString("userFirstName") ?? "").obs;
//     companyLogo.value = prefs.getString("companyLogo") ?? "";
//     companyNameForGlobals = (prefs.getString("companyName") ?? "").obs;
//     userNameForGlobals = (prefs.getString("userFirstName") ?? "").obs;
//     // printLog("companyCompleteAddress ===?? $companyCompleteAddress  ${prefs.getString("companyCompleteAddress")}");
//     companyCompleteAddress = prefs.getString("companyCompleteAddress") ?? "";
//     companyEmail = prefs.getString("companyEmail") ?? "";
//     companyPhoneNo = prefs.getString("companyPhoneNo") ?? "";

//     return true;
//   } else {
//     printLog("Redirecting to login page");
//     return false;
//   }
// }
