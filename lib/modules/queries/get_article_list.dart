import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:news_reader/models/article_screen_args.dart';
import 'package:news_reader/modules/screens/article_screen.dart';
// https://ferrygraphql.com/


class ArticleList extends StatelessWidget {

  static String readRepositories = """
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
        document: gql(readRepositories),
        variables: {
          'skip': 0,
          'limit': 9999
        },
      ),
       builder: (QueryResult result, { VoidCallback refetch, FetchMore fetchMore }) {
         List res = result.data['newsList']['rows'];

         if (result.hasException) {
          return Text(result.exception.toString());
        }

        if (result.isLoading || res.isEmpty) {
          return Text('Loading');
        }

        return ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: res.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                this._article(res[index]['id'], res[index]['title'], res[index]['img'], context),
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
          arguments: ArticleScreenArgs(
            id,
          ),
        );
      },
      child: Row(
      children: [
        Image.network('$img', fit: BoxFit.cover, alignment: Alignment.center, height: 100, width: 100),
        SizedBox(width: 10),
        Expanded(child: Text(title)),
      ],
    ));

  }

}
