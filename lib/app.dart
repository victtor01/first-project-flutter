import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mobile_pointsale/core/services/navigation_service.dart';
import 'package:mobile_pointsale/ui/features/splash/splash_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = false;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
      navigatorKey: NavigationService.navigatorKey,
    );
  }
}
