import 'package:flutter/material.dart';
import 'package:mentorx_core/mentorx_core.dart';

class CourseProgressDetailPage extends StatelessWidget {
  final CourseEntity course;

  const CourseProgressDetailPage({
    super.key,
    required this.course,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course.title),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Course Details: ${course.title}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    Text('Course ID: ${course.id}'),
                    // Add more progress details here as needed
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
