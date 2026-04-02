import 'app/parent_app.dart';
import 'app/parent_requirements.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final requirements = await ParentRequirements.initialize();
  runApp(ParentApp(requirements: requirements));
}
