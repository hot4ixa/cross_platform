import 'package:flutter/material.dart';
import 'di/di.dart';
import 'app_name.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();

  FlutterError.onError = (details) {
    return talker.handle(details.exception, details.stack);
  };

  runApp(AppName());
}

