import 'package:flutter/material.dart';

import '../guess_mate.dart';

class BoardTile extends StatelessWidget {
  final LetterModel letter;

  const BoardTile({super.key, required this.letter});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: letter.status == LetterStatus.initial
            ? Colors.transparent
            : letter.getBackgroundColor(),
        border: Border.all(
          color: letter.status == LetterStatus.initial
              ? Colors.white24
              : letter.getBorderColor(),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Text(
            letter.letter,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: letter.status == LetterStatus.initial
                  ? Colors.white
                  : Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
// 

