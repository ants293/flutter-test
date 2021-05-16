import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:news_reader/models/article.dart';
import 'package:news_reader/models/comment.dart';
import 'package:news_reader/widgets/comment_form.dart';

class ArticleSingle extends StatelessWidget {
  final String id;
  final setUrl;

  ArticleSingle(this.id, this.setUrl);

  static String readSingleArticle = """
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
    }""";

  @override
  Widget build(BuildContext context) {
    return Query(
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
        this.setUrl(article.url);

        return SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Text(article.title),
                  ),
                ),
                Image.network('${article.img}',
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    height: 200),
                Container(
                  child: Text(article.content),
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                ),
                ...article.comments.map(
                  (comment) => Container(
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(width: 0.8, color: Colors.blue),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _getComment(comment),
                      )),
                ),
                CommentForm()
              ],
            ),
          ),
        );
      },
    );
  }

  static List<Widget> _getComment(Comment comment) {
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
