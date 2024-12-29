import 'package:flutter/material.dart';
import 'package:quizscreen/ui/quiz-button.dart';
import 'package:quizscreen/ui/screens/home/category/quiz-view.dart';

class QuizResult extends StatelessWidget {
  const QuizResult({super.key});
  static const String routeName = "QuizResult";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Ensures the column occupies minimal height
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Great Job!You've got",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center, // Center-aligns text within the widget
              ),
              const SizedBox(height: 10),
              const Text(
                "Gear up for a QuikQuiz sprint! Let's see what you've got! - Good luck!",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
                textAlign: TextAlign.center, // Center-aligns text within the widget
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, QuizView.routeName);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                  backgroundColor: Colors.orange, // Button color
                ),
                child: const Text(
                  "Start A New Quiz!",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );

  }
}
