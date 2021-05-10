import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

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

        if (result.isLoading) {
          return Text('Loading');
        }

        return GridView.builder(
          itemCount:res.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).orientation == Orientation.landscape ? 3: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: (2 / 1),
          ),
          itemBuilder: (context,index,) {
            return Container(
                child: Column(
                  mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                  children: [
                    this._article(res[index]['title'], res[index]['img'])
                  ],
                ),
              );
          },
        );

      },
    );
  }

  Widget _article(String title, String img) {
    return Expanded(
      child: Column(
        children: [
          Text(title),
          Container(
              child: Expanded(child: Image.network('$img', fit: BoxFit.cover, alignment: Alignment.center, height: double.infinity, width: double.infinity))
          ),
        ],
      ),
    );


  }
}
