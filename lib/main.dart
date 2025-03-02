import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_pointsale/app.dart';
import 'package:mobile_pointsale/utils/api.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) async {
    await ApiService.setupDio();
    runApp(const App());
  });
}
