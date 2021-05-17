import 'package:flutter/material.dart';

class ListingImagePlaceholder extends StatelessWidget {
  final double height;
  final double width;
  final String failureText;

  const ListingImagePlaceholder(
      {required this.height, required this.width, required this.failureText});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: Container(alignment: Alignment.center, child: Text(failureText)),
    );
  }
}
