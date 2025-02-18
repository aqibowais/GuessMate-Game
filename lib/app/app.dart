import 'package:flutter/material.dart';
import 'package:guess_mate/guessMate/guess_mate.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.black),
      home: const GuessMateScreen(),
    );
  }
}
