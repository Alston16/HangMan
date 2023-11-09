import 'package:flutter/material.dart';
import 'dart:math';
import '../services/database.dart';
import '../models/arguments.dart';
import 'package:provider/provider.dart';
import '../models/appUser.dart';
import 'loading.dart';
import '../services/painter.dart';

class GameplayPage extends StatefulWidget {
  final String movieName;
  const GameplayPage({required this.movieName, super.key});

  @override
  _GameplayPageState createState() => _GameplayPageState();
}

class _GameplayPageState extends State<GameplayPage> {
  bool loading = false;
  List<String> virtualKeyboard = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split('');
  List<List<String>> qwertyLayout = [
    ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"],
    ["A", "S", "D", "F", "G", "H", "J", "K", "L"],
    ["Z", "X", "C", "V", "B", "N", "M"],
  ];

  List<String> movieLetters = [];
  List<String> revealedLetters = [];
  int incorrectGuesses = 0;
  int maxIncorrectGuesses = 6; // Maximum incorrect guesses allowed

  @override
  void initState() {
    super.initState();
    initializeGame();
  }

  void initializeGame() {
    final movieName = widget.movieName;
    movieLetters = movieName.toUpperCase().split('');
    revealedLetters = List.filled(movieLetters.length, '__ ');
    virtualKeyboard = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split('');
    incorrectGuesses = 0;
  }

  void guessLetter(String letter, DatabaseService databaseServices) {
    setState(() {
      if (qwertyLayout[0].contains(letter)) {
        qwertyLayout[0].remove(letter);
      }
      if (qwertyLayout[1].contains(letter)) {
        qwertyLayout[1].remove(letter);
      }
      if (qwertyLayout[2].contains(letter)) {
        qwertyLayout[2].remove(letter);
      }
      if (virtualKeyboard.contains(letter)) {
        virtualKeyboard.remove(letter);
        if (movieLetters.contains(letter)) {
          // Correct guess, reveal the letter in its position(s)
          for (int i = 0; i < movieLetters.length; i++) {
            if (movieLetters[i] == letter) {
              revealedLetters[i] = letter;
            }
          }
        } else {
          // Incorrect guess, increment incorrectGuesses
          incorrectGuesses++;
        }
        checkGameOutcome(databaseServices);
      }
    });
  }

  void checkGameOutcome(DatabaseService databaseServices) async {
    if (revealedLetters.join() == movieLetters.join()) {
      setState(() {
        loading = true;
      });
      await databaseServices.updateUserScore(100 - 10 * incorrectGuesses);
      setState(() {
        loading = false;
      });
      Navigator.pushReplacementNamed(context, '/result',
          arguments:
              Arguments(true, 100 - 10 * incorrectGuesses, widget.movieName));
    } else if (incorrectGuesses >= maxIncorrectGuesses) {
      setState(() {
        loading = true;
      });
      await databaseServices.updateUserScore(-10);
      setState(() {
        loading = false;
      });
      Navigator.pushReplacementNamed(context, '/result',
          arguments: Arguments(false, -10, widget.movieName));
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);
    final databaseServices = DatabaseService(user.uid);
    double buttonSize = min(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    buttonSize = buttonSize / 10;

    List<Widget> gridRows = [];

    for (var row in qwertyLayout) {
      List<Widget> rowWidgets = [];
      for (var letter in row) {
        rowWidgets.add(
          Padding(
            padding: const EdgeInsets.all(6.0), // Add spacing between buttons
            child: Center(
                child: GestureDetector(
              onTap: () {
                guessLetter(letter, databaseServices);
              },
              child: Container(
                width: buttonSize,
                height: buttonSize,
                decoration: BoxDecoration(
                  color: Colors.blue, // Container background color
                  borderRadius:
                      BorderRadius.circular(10), // Add rounded corners
                ),
                child: Center(
                  child: Text(
                    letter,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )),
          ),
        );
      }
      gridRows.add(Row(
        mainAxisAlignment:
            MainAxisAlignment.center, // Center-align buttons horizontally
        children: rowWidgets,
      ));
    }

    return (loading)
        ? const Loading()
        : Scaffold(
            appBar: AppBar(title: const Text('Gameplay')),
            body: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomPaint(
                      size: const Size(200, 200),
                      painter: HangmanPainter(incorrectGuesses),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        revealedLetters.join(' '),
                        style: TextStyle(
                          fontSize:
                              buttonSize * 0.6, // Adjust the size as needed
                        ),
                      ),
                    ),
                    // Display virtual keyboard
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        children: gridRows,
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
