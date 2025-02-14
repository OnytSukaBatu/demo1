class Comment {
  final String email;
  final String text;

  Comment({
    required this.email,
    required this.text,
  });

  factory Comment.formJson(Map<String, dynamic> map) {
    return Comment(
      email: map['email'],
      text: map['text'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'text': text,
    };
  }
}
