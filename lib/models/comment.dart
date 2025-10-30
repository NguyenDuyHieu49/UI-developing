class Comment {
  final String userName;
  final String avatar;
  final String time;
  final String text;
  final int likes;
  final int replies;

  Comment({
    required this.userName,
    required this.avatar,
    required this.time,
    required this.text,
    this.likes = 0,
    this.replies = 0,
  });
}
