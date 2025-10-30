import 'package:flutter/material.dart';

class WordCard extends StatelessWidget {
  final Map<String, dynamic> word;
  final VoidCallback onMarkLearned;

  const WordCard({super.key, required this.word, required this.onMarkLearned});

  @override
  Widget build(BuildContext context) {
    final learned = word['learned'] as bool? ?? false;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  word['word'] ?? '',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (learned)
                  Chip(label: const Text('Learned'))
                else
                  TextButton(
                    onPressed: onMarkLearned,
                    child: const Text('Mark learned'),
                  ),
              ],
            ),
            const SizedBox(height: 6),
            Text('${word['pos'] ?? ''} — ${word['definition'] ?? ''}'),
            const SizedBox(height: 6),
            Text(
              'Example: ${word['example'] ?? ''}',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
