class Comment {
  final String id;
  final String email;
  final int createdDate;
  final String content;

  Comment({required this.id, required this.email, required this.createdDate, required this.content});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] as String,
      email: json['email'] as String,
      createdDate: json['createdDate'] as int,
      content: json['content'] as String,
    );
  }
}
