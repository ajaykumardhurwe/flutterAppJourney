import 'package:flutter/material.dart';

import '../widgets/test_card.dart';
import 'quiz_screen.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tests',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),

        children: [
          const Text(
            'Available Tests',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 15),

          TestCard(
            title: 'Flutter Basics',
            questions: '5 Questions',
            duration: '10 Minutes',

            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const QuizScreen(),
                ),
              );
            },
          ),

          TestCard(
            title: 'C++ Programming',
            questions: '20 Questions',
            duration: '20 Minutes',
            onTap: () {},
          ),

          TestCard(
            title: 'DSA Fundamentals',
            questions: '30 Questions',
            duration: '30 Minutes',
            onTap: () {},
          ),

          TestCard(
            title: 'DBMS',
            questions: '25 Questions',
            duration: '25 Minutes',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}