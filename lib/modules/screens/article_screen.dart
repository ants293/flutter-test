import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_reader/models/article_screen_args.dart';
import 'package:news_reader/modules/queries/get_single_article.dart';

class ArticleScreen extends StatelessWidget {
  static const routeName = '/extractArguments';

  @override
  Widget build(BuildContext context) {
    final ArticleScreenArgs args = ModalRoute.of(context)!.settings.arguments as ArticleScreenArgs;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.id),
      ),
      body: ArticleSingle(args.id),
    );
  }
}