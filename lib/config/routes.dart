import 'package:flutter/widgets.dart';
import 'package:news_reader/modules/screens/home_screen.dart';

class Routes {
  static final routes = <String, WidgetBuilder> {
    '/': (context) => HomeScreen(),
  };

  static getRoutes() {
    return Routes.routes;
  }
}