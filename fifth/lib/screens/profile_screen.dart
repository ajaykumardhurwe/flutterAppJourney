import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
      ),

      body: SingleChildScrollView(
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

            const Text(
              'Ajay Kumar Dhurwe',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              'ajay@example.com',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 30),

            Card(
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.person_outline),
                    title: const Text('Edit Profile'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),

                  const Divider(height: 1),

                  ListTile(
                    leading: const Icon(Icons.history),
                    title: const Text('Test History'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),

                  const Divider(height: 1),

                  ListTile(
                    leading: const Icon(Icons.settings_outlined),
                    title: const Text('Settings'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),

                  const Divider(height: 1),

                  ListTile(
                    leading: const Icon(Icons.info_outline),
                    title: const Text('About App'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            OutlinedButton.icon(
              onPressed: () {},

              icon: const Icon(Icons.logout),

              label: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}