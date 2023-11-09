import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'models/appUser.dart';
import 'services/authorization.dart';
import 'screens/login.dart';
import 'screens/register.dart';
import 'screens/menu.dart';
import 'screens/wrapper.dart';
import 'screens/result.dart';
import 'screens/profile.dart';
import 'screens/leaderboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Run the HangmanApp
  runApp(const HangmanApp());
}

class HangmanApp extends StatelessWidget {
  const HangmanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser?>.value(
      initialData: null,
      value: AuthService().user, // Provide the user authentication stream.
      child: MaterialApp(
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginPage(),
          '/registration': (context) => const RegistrationPage(),
          '/menu': (context) => const MainMenuPage(),
          '/gameplay': (context) => const Wrapper(),
          '/result': (context) => const ResultPage(),
          '/profile': (context) => const UserProfilePage(),
          '/leaderboard': (context) => const LeaderboardPage(),
        },
      ),
    );
  }
}
