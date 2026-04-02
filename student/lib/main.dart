import 'package:flutter/material.dart';

import 'app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final requirements = await StudentRequirements.initialize();
  runApp(StudentApp(requirements: requirements));
}
