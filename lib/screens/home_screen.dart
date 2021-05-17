import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../widgets/article_list.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = 'home';

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('News Reader')),
        body: const ArticleList(),
      );
}
