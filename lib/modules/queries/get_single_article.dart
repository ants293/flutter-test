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

        var article = result.data['newsItem'];
        if (result.isLoading || article == null) {
          return Text('Loading');
        }


        return Container(
          child: Column(
            children: [
              Text(article['title']),
              Image.network('${article['img']}', fit: BoxFit.cover, alignment: Alignment.center, height: 100, width: 100),
              Text(article['content'])
            ],
          ),
        );
      },
    );
  }

}