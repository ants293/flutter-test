import 'package:flutter/widgets.dart';
import 'package:news_reader/screens/article_screen.dart';
import 'package:news_reader/screens/home_screen.dart';

class Routes {
  static final routes = <String, WidgetBuilder>{
    '/': (context) => HomeScreen(),
    ArticleScreen.routeName: (context) => ArticleScreen(),
  };

  static getRoutes() {
    return Routes.routes;
  }
}
