import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_reader/models/article_screen_args.dart';
import 'package:news_reader/widgets/article_single.dart';

class ArticleScreen extends StatelessWidget {
  static const routeName = '/extractArguments';

  @override
  Widget build(BuildContext context) {
    final ArticleScreenArgs args =
        ModalRoute.of(context)!.settings.arguments as ArticleScreenArgs;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My app'),
      ),
      body: ArticleSingle(args.id),
    );
  }
}
