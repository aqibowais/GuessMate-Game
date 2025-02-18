import 'dart:math';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:guess_mate/app/app_constants.dart';
import 'package:guess_mate/guessMate/views/user_guide_screen.dart';
import 'package:guess_mate/guessMate/widgets/guessmate_header.dart';

import '../guess_mate.dart';

enum GameStatus { playing, submitting, won, lost }

class GuessMateScreen extends StatefulWidget {
  const GuessMateScreen({super.key});

  @override
  State<GuessMateScreen> createState() => _GuessMateScreenState();
}

class _GuessMateScreenState extends State<GuessMateScreen> {
  GameStatus gameStatus = GameStatus.playing;
  Set<LetterModel> selectedLetters = {};
  final List<List<GlobalKey<FlipCardState>>> flipCardKeys = List.generate(
    6,
    (_) => List.generate(
      5,
      (_) => GlobalKey<FlipCardState>(),
    ),
  );
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

  WordModel answer = WordModel.fromString(
      fiveLetterWord[Random().nextInt(fiveLetterWord.length)].toUpperCase());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff030C52), // Dark navy background
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.person, color: Colors.white, size: 20),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline, color: Colors.white),
            onPressed: () => Navigator.of(context).push(
              (MaterialPageRoute(
                builder: (context) => const UserGuideScreen(),
              )),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                const GuessMateHeader(),
                Board(
                  board: board,
                  flipCardKeys: flipCardKeys,
                ),
                const Spacer(),
                Keyboard(
                  onKeyTapped: _onKeyTapped,
                  onDeleteTapped: _onDeleteTapped,
                  onEnterTapped: _onEnterTapped,
                  selectedLetters: selectedLetters,
                ),
                const SizedBox(height: 30),
              ],
            );
          },
        ),
      ),
    );
  }

  void _onKeyTapped(String letter) {
    debugPrint(answer.toString());
    // print(letter);
    if (gameStatus == GameStatus.playing) {
      setState(() => currWord?.addLetter(letter));
    }
  }

  void _onDeleteTapped() {
    if (gameStatus == GameStatus.playing) {
      setState(() => currWord?.removeLetter());
    }
  }

  Future<void> _onEnterTapped() async {
    if (gameStatus == GameStatus.playing &&
        currWord != null &&
        !currWord!.letters.contains(LetterModel.empty())) {
      gameStatus = GameStatus.submitting;
      for (var i = 0; i < currWord!.letters.length; i++) {
        final currWordLetter = currWord!.letters[i];
        final currAnsLetter = answer.letters[i];

        setState(() {
          if (currWordLetter == currAnsLetter) {
            currWord!.letters[i] =
                currWordLetter.copyWith(status: LetterStatus.correct);
          } else if (answer.letters.contains(currWordLetter)) {
            currWord!.letters[i] =
                currWordLetter.copyWith(status: LetterStatus.inWord);
          } else {
            currWord!.letters[i] =
                currWordLetter.copyWith(status: LetterStatus.outWord);
          }
        });

        setState(() {
          // Remove old entry and add the updated one
          selectedLetters.removeWhere((e) => e.letter == currWordLetter.letter);
          selectedLetters.add(currWord!.letters[i]);
        });

        await Future.delayed(const Duration(milliseconds: 150),
            () => flipCardKeys[currIdx][i].currentState?.toggleCard());
      }

      _chechIfWinOrLose();
    }
  }

  _chechIfWinOrLose() {
    if (currWord!.wordString == answer.wordString) {
      gameStatus = GameStatus.won;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          dismissDirection: DismissDirection.none,
          backgroundColor: correctColor,
          content: const Text(
            'You won!',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          duration: const Duration(seconds: 2),
          action: SnackBarAction(
            label: "New Game",
            onPressed: _restart,
            textColor: Colors.white,
          ),
        ),
      );
    } else if (currIdx + 1 >= board.length) {
      gameStatus = GameStatus.lost;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          dismissDirection: DismissDirection.none,
          backgroundColor: Colors.redAccent[200],
          content: Text(
            'You lost! The correct word was: ${answer.wordString}',
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          duration: const Duration(seconds: 2),
          action: SnackBarAction(
            label: "New Game",
            onPressed: _restart,
            textColor: Colors.white,
          ),
        ),
      );
      _restart();
    } else {
      gameStatus = GameStatus.playing;
    }
    currIdx++;
  }

  _restart() {
    setState(() {
      gameStatus = GameStatus.playing;
      currIdx = 0;
      board
        ..clear()
        ..addAll(
          List.generate(
            6,
            (_) => WordModel(
              letters: List.generate(
                5,
                (_) => LetterModel.empty(),
              ),
            ),
          ),
        );
      answer = WordModel.fromString(
          fiveLetterWord[Random().nextInt(fiveLetterWord.length)]
              .toUpperCase());
      selectedLetters.clear();
      flipCardKeys
        ..clear()
        ..addAll(
          List.generate(
            6,
            (_) => List.generate(
              5,
              (_) => GlobalKey<FlipCardState>(),
            ),
          ),
        );
    });
  }
}
