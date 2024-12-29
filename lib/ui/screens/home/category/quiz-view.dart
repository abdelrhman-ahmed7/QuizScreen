import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quizscreen/model/results.dart';
import 'package:quizscreen/ui/screens/Splash/splash-screen.dart';
import '../../../quiz-button.dart';
import '../../../widgets/app-error.dart';
import '../../../widgets/app-loader.dart';

class QuizView extends StatefulWidget {
  const QuizView({super.key});
  static const String routeName = "CategoryView";


  @override
  State<QuizView> createState() => _QuizViewState();
}

class _QuizViewState extends State<QuizView> {
  late Future<List<Results>> _QuizViewFuture;
  PageController? _pageController;
  int correctAnswers = 0;
  int incorrectAnswers = 0;

  bool finalAnswer = false;
  List<bool> answeredQuestions = [];

  @override
  void initState() {
    super.initState();
    _QuizViewFuture = _loadQuizView();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Results>>(
      future: _QuizViewFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return loadingWidget();
        } else if (snapshot.hasError) {
          return errorWidget(error: snapshot.error.toString());
        } else if (snapshot.hasData) {
          return QuizView(snapshot.data!);
        } else {
          return const Center(child: Text("No data found!"));
        }
      },
    );
  }

  Future<List<Results>> _loadQuizView() async {
    const url = "https://opentdb.com/api.php?amount=10";
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['results'] != null) {
          return (data['results'] as List)
              .map((item) => Results.fromJson(item as Map<String, dynamic>))
              .toList();
        } else {
          throw Exception("Results field is missing from API response.");
        }
      } else {
        throw Exception("Failed to load data: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching data: $e");
    }
  }

  Widget categoryWidget(Results results, List<Results> resultsList, int index) {
    List<String> allAnswers = List.from(results.incorrectAnswers ?? []);
    allAnswers.add(results.correctAnswer ?? "Unknown");
    allAnswers.shuffle();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              results.question ?? 'Unknown Question',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            QuizButtons(
              answers: allAnswers,
              correctAnswer: results.correctAnswer,
              onAnswerSelected: (selectedAnswer) {
                if (!answeredQuestions[index]) {
                  setState(() {
                    if (selectedAnswer == results.correctAnswer) {
                      correctAnswers++;
                    } else {
                      incorrectAnswers++;
                    }
                    finalAnswer = true;
                    answeredQuestions[index] = true; // Mark as answered
                  });
                }
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_pageController != null && finalAnswer) {
                  setState(() {
                    if (_pageController!.page!.toInt() == resultsList.length - 1) {
                      Navigator.pushReplacementNamed(context, SplashScreen.routeName);
                    } else {
                      // Proceed to the next page
                      _pageController!.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    }
                    finalAnswer = false; // Reset after moving to next page
                  });
                }
              },
              child: const Text("Next"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Correct: $correctAnswers', style: TextStyle(fontSize: 16)),
                SizedBox(width: 20),
                Text('Incorrect: $incorrectAnswers', style: TextStyle(fontSize: 16)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget QuizView(List<Results> resultsList) {
    answeredQuestions = List.generate(resultsList.length, (_) => false);
    return PageView.builder(
      controller: _pageController,
      itemCount: resultsList.length,
      itemBuilder: (context, index) {
        return categoryWidget(resultsList[index], resultsList, index);
      },
      onPageChanged: (int index) {
        if (answeredQuestions[index]) {
          _pageController?.jumpToPage(index); // Keep the user on the same page
        }
      },
      physics: NeverScrollableScrollPhysics(),
    );
  }
}
