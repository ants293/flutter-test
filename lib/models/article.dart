import 'comment.dart';

class Article {
  final String id;
  final String img;
  final String title;
  final String url;
  String content;
  List<Comment> comments;
  static const ok = <Comment>[];

  Article(
      {required this.id,
      required this.img,
      required this.title,
      this.content = '',
      this.comments = ok,
      this.url = ''});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] as String,
      img: json['img'] as String,
      title: json['title'] as String,
      url: json['url'] != null ? json['url'] as String : '',
      content: json['content'] != null ? json['content'] as String : '',
      comments: json['comments'] != null
          ? Article._parseComments(json['comments'])
          : <Comment>[],
    );
  }

  static List<Comment> _parseComments(jsonComments) {
    return (jsonComments as List)
        .map((data) => Comment.fromJson(data))
        .toList();
  }
}
