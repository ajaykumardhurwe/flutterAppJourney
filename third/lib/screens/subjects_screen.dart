import 'package:flutter/material.dart';

import '../widgets/category_card.dart';

class SubjectsScreen extends StatelessWidget {
  const SubjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final subjects = [
      {
        'name': 'Flutter',
        'icon': Icons.phone_android,
      },
      {
        'name': 'C++',
        'icon': Icons.code,
      },
      {
        'name': 'Java',
        'icon': Icons.coffee,
      },
      {
        'name': 'DSA',
        'icon': Icons.account_tree,
      },
      {
        'name': 'DBMS',
        'icon': Icons.storage,
      },
      {
        'name': 'Operating System',
        'icon': Icons.computer,
      },
      {
        'name': 'Computer Networks',
        'icon': Icons.network_check,
      },
      {
        'name': 'Aptitude',
        'icon': Icons.calculate,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Subjects',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: GridView.builder(
        padding: const EdgeInsets.all(16),

        itemCount: subjects.length,

        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,

          crossAxisSpacing: 12,

          mainAxisSpacing: 12,

          childAspectRatio: 1.2,
        ),

        itemBuilder: (context, index) {
          final subject = subjects[index];

          return CategoryCard(
            title: subject['name'] as String,
            icon: subject['icon'] as IconData,

            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '${subject['name']} selected',
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}