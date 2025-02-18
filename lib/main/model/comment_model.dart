import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  final String idContent;
  final String profile;
  final String email;
  final String text;
  final Timestamp date;

  Comment({
    required this.idContent,
    required this.profile,
    required this.email,
    required this.text,
    required this.date,
  });

  factory Comment.formJson(Map<String, dynamic> map) {
    return Comment(
      idContent: map['idContent'],
      profile: map['profile'],
      email: map['email'],
      text: map['text'],
      date: map['date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idContent': idContent,
      'profile': profile,
      'email': email,
      'text': text,
      'date': date,
    };
  }
}
