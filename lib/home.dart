import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'library.dart';
import 'login.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Current user er email (Login kora na thakle default 'Student')
    String userEmail = AuthService().currentUserEmail ?? 'Student';

    return Scaffold(
      backgroundColor: Colors.grey.shade50,

      // ১. Top AppBar (Title & Logout Button)
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: const Text(
          'QAMPUS - Home',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () => _showLogoutDialog(context),
          ),
        ],
      ),

      // ২. Main Content (Scrollable Page)
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome Card (User Profile Header)
            Card(
              color: Colors.green.shade50,
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
                side: BorderSide(color: Colors.green.shade300),
              ),
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 30,
                      child: Icon(Icons.person, color: Colors.white, size: 35),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Welcome to QAMPUS!',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            userEmail,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Smart Access, Better Campus',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Section Title
            const Text(
              'Campus Services',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 15),

            // Campus Service Items (খুব সহজে একই মেথড কল করা হয়েছে)
            _buildServiceCard(
              context,
              Icons.menu_book,
              'Library',
              'Books issue, return & study room access',
            ),
            _buildServiceCard(
              context,
              Icons.restaurant,
              'Canteen',
              'Cafeteria tokens & meal schedule',
            ),
            _buildServiceCard(
              context,
              Icons.groups,
              'Club Office',
              'Student activity & event registration',
            ),
            _buildServiceCard(
              context,
              Icons.campaign,
              'Notice Board',
              'Important university notices & announcements',
            ),
            _buildServiceCard(
              context,
              Icons.account_balance,
              'Administrative Office',
              'Student ID, fees & official documents',
            ),
          ],
        ),
      ),
    );
  }

  // ৩. Service Card বানানোর সহজ Helper মেথড (Sir ke explain kora shohoj)
  Widget _buildServiceCard(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
  ) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.lightGreenAccent.shade200,
          child: Icon(icon, color: Colors.green.shade700),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          if (title == 'Library') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LibraryPage(),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$title service selected!'),
                duration: const Duration(seconds: 1),
              ),
            );
          }
        },
      ),
    );
  }

  // ৪. Logout Confirmation Dialog Function
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepOrange.shade900,
              foregroundColor: Colors.white38,
            ),
            onPressed: () {
              Navigator.pop(context); // Dialog bondho kore
              AuthService().logout(); // Session clear kore
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              ); // Login page e niye jay
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}