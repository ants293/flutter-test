import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_reader/models/article_screen_args.dart';
import 'package:news_reader/widgets/article_single.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:news_reader/utils/launch_url.dart';

class ArticleScreen extends StatelessWidget {
  static const routeName = '/extractArguments';
  String url = '';

  @override
  Widget build(BuildContext context) {
    final ArticleScreenArgs args =
        ModalRoute.of(context)!.settings.arguments as ArticleScreenArgs;

    return Scaffold(
        appBar: AppBar(
            title: Container(
          child: Row(
            children: [
              Text(
                'Reader',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              Spacer(),
              TextButton(
                child: Text(
                  "Link to article",
                  style: TextStyle(fontSize: 10, color: Colors.white),
                ),
                onPressed: () {
                  launchUrl(url);
                },
              ),
            ],
          ),
        )),
        body: ArticleSingle(args.id, setUrl));
  }

  setUrl(String articleUrl) {
    url = articleUrl;
  }
}
