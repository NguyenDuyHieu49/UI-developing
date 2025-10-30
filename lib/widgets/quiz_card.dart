import 'package:flutter/material.dart';

class QuizCard extends StatefulWidget {
  final Map<String, dynamic> quiz;

  const QuizCard({super.key, required this.quiz});

  @override
  State<QuizCard> createState() => _QuizCardState();
}

class _QuizCardState extends State<QuizCard> {
  int? _selected;
  bool _checked = false;

  void _checkAnswer() {
    if (_selected == null) return;
    setState(() {
      _checked = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final options = List<String>.from(widget.quiz['options'] ?? []);
    final answerIndex = widget.quiz['answerIndex'] as int? ?? 0;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.quiz['question'] ?? '',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...options.asMap().entries.map((e) {
              final i = e.key;
              final text = e.value;
              Color? tileColor;
              if (_checked) {
                if (i == answerIndex) tileColor = Colors.green.shade50;
                if (_selected == i && i != answerIndex) {
                  tileColor = Colors.red.shade50;
                }
              }

              final selected = _selected == i;

              return Container(
                color: tileColor,
                child: InkWell(
                  onTap: _checked ? null : () => setState(() => _selected = i),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        // Visual selection indicator
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          child: Icon(
                            selected
                                ? Icons.radio_button_checked
                                : Icons.radio_button_off,
                            color: selected ? Colors.blue : Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(child: Text(text)),
                      ],
                    ),
                  ),
                ),
              );
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (!_checked)
                  ElevatedButton(
                    onPressed: _checkAnswer,
                    child: const Text('Check'),
                  )
                else
                  TextButton(
                    onPressed: () => setState(() {
                      _selected = null;
                      _checked = false;
                    }),
                    child: const Text('Next'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
