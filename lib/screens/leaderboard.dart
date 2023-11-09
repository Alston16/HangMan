import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/appUser.dart';
import '../models/userData.dart';
import '../services/database.dart';
import 'loading.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);

    return StreamBuilder<List<UserData>>(
      // Stream to get real-time leaderboard entries
      stream: DatabaseService(user.uid).leaderboardEntries,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<UserData>? leaderboardEntries = snapshot.data;

          return Scaffold(
            appBar: AppBar(title: const Text('LeaderBoard')),
            body: ListView.builder(
              itemCount: leaderboardEntries!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Card(
                    margin:
                    const EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 25.0,
                        backgroundColor: (index > 2)
                            ? Colors.blue
                            : ((index == 2)
                            ? Colors.orange[900]
                            : ((index == 1)
                            ? Colors.grey
                            : Colors.yellow[700])),
                        child: Text(
                          '${index + 1}',
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                      title: Text(leaderboardEntries[index].username),
                      subtitle: Text(
                          'Score : ${leaderboardEntries[index].score}'),
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return const Loading();  // Show a loading screen while fetching leaderboard data
        }
      },
    );
  }
}
