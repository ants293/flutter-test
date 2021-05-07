import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'models/location.dart';

class LocList extends StatelessWidget {
  final List<Location> locations;

  LocList(this.locations);

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Some loc"))
      );
  }
}