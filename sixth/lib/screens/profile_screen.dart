// import 'package:flutter/material.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Profile',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),

//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),

//         child: Column(
//           children: [
//             const SizedBox(height: 20),

//             const CircleAvatar(
//               radius: 50,
//               child: Icon(
//                 Icons.person,
//                 size: 50,
//               ),
//             ),

//             const SizedBox(height: 15),

//             const Text(
//               'Ajay Kumar Dhurwe',
//               style: TextStyle(
//                 fontSize: 22,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),

//             const SizedBox(height: 5),

//             Text(
//               'ajay@example.com',
//               style: TextStyle(
//                 color: Colors.grey,
//               ),
//             ),

//             const SizedBox(height: 30),

//             Card(
//               child: Column(
//                 children: [
//                   ListTile(
//                     leading: const Icon(Icons.person_outline),
//                     title: const Text('Edit Profile'),
//                     trailing: const Icon(Icons.arrow_forward_ios),
//                     onTap: () {},
//                   ),

//                   const Divider(height: 1),

//                   ListTile(
//                     leading: const Icon(Icons.history),
//                     title: const Text('Test History'),
//                     trailing: const Icon(Icons.arrow_forward_ios),
//                     onTap: () {},
//                   ),

//                   const Divider(height: 1),

//                   ListTile(
//                     leading: const Icon(Icons.settings_outlined),
//                     title: const Text('Settings'),
//                     trailing: const Icon(Icons.arrow_forward_ios),
//                     onTap: () {},
//                   ),

//                   const Divider(height: 1),

//                   ListTile(
//                     leading: const Icon(Icons.info_outline),
//                     title: const Text('About App'),
//                     trailing: const Icon(Icons.arrow_forward_ios),
//                     onTap: () {},
//                   ),
//                 ],
//               ),
//             ),

//             const SizedBox(height: 20),

//             OutlinedButton.icon(
//               onPressed: () {},

//               icon: const Icon(Icons.logout),

//               label: const Text('Logout'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




















import 'package:flutter/material.dart';

import '../models/user_profile.dart';
import '../services/profile_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() =>
      _ProfileScreenState();
}

