import 'package:flutter/material.dart';

// Create a Form widget.
class CommentForm extends StatefulWidget {
  static String createComment = """
    createComment(input: {
      newsId: \$id: ID!, email: \$email, content: \$content
      }){
        id
        email
        createdDate
        content
      }
  """;

  @override
  CommentFormState createState() {
    return CommentFormState();
  }
}

class CommentFormState extends State<CommentForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                }
              },
              child: Text('Add comment!'),
            ),
          ),
        ],
      ),
    );
  }
}
