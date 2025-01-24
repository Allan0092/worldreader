import 'package:flutter/material.dart';
import 'package:worldreader/app/di/di.dart';
import 'package:worldreader/core/network/hive_service.dart';

import 'app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  await initDependencies();
  runApp(
    const MyApp(),
  );
}
