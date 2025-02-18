import 'package:flutter/material.dart';
import 'package:guess_mate/guessMate/models/letter_model.dart';

const qwerty = [
  ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
  ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
  ['Enter', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', 'Del'],
];

class Keyboard extends StatelessWidget {
  final void Function(String) onKeyTapped;
  final VoidCallback onDeleteTapped;
  final VoidCallback onEnterTapped;
  final Set<LetterModel> selectedLetters;

  const Keyboard({
    super.key,
    required this.onKeyTapped,
    required this.onDeleteTapped,
    required this.onEnterTapped,
    required this.selectedLetters,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: qwerty
          .map((keys) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: keys.map((letter) {
                  LetterModel letterKey = selectedLetters.firstWhere(
                      (e) => e.letter == letter,
                      orElse: () => LetterModel.empty());
                  if (letter == 'Enter') {
                    return _KeyboardButton.enter(onTap: onEnterTapped);
                  } else if (letter == 'Del') {
                    return _KeyboardButton.delete(onTap: onDeleteTapped);
                  }
                  return _KeyboardButton(
                    letter: letter,
                    onPressed: () => onKeyTapped(letter),
                    backgroundColor: letterKey != LetterModel.empty()
                        ? letterKey.getBackgroundColor()
                        : Colors.grey.shade600,
                  );
                }).toList(),
              ))
          .toList(),
    );
  }
}

class _KeyboardButton extends StatelessWidget {
  final double width;
  final double height = 48;
  final String letter;
  final VoidCallback onPressed;
  final Color backgroundColor;

  const _KeyboardButton({
    this.width = 30,
    required this.letter,
    required this.onPressed,
    required this.backgroundColor,
  });

  factory _KeyboardButton.delete({required VoidCallback onTap}) =>
      _KeyboardButton(
        width: 50,
        letter: 'Del',
        onPressed: onTap,
        backgroundColor: Colors.red,
      );

  factory _KeyboardButton.enter({required VoidCallback onTap}) =>
      _KeyboardButton(
        width: 50,
        letter: 'Enter',
        onPressed: onTap,
        backgroundColor: Colors.green,
      );

  @override
  Widget build(BuildContext context) {
    final double buttonWidth = width;
    return Padding(
      padding: const EdgeInsets.all(2),
      child: Material(
        borderRadius: BorderRadius.circular(4),
        color: backgroundColor,
        child: InkWell(
          onTap: onPressed,
          child: Container(
            width: buttonWidth,
            height: height,
            alignment: Alignment.center,
            child: Text(
              letter,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