class _ProfileScreenState
    extends State<ProfileScreen> {
  late Future<UserProfile?> profileFuture;

  @override
  void initState() {
    super.initState();

    profileFuture = _loadProfile();
  }

  Future<UserProfile?> _loadProfile() async {
    final profiles =
        await ProfileService.getProfiles();

    if (profiles.isEmpty) {
      return null;
    }

    return profiles.first;
  }

  void _reload() {
    setState(() {
      profileFuture = _loadProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        actions: [
          IconButton(
            onPressed: _addProfile,
            icon: const Icon(Icons.add),
          ),
        ],
      ),

      body: FutureBuilder<UserProfile?>(
        future: profileFuture,

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

          final profile = snapshot.data;

          if (profile == null) {
            return const Center(
              child: Text(
                'No profile available.',
              ),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),

            child: Column(
              children: [
                const SizedBox(height: 20),

                const CircleAvatar(
                  radius: 50,

                  child: Icon(
                    Icons.person,
                    size: 50,
                  ),
                ),

                const SizedBox(height: 15),

                Text(
                  profile.name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  profile.email,
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),

                if (profile.phone != null &&
                    profile.phone!.isNotEmpty) ...[
                  const SizedBox(height: 5),

                  Text(
                    profile.phone!,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],

                if (profile.bio != null &&
                    profile.bio!.isNotEmpty) ...[
                  const SizedBox(height: 10),

                  Text(
                    profile.bio!,
                    textAlign: TextAlign.center,
                  ),
                ],

                const SizedBox(height: 30),

                Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: const Icon(
                          Icons.person_outline,
                        ),

                        title: const Text(
                          'Edit Profile',
                        ),

                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                        ),

                        onTap: () {
                          _editProfile(profile);
                        },
                      ),

                      const Divider(height: 1),

                      ListTile(
                        leading: const Icon(
                          Icons.history,
                        ),

                        title: const Text(
                          'Test History',
                        ),

                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                        ),

                        onTap: () {
                          // Test history will be added later
                        },
                      ),

                      const Divider(height: 1),

                      ListTile(
                        leading: const Icon(
                          Icons.settings_outlined,
                        ),

                        title: const Text(
                          'Settings',
                        ),

                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                        ),

                        onTap: () {},
                      ),

                      const Divider(height: 1),

                      ListTile(
                        leading: const Icon(
                          Icons.info_outline,
                        ),

                        title: const Text(
                          'About App',
                        ),

                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                        ),

                        onTap: () {},
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                OutlinedButton.icon(
                  onPressed: () {
                    _deleteProfile(profile);
                  },

                  icon: const Icon(
                    Icons.delete_outline,
                  ),

                  label: const Text(
                    'Delete Profile',
                  ),
                ),

                const SizedBox(height: 10),

                OutlinedButton.icon(
                  onPressed: () {},

                  icon: const Icon(
                    Icons.logout,
                  ),

                  label: const Text(
                    'Logout',
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _addProfile() async {
    final nameController =
        TextEditingController();

    final emailController =
        TextEditingController();

    final phoneController =
        TextEditingController();

    final bioController =
        TextEditingController();

    final result = await showDialog<bool>(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Add Profile',
          ),

          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [
                TextField(
                  controller: nameController,

                  decoration:
                      const InputDecoration(
                    labelText: 'Name',
                  ),
                ),

                TextField(
                  controller: emailController,

                  keyboardType:
                      TextInputType.emailAddress,

                  decoration:
                      const InputDecoration(
                    labelText: 'Email',
                  ),
                ),

                TextField(
                  controller: phoneController,

                  keyboardType:
                      TextInputType.phone,

                  decoration:
                      const InputDecoration(
                    labelText: 'Phone',
                  ),
                ),

                TextField(
                  controller: bioController,

                  decoration:
                      const InputDecoration(
                    labelText: 'Bio',
                  ),
                ),
              ],
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  false,
                );
              },

              child: const Text(
                'Cancel',
              ),
            ),

            FilledButton(
              onPressed: () async {
                if (nameController.text
                    .trim()
                    .isEmpty ||
                    emailController.text
                        .trim()
                        .isEmpty) {
                  return;
                }

                await ProfileService
                    .createProfile(
                  name: nameController.text
                      .trim(),

                  email: emailController
                      .text
                      .trim(),

                  phone: phoneController
                      .text
                      .trim(),

                  bio: bioController.text
                      .trim(),
                );

                if (context.mounted) {
                  Navigator.pop(
                    context,
                    true,
                  );
                }
              },

              child: const Text(
                'Save',
              ),
            ),
          ],
        );
      },
    );

    if (result == true) {
      _reload();
    }
  }

  Future<void> _editProfile(
    UserProfile profile,
  ) async {
    final nameController =
        TextEditingController(
      text: profile.name,
    );

    final emailController =
        TextEditingController(
      text: profile.email,
    );

    final phoneController =
        TextEditingController(
      text: profile.phone ?? '',
    );

    final bioController =
        TextEditingController(
      text: profile.bio ?? '',
    );

    final result = await showDialog<bool>(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Edit Profile',
          ),

          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [
                TextField(
                  controller: nameController,

                  decoration:
                      const InputDecoration(
                    labelText: 'Name',
                  ),
                ),

                TextField(
                  controller: emailController,

                  keyboardType:
                      TextInputType.emailAddress,

                  decoration:
                      const InputDecoration(
                    labelText: 'Email',
                  ),
                ),

                TextField(
                  controller: phoneController,

                  keyboardType:
                      TextInputType.phone,

                  decoration:
                      const InputDecoration(
                    labelText: 'Phone',
                  ),
                ),

                TextField(
                  controller: bioController,

                  decoration:
                      const InputDecoration(
                    labelText: 'Bio',
                  ),
                ),
              ],
            ),
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  false,
                );
              },

              child: const Text(
                'Cancel',
              ),
            ),

            FilledButton(
              onPressed: () async {
                if (nameController.text
                    .trim()
                    .isEmpty ||
                    emailController.text
                        .trim()
                        .isEmpty) {
                  return;
                }

                final updated =
                    UserProfile(
                  id: profile.id,

                  name: nameController.text
                      .trim(),

                  email: emailController
                      .text
                      .trim(),

                  phone: phoneController
                      .text
                      .trim(),

                  bio: bioController.text
                      .trim(),

                  isActive:
                      profile.isActive,
                );

                await ProfileService
                    .updateProfile(
                  updated,
                );

                if (context.mounted) {
                  Navigator.pop(
                    context,
                    true,
                  );
                }
              },

              child: const Text(
                'Update',
              ),
            ),
          ],
        );
      },
    );

    if (result == true) {
      _reload();
    }
  }

  Future<void> _deleteProfile(
    UserProfile profile,
  ) async {
    final confirmed =
        await showDialog<bool>(
      context: context,

      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Delete Profile',
          ),

          content: Text(
            'Delete ${profile.name}?',
          ),

          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  false,
                );
              },

              child: const Text(
                'Cancel',
              ),
            ),

            FilledButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  true,
                );
              },

              child: const Text(
                'Delete',
              ),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      await ProfileService.deleteProfile(
        profile.id,
      );

      _reload();
    }
  }
}