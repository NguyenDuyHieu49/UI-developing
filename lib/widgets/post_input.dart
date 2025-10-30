import 'package:flutter/material.dart';

class PostInput extends StatelessWidget {
  const PostInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              children: const [
                CircleAvatar(child: Icon(Icons.person)),
                SizedBox(width: 10),
                Text(
                  "What’s on your mind?",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const Divider(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                Icon(Icons.photo_camera, color: Colors.blue),
                Icon(Icons.mail, color: Colors.blue),
                Icon(Icons.add_circle, color: Colors.blue),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
