import 'package:flutter/material.dart';
import '../l10n/translations.dart';

class DailyTasksScreen extends StatelessWidget {
  const DailyTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tasks = [
      {"question": "Translate: 'Hello'", "answer": "Xin chào"},
      {"question": "Fill the blank: I ___ a book", "answer": "am reading"},
      {
        "question": "Choose correct: Cat is a (animal/fruit)",
        "answer": "animal",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(t('daily_exercises')),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: tasks.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              return Card(
                elevation: 2,
                child: ListTile(
                  leading: const Icon(Icons.school, color: Colors.blue),
                  title: Text(tasks[index]["question"]!),
                  subtitle: Text("Answer: ${tasks[index]["answer"]!}"),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
