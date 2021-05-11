import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ArticleSingle extends StatelessWidget {
  final String id;

  ArticleSingle(this.id);

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
          'id': this.id,
        },
      ),
      builder: (QueryResult result, { VoidCallback refetch, FetchMore fetchMore }) {

        if (result.hasException) {
          return Text(result.exception.toString());
        }

        if (result.isLoading || result.data['newsItem'] == null) {
          return Text('Loading');
        }

        var article = result.data['newsItem'];

        return Container(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Text(article['title']),
                ),
              ),
              Image.network('${article['img']}', fit: BoxFit.cover, alignment: Alignment.center, height: 200),
              Container(
                child: Text(article['content']),
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              ),
            ],
          ),
        );
      },
    );
  }

}