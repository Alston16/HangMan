import 'package:flutter/material.dart';
import '../models/arguments.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Arguments;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Result'),
        backgroundColor: Colors.blue, // Change the app bar's background color
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              args.result
                  ? Icons.check_circle
                  : Icons
                      .cancel, // Use check or cancel icon based on the result
              color: args.result
                  ? Colors.green
                  : Colors.red, // Change icon color based on the result
              size: 100,
            ),
            const SizedBox(height: 20), // Add spacing between elements
            Text(
              args.result ? 'Congratulations!' : 'Better luck next time!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: args.result
                    ? Colors.green
                    : Colors.red, // Change text color based on the result
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Your score for the game is:',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Text(
              '${args.score}',
              style: const TextStyle(
                fontSize: 36,
                color: Colors.blue, // Change the score text color
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'The movie name was:',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Text(
              args.name,
              style: const TextStyle(
                fontSize: 24,
                color: Colors.blue, // Change the movie name text color
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Button background color
              ),
              child: const Text(
                'Go to Main Menu',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
