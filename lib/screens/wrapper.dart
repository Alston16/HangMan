import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/appUser.dart';
import '../services/database.dart';
import 'loading.dart';
import 'gameplay.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);
    return FutureBuilder(
        // Fetch a random movie name from the database
        future: DatabaseService(user.uid).getMovieName(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loading(); // Show a loading screen while fetching data
          } else {
            return GameplayPage(
                movieName: snapshot
                    .data!); // Pass the fetched movie name to the GameplayPage
          }
        });
  }
}
