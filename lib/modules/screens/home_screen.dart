import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:news_reader/modules/queries/get_article_list.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("home")),
      body: Container(
          child: ArticleList()
      ),
    );
  }
}