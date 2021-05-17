import 'package:flutter/widgets.dart';

import '../screens/article_screen.dart';
import '../screens/home_screen.dart';

final routes = <String, WidgetBuilder>{
  HomeScreen.routeName: (context) => HomeScreen(),
  ArticleScreen.routeName: (context) => ArticleScreen(),
};
