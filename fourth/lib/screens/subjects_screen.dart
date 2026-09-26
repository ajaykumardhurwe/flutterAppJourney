// import 'package:flutter/material.dart';

// import '../widgets/category_card.dart';

// class SubjectsScreen extends StatelessWidget {
//   const SubjectsScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final subjects = [
//       {
//         'name': 'Flutter',
//         'icon': Icons.phone_android,
//       },
//       {
//         'name': 'C++',
//         'icon': Icons.code,
//       },
//       {
//         'name': 'Java',
//         'icon': Icons.coffee,
//       },
//       {
//         'name': 'DSA',
//         'icon': Icons.account_tree,
//       },
//       {
//         'name': 'DBMS',
//         'icon': Icons.storage,
//       },
//       {
//         'name': 'Operating System',
//         'icon': Icons.computer,
//       },
//       {
//         'name': 'Computer Networks',
//         'icon': Icons.network_check,
//       },
//       {
//         'name': 'Aptitude',
//         'icon': Icons.calculate,
//       },
//     ];

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Subjects',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),

//       body: GridView.builder(
//         padding: const EdgeInsets.all(16),

//         itemCount: subjects.length,

//         gridDelegate:
//             const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,

//           crossAxisSpacing: 12,

//           mainAxisSpacing: 12,

//           childAspectRatio: 1.2,
//         ),

//         itemBuilder: (context, index) {
//           final subject = subjects[index];

//           return CategoryCard(
//             title: subject['name'] as String,
//             icon: subject['icon'] as IconData,

//             onTap: () {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(
//                   content: Text(
//                     '${subject['name']} selected',
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }



























import 'package:flutter/material.dart';

import '../models/subject.dart';
import '../services/subject_service.dart';
import '../widgets/category_card.dart';

class SubjectsScreen extends StatefulWidget {
  const SubjectsScreen({super.key});

  @override
  State<SubjectsScreen> createState() =>
      _SubjectsScreenState();
}

class _SubjectsScreenState
    extends State<SubjectsScreen> {
  late Future<List<Subject>> subjectsFuture;

  @override
  void initState() {
    super.initState();

    subjectsFuture =
        SubjectService.getSubjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Subjects',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            onPressed: _addSubject,
            icon: const Icon(Icons.add),
          ),
        ],
      ),

      body: FutureBuilder<List<Subject>>(
        future: subjectsFuture,

        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
              ),
            );
          }

          final subjects =
              snapshot.data ?? [];

          if (subjects.isEmpty) {
            return const Center(
              child: Text(
                'No subjects available.',
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),

            itemCount: subjects.length,

            itemBuilder: (context, index) {
              final subject =
                  subjects[index];

              return Card(
                margin: const EdgeInsets.only(
                  bottom: 12,
                ),

                child: ListTile(
                  leading: const CircleAvatar(
                    child: Icon(
                      Icons.menu_book,
                    ),
                  ),

                  title: Text(
                    subject.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  subtitle: Text(
                    subject.description ??
                        'No description',
                  ),

                  trailing: PopupMenuButton(
                    itemBuilder: (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: Text('Edit'),
                      ),

                      const PopupMenuItem(
                        value: 'delete',
                        child: Text('Delete'),
                      ),
                    ],

                    onSelected: (value) {
                      if (value == 'edit') {
                        _editSubject(subject);
                      }

                      if (value == 'delete') {
                        _deleteSubject(subject);
                      }
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _reload() {
    setState(() {
      subjectsFuture =
          SubjectService.getSubjects();
    });
  }

  Future<void> _addSubject() async {
    final nameController =
        TextEditingController();

    final descriptionController =
        TextEditingController();

    final result = await showDialog<bool>(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Add Subject',
          ),

          content: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              TextField(
                controller: nameController,
                decoration:
                    const InputDecoration(
                  labelText: 'Subject Name',
                ),
              ),

              TextField(
                controller:
                    descriptionController,
                decoration:
                    const InputDecoration(
                  labelText: 'Description',
                ),
              ),
            ],
          ),

          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(context),

              child: const Text('Cancel'),
            ),

            FilledButton(
              onPressed: () async {
                if (nameController
                    .text
                    .trim()
                    .isEmpty) {
                  return;
                }

                await SubjectService
                    .createSubject(
                  name: nameController
                      .text
                      .trim(),

                  description:
                      descriptionController
                          .text
                          .trim(),
                );

                if (context.mounted) {
                  Navigator.pop(
                    context,
                    true,
                  );
                }
              },

              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    if (result == true) {
      _reload();
    }
  }

  Future<void> _editSubject(
    Subject subject,
  ) async {
    final nameController =
        TextEditingController(
      text: subject.name,
    );

    final descriptionController =
        TextEditingController(
      text: subject.description ?? '',
    );

    final result = await showDialog<bool>(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Edit Subject',
          ),

          content: Column(
            mainAxisSize: MainAxisSize.min,

            children: [
              TextField(
                controller: nameController,
                decoration:
                    const InputDecoration(
                  labelText: 'Subject Name',
                ),
              ),

              TextField(
                controller:
                    descriptionController,
                decoration:
                    const InputDecoration(
                  labelText: 'Description',
                ),
              ),
            ],
          ),

          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(context),

              child: const Text('Cancel'),
            ),

            FilledButton(
              onPressed: () async {
                final updated =
                    Subject(
                  id: subject.id,

                  name: nameController
                      .text
                      .trim(),

                  description:
                      descriptionController
                          .text
                          .trim(),

                  isActive:
                      subject.isActive,
                );

                await SubjectService
                    .updateSubject(
                  updated,
                );

                if (context.mounted) {
                  Navigator.pop(
                    context,
                    true,
                  );
                }
              },

              child: const Text('Update'),
            ),
          ],
        );
      },
    );

    if (result == true) {
      _reload();
    }
  }

  Future<void> _deleteSubject(
    Subject subject,
  ) async {
    final confirmed =
        await showDialog<bool>(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Delete Subject',
          ),

          content: Text(
            'Delete ${subject.name}?',
          ),

          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.pop(
                context,
                false,
              ),

              child: const Text(
                'Cancel',
              ),
            ),

            FilledButton(
              onPressed: () =>
                  Navigator.pop(
                context,
                true,
              ),

              child: const Text(
                'Delete',
              ),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      await SubjectService.deleteSubject(
        subject.id,
      );

      _reload();
    }
  }
}