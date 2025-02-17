import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:guess_mate/guessMate/models/letter_model.dart';

class WordModel extends Equatable {
  List<LetterModel> letters;
  WordModel({required this.letters});

  factory WordModel.fromString(String word) {
    return WordModel(
      letters:
          word.split('').map((letter) => LetterModel(letter: letter)).toList(),
    );
  }

  String get wordString => letters.map((letter) => letter.letter).join('');

  void addLetter(String val) {
    final currIdx = letters.indexWhere((e) => e.letter.isEmpty);
    if (currIdx != -1) {
      letters[currIdx] = letters[currIdx].copyWith(letter: val);
    }
  }

  void removeLetter() {
    final prevIdx = letters.lastIndexWhere((e) => e.letter.isNotEmpty);
    if (prevIdx != -1) {
      letters[prevIdx] = LetterModel.empty();
    }
  }

  WordModel copyWith({List<LetterModel>? letters}) {
    return WordModel(
      letters: letters ?? this.letters,
    );
  }

  @override
  List<Object?> get props => [letters];
}
