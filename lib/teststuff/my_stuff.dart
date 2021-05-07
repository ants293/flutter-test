import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../teststuff/models/location.dart';

class MyStuff extends StatelessWidget {
  final Location location;
  MyStuff(this.location);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(location.name)),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _someImage(location.url),
              Text(location.name),
              ..._renderFacts(location),
            ]
        ),
    );
  }

  List<Widget> _renderFacts(Location location) {
    var result = <Widget>[];

    for (var fact in location.facts) {
      result.add(Container(
        child: Column(
          children: [
            Text(fact.title),
            Text(fact.text),
          ],
        ),
      ));
    }

    return result;
  }

  Widget _someImage(String url) {
    return Container(
      constraints: BoxConstraints.tightFor(height: 300),
      child: Image.network(url, fit: BoxFit.fitWidth, alignment: Alignment.center)
    );
  }

  Widget _tester(String title, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
      ),
      child: Text(title),
    );
  }
}