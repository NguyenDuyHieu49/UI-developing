import '../models/comment.dart';

class ExampleComment {
  static final List<Comment> comments = [
    Comment(
      userName: "Jack Davit",
      avatar: "assets/images/ic_user_avatar.png",
      time: "1 min",
      text: "Good idea",
    ),
    Comment(
      userName: "Lương Kết",
      avatar: "assets/images/ic_user_avatar.png",
      time: "3 day",
      text: "First Comment",
      likes: 1,
    ),
    Comment(
      userName: "Nam Nguyễn",
      avatar: "assets/images/ic_user_avatar.png",
      time: "1 hour",
      text: "Bro, you win",
      likes: 3,
      replies: 2,
    ),
  ];

  static List<Comment> getAll() => comments;
}
