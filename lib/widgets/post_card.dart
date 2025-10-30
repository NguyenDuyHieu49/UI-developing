import 'package:flutter/material.dart';
import 'adaptive_image.dart';

class PostCard extends StatelessWidget {
  final String username;
  final String timeAgo;
  final String title;
  final String content;
  final String? imageUrl;
  final int likes;
  final int comments;
  final int shares;
  final VoidCallback? onCommentsPressed;

  const PostCard({
    super.key,
    required this.username,
    required this.timeAgo,
    required this.title,
    required this.content,
    this.imageUrl,
    this.likes = 0,
    this.comments = 0,
    this.shares = 0,
    this.onCommentsPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Header
            Row(
              children: [
                const CircleAvatar(child: Icon(Icons.person)),
                const SizedBox(width: 10),
                Text(
                  username,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 5),
                Text(timeAgo, style: const TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 10),

            /// Title
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            const SizedBox(height: 5),

            /// Content
            Text(content),
            if (imageUrl != null) ...[
              const SizedBox(height: 10),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: AdaptiveImage(imageUrl),
              ),
            ],
            const SizedBox(height: 10),

            /// Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    const Icon(Icons.favorite_border),
                    const SizedBox(width: 5),
                    Text(likes.toString()),
                  ],
                ),
                InkWell(
                  onTap: onCommentsPressed,
                  borderRadius: BorderRadius.circular(20),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.mode_comment_outlined),
                        const SizedBox(width: 5),
                        Text(comments.toString()),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    const Icon(Icons.send_outlined),
                    const SizedBox(width: 5),
                    Text(shares.toString()),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
