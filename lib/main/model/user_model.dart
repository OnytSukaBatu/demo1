class User {
  final String username;
  final String email;
  final String password;
  final String profile;
  final String desc;
  final List follow;
  final List follower;

  User({
    required this.username,
    required this.email,
    required this.password,
    required this.profile,
    required this.desc,
    required this.follow,
    required this.follower,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      username: json['username'],
      email: json['email'],
      password: json['password'],
      profile: json['profile'],
      desc: json['desc'],
      follow: json['follow'],
      follower: json['follower'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
      'profile': profile,
      'desc': desc,
      'follow': follow,
      'follower': follower,
    };
  }
}
