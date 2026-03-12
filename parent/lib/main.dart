import 'package:flutter/material.dart';
import 'package:parent/app/parent.dart';
import 'package:parent/app/parent_requirements.dart';

void main() async {
  final requirements = await ParentRequirements.initialize();
  runApp(ParentApp(requirements: requirements));
}
