import 'package:flutter/material.dart';

class TestCard extends StatelessWidget {
  final String title;
  final String questions;
  final String duration;
  final VoidCallback? onTap;

  const TestCard({
    super.key,
    required this.title,
    required this.questions,
    required this.duration,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),

      child: ListTile(
        contentPadding: const EdgeInsets.all(12),

        leading: CircleAvatar(
          child: const Icon(Icons.quiz),
        ),

        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Text(
          '$questions • $duration',
        ),

        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
        ),

        onTap: onTap,
      ),
    );
  }
}