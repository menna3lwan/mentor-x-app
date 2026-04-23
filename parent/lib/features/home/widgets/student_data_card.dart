import 'package:flutter/material.dart';
import 'package:mentorx_ui/mentorx_ui.dart';

class StudentDataCard extends StatelessWidget {
  const StudentDataCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      child: ListTile(
        trailing: CircleAvatar(
          backgroundColor: context.statusSuccessColor,
          child: Icon(Icons.person, color: context.backgroundSecondaryColor),
        ),
        title: Text(
          "Student's Name 📊",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: context.textPrimaryColor,
          ),
        ),

        subtitle: Text(
          "Weekly Report - Oct 5, 2025",
          style: TextStyle(color: context.textTertiaryColor),
        ),
      ),
    );
  }
}
