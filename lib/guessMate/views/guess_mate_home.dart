import 'dart:math';

import 'package:flutter/material.dart';
import 'package:guess_mate/guessMate/data/word_list.dart';
import 'package:guess_mate/guessMate/models/letter_model.dart';
import 'package:guess_mate/guessMate/models/word_model.dart';

enum GameStatus { playing, submitting, won, lost }

class GuessMateHome extends StatefulWidget {
  const GuessMateHome({super.key});

  @override
  State<GuessMateHome> createState() => _GuessMateHomeState();
}

class _GuessMateHomeState extends State<GuessMateHome> {
  GameStatus gameStatus = GameStatus.playing;

  List<WordModel> board = List.generate(
    6,
    (_) => WordModel(
      letters: List.generate(
        5,
        (_) => LetterModel.empty(),
      ),
    ),
  );
  int currIdx = 0;
  // Class-level getter
  WordModel? get currWord => currIdx < board.length ? board[currIdx] : null;

  final WordModel answer = WordModel.fromString(
      fiveLetterWord[Random().nextInt(fiveLetterWord.length)].toUpperCase());
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
