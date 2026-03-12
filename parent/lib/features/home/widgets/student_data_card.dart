import 'package:flutter/material.dart';

class StudentDataCard extends StatelessWidget {
  const StudentDataCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      child: ListTile(
        trailing: CircleAvatar(
          backgroundColor: Colors.green,
          child: const Icon(Icons.person, color: Colors.white),
        ),
        title: const Text(
          "Student's Name 📊",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),

        subtitle: const Text(
          "Weekly Report - Oct 5, 2025",
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}
