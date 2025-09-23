import 'package:flutter/material.dart';
import 'login_page.dart'; // Import the login page

class PantryPage extends StatelessWidget {
  const PantryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Main content of the Pantry page
        const Center(
          child: Text(
            'Pantry',
            style: TextStyle(fontSize: 24),
          ),
        ),
        // Login button positioned at the top right
        Positioned(
          top: 10,
          right: 10,
          child: IconButton(
            icon: const Icon(
              Icons.account_circle_outlined,
              size: 32, // Adjust size as needed
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ),
      ],
    );
  }
}
