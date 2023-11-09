import 'package:flutter/material.dart';

class HangmanPainter extends CustomPainter {
  int incorrectGuesses;

  HangmanPainter(this.incorrectGuesses);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;

    // Draw the vertical scaffold
    Offset startingPoint = Offset(size.width / 8, size.height / 8);
    Offset endingPoint = Offset(size.width / 8, size.height - size.height / 8);
    canvas.drawLine(startingPoint, endingPoint, paint);

    // Draw the horizontal scaffold
    startingPoint = Offset(size.width / 8, size.height / 8);
    endingPoint = Offset(6 * size.width / 8, size.height / 8);
    canvas.drawLine(startingPoint, endingPoint, paint);

    // Draw the diagonal scaffold
    startingPoint = Offset(5 * size.width / 8, 2 * size.height / 8);
    endingPoint = Offset(5 * size.width / 8, size.height / 8);
    canvas.drawLine(startingPoint, endingPoint, paint);

    // Draw the head if there's at least one incorrect guess
    if (incorrectGuesses >= 1) {
      Offset center = Offset(5 * size.width / 8, 5 * size.height / 16);
      canvas.drawCircle(center, size.height / 16, paint);
    }

    // Draw the body if there are at least two incorrect guesses
    if (incorrectGuesses >= 2) {
      startingPoint = Offset(5 * size.width / 8, 3 * size.height / 8);
      endingPoint = Offset(5 * size.width / 8, 5 * size.height / 8);
      canvas.drawLine(startingPoint, endingPoint, paint);
    }

    // Draw the left arm if there are at least three incorrect guesses
    if (incorrectGuesses >= 3) {
      startingPoint = Offset(5 * size.width / 8, 7 * size.height / 16);
      endingPoint = Offset(4 * size.width / 8, 9 * size.height / 16);
      canvas.drawLine(startingPoint, endingPoint, paint);
    }

    // Draw the right arm if there are at least four incorrect guesses
    if (incorrectGuesses >= 4) {
      startingPoint = Offset(5 * size.width / 8, 7 * size.height / 16);
      endingPoint = Offset(6 * size.width / 8, 9 * size.height / 16);
      canvas.drawLine(startingPoint, endingPoint, paint);
    }

    // Draw the left leg if there are at least five incorrect guesses
    if (incorrectGuesses >= 5) {
      startingPoint = Offset(5 * size.width / 8, 10 * size.height / 16);
      endingPoint = Offset(4 * size.width / 8, 12 * size.height / 16);
      canvas.drawLine(startingPoint, endingPoint, paint);
    }

    // Draw the right leg if there are at least six incorrect guesses
    if (incorrectGuesses >= 6) {
      startingPoint = Offset(5 * size.width / 8, 10 * size.height / 16);
      endingPoint = Offset(6 * size.width / 8, 12 * size.height / 16);
      canvas.drawLine(startingPoint, endingPoint, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
