class Post {
  final String username;
  final String email;
  final String profile;
  final List<String> imageList;
  final String desc;
  final String date;
  final List<String> like;

  Post({
    required this.username,
    required this.email,
    required this.profile,
    required this.imageList,
    required this.desc,
    required this.date,
    required this.like,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      username: json['username'],
      email: json['email'],
      profile: json['profile'],
      imageList: List<String>.from(json['imageList'] ?? []),
      desc: json['desc'],
      date: json['date'],
      like: List<String>.from(json['like'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'profile': profile,
      'imageList': imageList,
      'desc': desc,
      'date': date,
      'like': like,
    };
  }
}
