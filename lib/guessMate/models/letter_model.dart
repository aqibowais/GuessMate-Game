import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:guess_mate/app/app_constants.dart';

enum LetterStatus { initial, correct, inWord, outWord }

class LetterModel extends Equatable {
  final String letter;
  final LetterStatus status;
  const LetterModel({
    required this.letter,
    this.status = LetterStatus.initial,
  });
  factory LetterModel.empty() => const LetterModel(letter: '');

  LetterModel copyWith({
    String? letter,
    LetterStatus? status,
  }) {
    return LetterModel(
      letter: letter ?? this.letter,
      status: status ?? this.status,
    );
  }

  Color getBackgroundColor() {
    switch (status) {
      case LetterStatus.initial:
        return Colors.transparent;
      case LetterStatus.correct:
        return correctColor;
      case LetterStatus.inWord:
        return inWordColor;
      case LetterStatus.outWord:
        return outWordColor;
    }
  }

  Color getBorderColor() {
    switch (status) {
      case LetterStatus.initial:
        return Colors.grey;
      default:
        return Colors.transparent;
    }
  }

  @override
  List<Object> get props => [letter, status];
}
