import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(title: "Responsive UI with GetX", debugShowCheckedModeBanner: false, home: const ResponsiveHomePage());
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
