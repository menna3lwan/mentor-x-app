import 'package:flutter/material.dart';
import 'package:mentorx_core/mentorx_core.dart';
import 'app/parent_app.dart';
import 'app/parent_requirements.dart';

void main() async {
  final MentorXLogger logger = MentorXLogger('Main');
  
  try {
    final requirements = await ParentRequirements.initialize();
    
    runApp(
      ParentApp(requirements: requirements),
    );
  } catch (e, s) {
    logger.error('App failed to start: ', e, s);
    // Fallback UI or splash error could be here
  }
}
