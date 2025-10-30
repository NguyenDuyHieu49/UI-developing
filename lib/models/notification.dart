class ForumNotification {
  final String id;
  final String title;
  final String content;
  final String time;
  final bool isRead;

  ForumNotification({
    required this.id,
    required this.title,
    required this.content,
    required this.time,
    this.isRead = false,
  });
}
