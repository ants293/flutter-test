import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../models/article_screen_args.dart';
import '../utils/launch_url.dart';
import '../widgets/article_single.dart';

class ArticleScreen extends HookWidget {
  static const routeName = 'article';

  // String _url = '';

  @override
  Widget build(BuildContext context) {
    final articleUrl = useState<String?>(null);

    final args =
        ModalRoute.of(context)?.settings.arguments as ArticleScreenArgs?;

    if (args == null) {
      throw Exception('ArticleScreen expects arguments');
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text(
              'Reader',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                if (articleUrl.value == null) {
                  return;
                }

                launchUrl(articleUrl.value!);
              },
              child: const Text(
                'Link to article',
                style: TextStyle(fontSize: 10, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      body: ArticleSingle(
        id: args.id,
        setUrl: (newUrl) => articleUrl.value = newUrl,
      ),
    );
  }
}
