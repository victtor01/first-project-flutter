import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test/app.dart';
import 'package:test/utils/api.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) async {
    await ApiService.setupDio();
    runApp(const App());
  });
}
