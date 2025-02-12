import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String username;
  final String email;
  final String profile;
  final List<String> image;
  final String desc;
  final Timestamp date;
  final List<String> like;

  Post({
    required this.username,
    required this.email,
    required this.profile,
    required this.image,
    required this.desc,
    required this.date,
    required this.like,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      username: json['username'],
      email: json['email'],
      profile: json['profile'],
      image: List<String>.from(json['image'] ?? []),
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
      'image': image,
      'desc': desc,
      'date': date,
      'like': like,
    };
  }
}
