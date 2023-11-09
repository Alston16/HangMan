import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/appUser.dart';
import '../models/userData.dart';
import '../services/database.dart';
import 'loading.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);

    return StreamBuilder<UserData>(
      // Stream to get real-time user data
      stream: DatabaseService(user.uid).userData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          UserData? userData = snapshot.data;

          return Scaffold(
            appBar: AppBar(
              title: const Text('User Profile'),
              backgroundColor:
                  Colors.blue, // Change the app bar's background color
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    // Display a user's profile picture if available
                    radius: 60,
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.account_circle,
                      size: 100,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20), // Add spacing between elements
                  const Text(
                    'Username:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    userData!.username,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.blue,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Score:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${userData.score}',
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const Loading(); // Show a loading screen while fetching user data
        }
      },
    );
  }
}
