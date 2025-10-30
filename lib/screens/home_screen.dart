import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../l10n/translations.dart';
import '../models/comment.dart';
import '../repositories/example_comment.dart';
import '../repositories/example_flashcards.dart';
import '../widgets/adaptive_image.dart';
import 'comments_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _postController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();
  String? _pendingImage; // data URI (web) or local file path (mobile)

  final Set<int> _likedPosts = {};

  final List<Map<String, dynamic>> posts = [
    {
      "user": "Alice",
      "avatar": "https://i.pravatar.cc/150?img=1",
      "content": "Learning English every day helps me improve quickly!",
      "image": "https://picsum.photos/400/200",
      "likes": 12,
      "comments": 3,
      "commentsList": ExampleComment.getAll(),
    },
    {
      "user": "Bob",
      "avatar": "https://i.pravatar.cc/150?img=2",
      "content": "Does anyone have tips for IELTS Writing?",
      "image": null,
      "likes": 8,
      "comments": 5,
      "commentsList": <Comment>[],
    },
  ];

  // flashcards
  late List<Map<String, dynamic>> _flashcards;
  int _currentFlashIndex = 0;
  bool _showMeaning = false;

  @override
  void initState() {
    super.initState();
    _flashcards = ExampleFlashcards.getAll()
        .map(
          (e) => {'word': e['word'], 'meaning': e['meaning'], 'known': false},
        )
        .toList();

    SharedPreferences.getInstance().then((prefs) {
      final known = prefs.getStringList('known_flashcards') ?? <String>[];
      if (known.isNotEmpty) {
        setState(() {
          for (final c in _flashcards) {
            c['known'] = known.contains(c['word']);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _postController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _persistKnownFlashcards() async {
    final prefs = await SharedPreferences.getInstance();
    final known = _flashcards
        .where((c) => c['known'] == true)
        .map((c) => c['word'] as String)
        .toList();
    await prefs.setStringList('known_flashcards', known);
  }

  void _addPost() {
    if (_postController.text.trim().isEmpty) return;

    setState(() {
      posts.insert(0, {
        'user': 'You',
        'avatar': 'https://i.pravatar.cc/150?img=5',
        'content': _postController.text.trim(),
        'image':
            _pendingImage ??
            'https://picsum.photos/400/300?random=${posts.length + 1}',
        'likes': 0,
        'comments': 0,
        'commentsList': <Comment>[],
      });
    });

    _postController.clear();
    _pendingImage = null;
    Navigator.of(context).maybePop();
  }

  // Simplified image selection for beginners: use an image URL instead of
  // a native file picker. The old file-picker logic was removed to keep the
  // project easy to run on web and avoid native platform setup for students.

  void _showCreatePostDialog() {
    _pendingImage = null;

    final isWide = MediaQuery.of(context).size.width >= 700 || kIsWeb;

    if (isWide) {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: StatefulBuilder(
                  builder: (context, setStateDialog) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          t('create_post'),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: _postController,
                          decoration: InputDecoration(
                            hintText: t('whats_on_your_mind'),
                            border: const OutlineInputBorder(),
                          ),
                          maxLines: 6,
                        ),
                        const SizedBox(height: 12),
                        if (_pendingImage != null)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: SizedBox(
                              height: 220,
                              child: AdaptiveImage(_pendingImage),
                            ),
                          ),
                        const SizedBox(height: 12),
                        // Simple image URL input for students: paste an image URL
                        TextField(
                          controller: _imageUrlController,
                          decoration: InputDecoration(
                            hintText: 'Image URL (optional)',
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () => setStateDialog(() {
                                _imageUrlController.clear();
                                _pendingImage = null;
                              }),
                            ),
                            border: const OutlineInputBorder(),
                          ),
                          onChanged: (v) => setStateDialog(
                            () => _pendingImage = v.isNotEmpty ? v : null,
                          ),
                        ),
                        const SizedBox(height: 8),
                        if (_pendingImage != null)
                          Row(
                            children: [
                              OutlinedButton(
                                onPressed: () =>
                                    setStateDialog(() => _pendingImage = null),
                                child: Text(t('remove')),
                              ),
                              const SizedBox(width: 12),
                              const Text('Preview shown above'),
                            ],
                          ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text(t('cancel')),
                            ),
                            const SizedBox(width: 8),
                            ElevatedButton(
                              onPressed: _addPost,
                              child: Text(t('post')),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        },
      );
    } else {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setStateDialog) {
              final viewInsets = MediaQuery.of(context).viewInsets;
              return Padding(
                padding: EdgeInsets.only(
                  bottom: viewInsets.bottom,
                  left: 16,
                  right: 16,
                  top: 16,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            t('create_post'),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            onPressed: () => Navigator.of(context).pop(),
                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _postController,
                        decoration: InputDecoration(
                          hintText: t('whats_on_your_mind'),
                          border: const OutlineInputBorder(),
                        ),
                        maxLines: 4,
                      ),
                      const SizedBox(height: 8),
                      if (_pendingImage != null) ...[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: SizedBox(
                            height: 160,
                            child: AdaptiveImage(_pendingImage),
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                      // Image URL input (simpler than file-picker for students)
                      TextField(
                        controller: _imageUrlController,
                        decoration: InputDecoration(
                          hintText: 'Image URL (optional)',
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () => setStateDialog(() {
                              _imageUrlController.clear();
                              _pendingImage = null;
                            }),
                          ),
                          border: const OutlineInputBorder(),
                        ),
                        onChanged: (v) => setStateDialog(
                          () => _pendingImage = v.isNotEmpty ? v : null,
                        ),
                      ),
                      if (_pendingImage != null) ...[
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () =>
                                  setStateDialog(() => _pendingImage = null),
                              child: Text(t('remove')),
                            ),
                            const SizedBox(width: 12),
                            const Text('Preview shown above'),
                          ],
                        ),
                      ],
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(),
                            child: Text(t('cancel')),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            onPressed: _addPost,
                            child: Text(t('post')),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              );
            },
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t('app_title')),
        actions: [
          IconButton(
            onPressed: _showCreatePostDialog,
            icon: const Icon(Icons.create),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 900),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                // Flashcard panel (simple)
                if (_flashcards.isNotEmpty)
                  Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                t('study_flashcards'),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '${_currentFlashIndex + 1}/${_flashcards.length}',
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Center(
                            child: Text(
                              _flashcards[_currentFlashIndex]['word'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          if (_showMeaning) ...[
                            const SizedBox(height: 8),
                            Center(
                              child: Text(
                                _flashcards[_currentFlashIndex]['meaning'],
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: _currentFlashIndex > 0
                                    ? () => setState(() => _currentFlashIndex--)
                                    : null,
                                icon: const Icon(Icons.chevron_left),
                              ),
                              OutlinedButton(
                                onPressed: () => setState(
                                  () => _showMeaning = !_showMeaning,
                                ),
                                child: Text(
                                  _showMeaning ? t('hide') : t('show_meaning'),
                                ),
                              ),
                              IconButton(
                                onPressed:
                                    _currentFlashIndex < _flashcards.length - 1
                                    ? () => setState(() => _currentFlashIndex++)
                                    : null,
                                icon: const Icon(Icons.chevron_right),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Builder(
                              builder: (context) {
                                final isKnown =
                                    (_flashcards[_currentFlashIndex]['known'] ??
                                            false)
                                        as bool;
                                return TextButton.icon(
                                  onPressed: () {
                                    setState(() {
                                      final card =
                                          _flashcards[_currentFlashIndex];
                                      card['known'] = !isKnown;
                                      _persistKnownFlashcards();
                                    });
                                  },
                                  icon: Icon(
                                    isKnown ? Icons.check_circle : Icons.check,
                                    color: isKnown ? Colors.green : null,
                                  ),
                                  label: Text(
                                    isKnown ? t('known') : t('mark_known'),
                                    style: TextStyle(
                                      color: isKnown ? Colors.green : null,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                const SizedBox(height: 10),

                // Posts feed
                Expanded(
                  child: posts.isEmpty
                      ? Center(child: Text(t('no_results')))
                      : ListView.builder(
                          itemCount: posts.length,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) {
                            final post = posts[index];
                            return Card(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 3,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 22,
                                          backgroundImage:
                                              (post['avatar'] != null &&
                                                  post['avatar']
                                                      .toString()
                                                      .startsWith('assets/'))
                                              ? AssetImage(post['avatar'])
                                                    as ImageProvider
                                              : NetworkImage(post['avatar']),
                                        ),
                                        const SizedBox(width: 12),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              post['user'],
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              t('just_now'),
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      post['content'],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 15),
                                    ),
                                    const SizedBox(height: 10),
                                    if (post['image'] != null)
                                      Center(
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            10,
                                          ),
                                          child: AdaptiveImage(post['image']),
                                        ),
                                      ),
                                    const SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            IconButton(
                                              icon: _likedPosts.contains(index)
                                                  ? const Icon(
                                                      Icons.thumb_up,
                                                      color: Colors.blue,
                                                      size: 20,
                                                    )
                                                  : const Icon(
                                                      Icons
                                                          .thumb_up_alt_outlined,
                                                      size: 20,
                                                    ),
                                              onPressed: () => setState(() {
                                                if (_likedPosts.contains(
                                                  index,
                                                )) {
                                                  _likedPosts.remove(index);
                                                  posts[index]['likes'] =
                                                      (posts[index]['likes']
                                                          as int) -
                                                      1;
                                                } else {
                                                  _likedPosts.add(index);
                                                  posts[index]['likes'] =
                                                      (posts[index]['likes']
                                                          as int) +
                                                      1;
                                                }
                                              }),
                                              splashRadius: 20,
                                            ),
                                            const SizedBox(width: 8),
                                            Text("${post['likes']} Likes"),
                                          ],
                                        ),
                                        const SizedBox(width: 16),
                                        InkWell(
                                          onTap: () async {
                                            await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (_) => CommentsScreen(
                                                  comments:
                                                      post['commentsList']
                                                          as List<Comment>,
                                                ),
                                              ),
                                            );
                                            setState(() {
                                              post['comments'] =
                                                  (post['commentsList'] as List)
                                                      .length;
                                            });
                                          },
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.comment_outlined,
                                                size: 20,
                                              ),
                                              const SizedBox(width: 8),
                                              Text(
                                                "${post['comments']} Comments",
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        IconButton(
                                          icon: const Icon(
                                            Icons.share_outlined,
                                            size: 20,
                                          ),
                                          onPressed: () async {
                                            final content =
                                                (post['content'] ?? '')
                                                    .toString();
                                            if (content.isEmpty) {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    'Nothing to share',
                                                  ),
                                                ),
                                              );
                                              return;
                                            }
                                            final messenger =
                                                ScaffoldMessenger.of(context);
                                            messenger.showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  'Opening share dialog...',
                                                ),
                                              ),
                                            );
                                            try {
                                              await Share.share(content);
                                            } catch (e) {
                                              messenger.showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Share failed: $e',
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                          splashRadius: 20,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
