import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'config/routes.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  await initHiveForFlutter();

  final HttpLink httpLink = HttpLink(
    'https://news-reader.stagnationlab.dev/graphql',
  );

  final ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: HiveStore()),
    ),
  );

  runApp(
    GraphQLProvider(
      client: client,
      child: MaterialApp(
        initialRoute: HomeScreen.routeName,
        routes: routes,
      ),
    ),
  );
}
