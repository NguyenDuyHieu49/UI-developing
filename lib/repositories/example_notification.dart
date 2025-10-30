import '../models/notification.dart';

class ExampleNotification {
  static final List<ForumNotification> notifications = [
    ForumNotification(
      id: "1",
      title: "Welcome!",
      content: "Thanks for joining The English Forum 🎉",
      time: "Just now",
    ),
    ForumNotification(
      id: "2",
      title: "New Post",
      content: "John Doe has posted a new discussion",
      time: "2h ago",
    ),
    ForumNotification(
      id: "3",
      title: "Reminder",
      content: "Don’t forget to try today’s daily question!",
      time: "1 day ago",
    ),
  ];

  static List<ForumNotification> getAll() => notifications;
}
