import '../models/post.dart';

class ExamplePost {
  static final List<Post> posts = [
    Post(
      id: "1",
      userName: "John Doe",
      avatar: "assets/images/ic_user_avatar.png",
      time: "3 hours ago",
      title: "Welcome to the Forum!",
      content: "This is our first post. Let’s build a great community together!",
      imageUrl: "https://cdn.oneesports.vn/cdn-data/sites/4/2023/05/kimetsunoyaiba-anime.jpg",
      likes: 1,
      comments: 0,
      shares: 0,
    ),
    Post(
      id: "2",
      userName: "Davit",
      avatar: "assets/images/ic_user_avatar.png",
      time: "4 hours ago",
      title: "Riddle Time",
      content: "What can you never see but constantly right in front of you?",
      likes: 0,
      comments: 0,
      shares: 0,
    ),
  ];

  static List<Post> getAll() => posts;
}
