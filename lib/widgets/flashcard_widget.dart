import 'package:flutter/material.dart';

class FlashcardWidget extends StatefulWidget {
  final Map<String, String> card;
  final VoidCallback onMarkKnown;

  const FlashcardWidget({
    super.key,
    required this.card,
    required this.onMarkKnown,
  });

  @override
  State<FlashcardWidget> createState() => _FlashcardWidgetState();
}

class _FlashcardWidgetState extends State<FlashcardWidget> {
  bool _front = true;
  bool _known = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _front = !_front),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        child: Container(
          width: 200,
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _front
                    ? widget.card['word'] ?? ''
                    : widget.card['meaning'] ?? '',
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _known = !_known;
                  });
                  widget.onMarkKnown();
                },
                child: Text(_known ? 'Known' : 'Mark known'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
