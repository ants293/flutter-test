import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:news_reader/models/article.dart';
import 'package:news_reader/models/article_screen_args.dart';
import 'package:news_reader/screens/article_screen.dart';

class ArticleList extends StatelessWidget {
  static String readArticles = """
    query getArticlesList(\$skip: Int!, \$limit: Int!) {
      newsList(skip: \$skip, limit: \$limit) {
        totalRows
        rows {
          id
          title
          img
        }
      }
    }
  """;

  @override
  Widget build(BuildContext context) {
    return Query(
      options: QueryOptions(
        document: gql(readArticles),
        variables: {'skip': 0, 'limit': 9999},
      ),
      builder: (QueryResult result, {refetch, fetchMore}) {
        final articles = (result.data!['newsList']['rows'] as List)
            .map((data) => Article.fromJson(data))
            .toList();

        if (result.hasException) {
          return Text(result.exception.toString());
        }

        if (result.isLoading || articles.isEmpty) {
          return Text('Loading');
        }

        return ListView.builder(
            padding: EdgeInsets.all(8),
            itemCount: articles.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  _article(articles[index].id, articles[index].title,
                      articles[index].img, context),
                  SizedBox(height: 15),
                ],
              );
            });
      },
    );
  }

  Widget _article(String id, String title, String img, BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            ArticleScreen.routeName,
            arguments: ArticleScreenArgs(id),
          );
        },
        child: Row(
          children: [
            Image.network(img,
                fit: BoxFit.cover,
                alignment: Alignment.center,
                height: 100,
                width: 100),
            SizedBox(width: 10),
            Expanded(child: Text(title)),
          ],
        ));
  }
}
