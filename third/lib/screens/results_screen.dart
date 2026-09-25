import 'package:flutter/material.dart';

import '../widgets/stat_card.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Results',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              'Your Performance',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            GridView.count(
              crossAxisCount: 2,

              shrinkWrap: true,

              physics: const NeverScrollableScrollPhysics(),

              crossAxisSpacing: 12,

              mainAxisSpacing: 12,

              children: const [
                StatCard(
                  title: 'Tests',
                  value: '12',
                  icon: Icons.quiz,
                ),

                StatCard(
                  title: 'Questions',
                  value: '240',
                  icon: Icons.help_outline,
                ),

                StatCard(
                  title: 'Correct',
                  value: '198',
                  icon: Icons.check_circle_outline,
                ),

                StatCard(
                  title: 'Accuracy',
                  value: '82%',
                  icon: Icons.trending_up,
                ),
              ],
            ),

            const SizedBox(height: 30),

            const Text(
              'Recent Tests',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            _resultItem(
              'Flutter Basics',
              '18 / 20',
              '90%',
            ),

            _resultItem(
              'C++ Programming',
              '15 / 20',
              '75%',
            ),

            _resultItem(
              'DSA Fundamentals',
              '22 / 30',
              '73%',
            ),
          ],
        ),
      ),
    );
  }

  Widget _resultItem(
    String title,
    String score,
    String percentage,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),

      child: ListTile(
        leading: const CircleAvatar(
          child: Icon(Icons.assessment),
        ),

        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Text('Score: $score'),

        trailing: Text(
          percentage,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}