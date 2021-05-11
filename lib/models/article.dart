class Article {
  final String id;
  final String img;
  final String title;
  final String content;

  Article({this.id, this.img, this.title, this.content});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
        id: json['id'] as String,
        img: json['img'] as String,
        title: json['title'] as String,
        content: json['content'] as String
    );
  }

}
