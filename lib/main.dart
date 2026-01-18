import 'dart:async';

import 'package:flutter/material.dart';

import 'src/app.dart';
import 'src/core/di/services_di.dart';

FutureOr<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ServicesDI.init();

  runApp(const App());
}
