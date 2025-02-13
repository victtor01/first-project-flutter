import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:test/features/splash/splash_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = false;
			
    return MaterialApp(home: SplashPage());
  }
}
