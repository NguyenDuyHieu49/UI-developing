import 'package:flutter/material.dart';

import '../models/comment.dart';
import '../l10n/translations.dart';

class CommentsScreen extends StatefulWidget {
  final List<Comment> comments;

  const CommentsScreen({super.key, required this.comments});

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  late List<Comment> _comments;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Use the passed list directly so changes are reflected in the caller.
    // This keeps the data in-memory and simple for beginners.
    _comments = widget.comments;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addComment(String text) {
    if (text.trim().isEmpty) return;

    final newComment = Comment(
      userName: 'You',
      avatar: 'assets/images/ic_user_avatar.png',
      time: 'Just now',
      text: text.trim(),
    );

    setState(() {
      _comments.insert(0, newComment);
    });

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(t('comments_title'))),
      body: Column(
        children: [
          Expanded(
            child: _comments.isEmpty
                ? Center(child: Text(t('no_comments')))
                : ListView.separated(
                    padding: const EdgeInsets.all(12),
                    itemCount: _comments.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (context, index) {
                      final c = _comments[index];
                      final avatar = c.avatar;
                      final imageProvider = avatar.startsWith('assets/')
                          ? AssetImage(avatar) as ImageProvider
                          : NetworkImage(avatar);

                      return ListTile(
                        leading: CircleAvatar(backgroundImage: imageProvider),
                        title: Text(
                          c.userName,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(c.text),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                Text(
                                  c.time,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                if (c.likes > 0)
                                  Text(
                                    '${c.likes} likes',
                                    style: const TextStyle(fontSize: 12),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),

          // input area
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: t('no_comments'),
                        border: const OutlineInputBorder(),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                      ),
                      minLines: 1,
                      maxLines: 3,
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () => _addComment(_controller.text),
                    child: Text(t('send')),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
