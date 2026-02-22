import 'package:flutter/material.dart';

import 'app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final requirements = await MentorXRequirements.initialize();
  runApp(MentorXStudent(requirements: requirements));
}
