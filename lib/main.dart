import 'package:flutter/material.dart';
import 'package:quizscreen/ui/screens/Splash/splash-screen.dart';
import 'package:quizscreen/ui/screens/home/category/quiz-view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    routes: {
   SplashScreen.routeName:(_)=>SplashScreen(),
      QuizView.routeName:(_)=>QuizView(),
    },
      initialRoute:SplashScreen.routeName ,
    );
  }
}