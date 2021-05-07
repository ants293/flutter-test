
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:news_reader/models/article.dart';

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
        if (result.hasException) {
          return Text(result.exception.toString());
        }

        if (result.isLoading) {
          return Text('Loading');
        }

        List res = result.data['newsList']['rows'];

        return ListView.builder(
            itemCount: res.length,
            itemBuilder: (context, index) {
              var rep = res[index];

              return Column(
                children: [
                  Text(rep['id']),
                  Text(rep['title']),
                  Container(
                    constraints: BoxConstraints.tightFor(height: 300),
                    child: Image.network('https://cors-anywhere.herokuapp.com/${rep['img']}', fit: BoxFit.fitWidth, alignment: Alignment.center)
                  ),
                ],
              );
            });
      },
    );
  }
}