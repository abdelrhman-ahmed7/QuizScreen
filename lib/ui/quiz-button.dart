import 'package:flutter/material.dart';

class QuizButtons extends StatefulWidget {
  final List<String> answers;
  final String? correctAnswer;
  final ValueChanged<String> onAnswerSelected; // Callback to notify parent

  const QuizButtons({
    Key? key,
    required this.answers,
    required this.correctAnswer,
    required this.onAnswerSelected,
    // Passing callback
  }) : super(key: key);

  @override
  _QuizButtonsState createState() => _QuizButtonsState();
}

class _QuizButtonsState extends State<QuizButtons> {
  late List<bool> selectedAnswers; // Track which button is selected
  late List<Color> buttonColors; // Store colors for each button
  bool answerSelected = false; // Track if an answer is selected

  @override
  void initState() {
    super.initState();
    selectedAnswers = List.generate(widget.answers.length, (_) => false);
    buttonColors = List.generate(widget.answers.length, (_) => Colors.white70); // Initial color
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < widget.answers.length; i++)
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(buttonColors[i]), // Button color
              foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
              textStyle: MaterialStateProperty.all<TextStyle>(const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )),
            ),
            onPressed: answerSelected
                ? null
                : () {
              setState(() {

                selectedAnswers[i] = true;

                if (widget.answers[i] == widget.correctAnswer) {
                  buttonColors[i] = Colors.green;
                } else {
                  buttonColors[i] = Colors.red;
                }
                answerSelected = true;
              });

              widget.onAnswerSelected(widget.answers[i]);
            },
            child: Text(widget.answers[i]),
          ),
      ],
    );
  }
}
