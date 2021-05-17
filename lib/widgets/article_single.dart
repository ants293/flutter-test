import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../models/article.dart';
import '../models/comment.dart';
import 'comment_form.dart';

typedef SetArticleUrlCallback = void Function(String url);

class ArticleSingle extends StatelessWidget {
  final String id;
  final SetArticleUrlCallback setUrl;

  const ArticleSingle({required this.id, required this.setUrl});

  static String readSingleArticle = '''
    query getArticlesList(\$id: ID!) {
      newsItem(id: \$id) {
        id
        title
        content
        url
        img
        comments {
          id
          email
          createdDate
          content
        }
      }
    }''';

  @override
  Widget build(BuildContext context) => Query(
        options: QueryOptions(
          document: gql(readSingleArticle),
          variables: {
            'id': id,
          },
        ),
        builder: (QueryResult result, {refetch, fetchMore}) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }

          if (result.isLoading || result.data == null) {
            return const Text('Loading');
          }

          final article = Article.fromJson(result.data!['newsItem']);

          WidgetsBinding.instance!.addPostFrameCallback(
            (_) => setUrl(article.url),
          );

          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                      child: Text(article.title),
                    ),
                  ),
                  Image.network(article.img,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                      height: 200),
                  Container(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Text(article.content),
                  ),
                  ..._buildCommentArea(article.comments)
                ],
              ),
            ),
          );
        },
      );

  List<Widget> _buildCommentArea(List<Comment> comments) {
    return [
      CommentForm(),
      ...comments.map(
        (comment) => Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 0.8, color: Colors.blue),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _buildComment(comment),
          ),
        ),
      ),
    ];
  }

  static List<Widget> _buildComment(Comment comment) {
    return [
      SizedBox(height: 12),
      Text(
        comment.email,
        style: TextStyle(fontSize: 10, color: Colors.lightBlue),
      ),
      Text(comment.content),
      SizedBox(height: 5),
    ];
  }
}
