class Post {
  final String id;
  final String userName;
  final String avatar;
  final String time;
  final String title;
  final String content;
  final String? imageUrl;
  final int likes;
  final int comments;
  final int shares;

  Post({
    required this.id,
    required this.userName,
    required this.avatar,
    required this.time,
    required this.title,
    required this.content,
    this.imageUrl,
    this.likes = 0,
    this.comments = 0,
    this.shares = 0,
  });
}
