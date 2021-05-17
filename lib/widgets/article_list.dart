import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../models/article.dart';
import '../models/article_screen_args.dart';
import '../screens/article_screen.dart';
import 'listing_image_placeholder.dart';

class ArticleList extends StatelessWidget {
  const ArticleList({Key? key}) : super(key: key);

  static String getArticleListQuery = '''
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
  ''';

  @override
  Widget build(BuildContext context) => Query(
        options: QueryOptions(
          document: gql(getArticleListQuery),
          variables: {
            'skip': 0,
            'limit': 9999,
          },
        ),
        builder: (result, {refetch, fetchMore}) {
          if (result.hasException) {
            return Text(result.exception.toString());
          }

          if (result.isLoading || result.data == null) {
            return const Text('Loading');
          }

          final articles = (result.data!['newsList']['rows'] as List)
              .map((data) => Article.fromJson(data))
              .toList();

          return ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: articles.length,
            itemBuilder: (context, index) => _buildArticle(
              articles[index].id,
              articles[index].title,
              articles[index].img,
              context,
            ),
            separatorBuilder: (context, index) => const SizedBox(height: 15),
          );
        },
      );

  Widget _buildArticle(
    String id,
    String title,
    String img,
    BuildContext context,
  ) =>
      InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            ArticleScreen.routeName,
            arguments: ArticleScreenArgs(id),
          );
        },
        child: Row(
          children: [
            _buildImage(img, context),
            const SizedBox(width: 10),
            Expanded(
              child: Text(title),
            ),
          ],
        ),
      );

  Widget _buildImage(String imgUrl, BuildContext context) {
    return Image.network(
      imgUrl,
      fit: BoxFit.cover,
      alignment: Alignment.center,
      errorBuilder: (context, url, error) => const ListingImagePlaceholder(
        width: 100,
        height: 100,
        failureText: 'Not found!',
      ),
      height: 100,
      width: 100,
    );
  }
}
