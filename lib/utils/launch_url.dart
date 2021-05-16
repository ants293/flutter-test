import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

void launchUrl(String url) async {
  await canLaunch(url)
      ? await launch(url)
      : debugPrint('Cannot launch this link ${url}');
}
