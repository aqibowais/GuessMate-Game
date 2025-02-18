import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

import '../guess_mate.dart';

class Board extends StatelessWidget {
  final List<WordModel> board;
  final List<List<GlobalKey<FlipCardState>>> flipCardKeys;

  const Board({super.key, required this.board, required this.flipCardKeys});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: AspectRatio(
        aspectRatio: 5 / 6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: board
              .asMap()
              .map((i, word) => MapEntry(
                    i,
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: word.letters
                            .asMap()
                            .map((j, letter) => MapEntry(
                                  j,
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(4),
                                      child: FlipCard(
                                        back: BoardTile(letter: letter),
                                        key: flipCardKeys[i][j],
                                        flipOnTouch: false,
                                        front: BoardTile(
                                          letter: LetterModel(
                                            letter: letter.letter,
                                            status: LetterStatus.initial,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ))
                            .values
                            .toList(),
                      ),
                    ),
                  ))
              .values
              .toList(),
        ),
      ),
    );
  }
}
