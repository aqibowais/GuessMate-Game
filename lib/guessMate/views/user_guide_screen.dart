import 'package:flutter/material.dart';

class UserGuideScreen extends StatelessWidget {
  const UserGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff030C52),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xff030C52),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              'How to play?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.close, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'You must find the right word in 6 steps.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Click the submit button on the keyboard after each word you type and check if you guessed correctly.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'EXAMPLES',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'The letter R is in the word and in the right place.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 12),
                _buildExampleRow(['S', 'H', 'A', 'R', 'E'], correctIndex: 3),
                const SizedBox(height: 24),
                const Text(
                  'The letter L is in the word, but in the wrong place.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 12),
                _buildExampleRow(['L', 'E', 'A', 'S', 'T'], presentIndex: 0),
                const SizedBox(height: 24),
                const Text(
                  'The letter H is not in the word.',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 12),
                _buildExampleRow(['H', 'E', 'A', 'R', 'T'], absentIndex: 0),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        color: Colors.white70,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'A new word will be waiting for you every day at the same time!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExampleRow(List<String> letters,
      {int? correctIndex, int? presentIndex, int? absentIndex}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: letters.asMap().entries.map((entry) {
        final int idx = entry.key;
        final String letter = entry.value;
        Color backgroundColor;
        Color borderColor;

        if (idx == correctIndex) {
          backgroundColor = const Color(0xFF4CAF50); // Green for correct
          borderColor = const Color(0xFF4CAF50);
        } else if (idx == presentIndex) {
          backgroundColor = const Color(0xFFFF9800); // Orange for present
          borderColor = const Color(0xFFFF9800);
        } else if (idx == absentIndex) {
          backgroundColor = Colors.grey; // Grey for absent
          borderColor = Colors.grey;
        } else {
          backgroundColor = Colors.transparent;
          borderColor = Colors.white24;
        }

        return Padding(
          padding: const EdgeInsets.only(right: 4),
          child: Container(
            width: 40,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border.all(
                color: borderColor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              letter,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
