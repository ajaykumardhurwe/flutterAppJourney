// import 'package:flutter/material.dart';

// import '../widgets/category_card.dart';
// import '../widgets/test_card.dart';
// import 'quiz_screen.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'MCQ Master',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),

//         actions: [
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(
//               Icons.notifications_outlined,
//             ),
//           ),
//         ],
//       ),

//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),

//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,

//           children: [
//             const Text(
//               'Hello, Ajay 👋',
//               style: TextStyle(
//                 fontSize: 26,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),

//             const SizedBox(height: 5),

//             Text(
//               'Ready to practice today?',
//               style: TextStyle(
//                 color: Colors.grey.shade600,
//                 fontSize: 15,
//               ),
//             ),

//             const SizedBox(height: 20),

//             _buildDailyChallenge(context),

//             const SizedBox(height: 25),

//             const Text(
//               'Categories',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),

//             const SizedBox(height: 15),

//             GridView.count(
//               crossAxisCount: 2,

//               shrinkWrap: true,

//               physics: const NeverScrollableScrollPhysics(),

//               crossAxisSpacing: 12,

//               mainAxisSpacing: 12,

//               childAspectRatio: 1.4,

//               children: [
//                 CategoryCard(
//                   title: 'Flutter',
//                   icon: Icons.phone_android,
//                   onTap: () {},
//                 ),

//                 CategoryCard(
//                   title: 'C++',
//                   icon: Icons.code,
//                   onTap: () {},
//                 ),

//                 CategoryCard(
//                   title: 'DSA',
//                   icon: Icons.account_tree,
//                   onTap: () {},
//                 ),

//                 CategoryCard(
//                   title: 'DBMS',
//                   icon: Icons.storage,
//                   onTap: () {},
//                 ),
//               ],
//             ),

//             const SizedBox(height: 25),

//             const Text(
//               'Popular Tests',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),

//             const SizedBox(height: 15),

//             TestCard(
//               title: 'Flutter Basics',
//               questions: '5 Questions',
//               duration: '10 Minutes',
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (_) => const QuizScreen(),
//                   ),
//                 );
//               },
//             ),

//             TestCard(
//               title: 'C++ Programming',
//               questions: '20 Questions',
//               duration: '20 Minutes',
//               onTap: () {},
//             ),

//             TestCard(
//               title: 'DSA Fundamentals',
//               questions: '30 Questions',
//               duration: '30 Minutes',
//               onTap: () {},
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDailyChallenge(BuildContext context) {
//     return Card(
//       child: Padding(
//         padding: const EdgeInsets.all(20),

//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,

//           children: [
//             Row(
//               children: [
//                 Icon(
//                   Icons.rocket_launch,
//                   color: Theme.of(context).colorScheme.primary,
//                 ),

//                 const SizedBox(width: 8),

//                 const Text(
//                   'Daily Challenge',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),

//             const SizedBox(height: 10),

//             Text(
//               'Test your knowledge with today\'s challenge.',
//               style: TextStyle(
//                 color: Colors.grey.shade600,
//               ),
//             ),

//             const SizedBox(height: 15),

//             const Row(
//               children: [
//                 Icon(Icons.help_outline, size: 18),
//                 SizedBox(width: 5),
//                 Text('20 Questions'),

//                 SizedBox(width: 20),

//                 Icon(Icons.timer_outlined, size: 18),
//                 SizedBox(width: 5),
//                 Text('20 Minutes'),
//               ],
//             ),

//             const SizedBox(height: 18),

//             SizedBox(
//               width: double.infinity,

//               child: FilledButton(
//                 onPressed: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (_) => const QuizScreen(),
//                     ),
//                   );
//                 },

//                 child: const Text('Start Test'),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }





















import 'package:flutter/material.dart';

import '../models/subject.dart';
import '../services/subject_service.dart';
import '../widgets/category_card.dart';
import '../widgets/test_card.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Subject>> subjectsFuture;

  @override
  void initState() {
    super.initState();

    subjectsFuture = SubjectService.getSubjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MCQ Master',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            subjectsFuture =
                SubjectService.getSubjects();
          });

          await subjectsFuture;
        },

        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),

          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [
              const Text(
                'Hello, Ajay 👋',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                'Ready to practice today?',
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 20),

              _dailyChallenge(context),

              const SizedBox(height: 25),

              const Text(
                'Subjects',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              FutureBuilder<List<Subject>>(
                future: subjectsFuture,

                builder: (
                  context,
                  snapshot,
                ) {
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child:
                          CircularProgressIndicator(),
                    );
                  }

                  if (snapshot.hasError) {
                    return Text(
                      'Error: ${snapshot.error}',
                    );
                  }

                  final subjects =
                      snapshot.data ?? [];

                  if (subjects.isEmpty) {
                    return const Text(
                      'No subjects found.',
                    );
                  }

                  return GridView.builder(
                    shrinkWrap: true,

                    physics:
                        const NeverScrollableScrollPhysics(),

                    itemCount: subjects.length,

                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.4,
                    ),

                    itemBuilder:
                        (context, index) {
                      final subject =
                          subjects[index];

                      return CategoryCard(
                        title: subject.name,
                        icon: Icons.menu_book,

                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  QuizScreen(
                                subjectId:
                                    subject.id,
                                subjectName:
                                    subject.name,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),

              const SizedBox(height: 25),

              const Text(
                'Popular Tests',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 15),

              TestCard(
                title: 'Flutter MCQ Test',
                questions: 'Available from API',
                duration: 'Practice',

                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const QuizScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dailyChallenge(
    BuildContext context,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            const Text(
              'Daily Challenge 🚀',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'Practice questions from your subjects.',
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,

              child: FilledButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          const QuizScreen(),
                    ),
                  );
                },

                child: const Text(
                  'Start Test',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}