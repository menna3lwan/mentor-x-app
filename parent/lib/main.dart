import 'package:flutter/material.dart';

import 'app/parent.dart';
import 'app/parent_requirements.dart';

void main() async {
  final requirements = await ParentRequirements.initialize();
  runApp(ParentApp(requirements: requirements));
}
