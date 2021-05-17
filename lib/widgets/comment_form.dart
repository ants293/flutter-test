import 'package:flutter/material.dart';

// Create a Form widget.
class CommentForm extends StatefulWidget {
  @override
  CommentFormState createState() {
    return CommentFormState();
  }
}

class CommentFormState extends State<CommentForm> {
  static String createComment = """
    createComment(input: {
      newsId: \$newsId: ID!, email: \$email, content: \$content
      }){
        id
        email
        createdDate
        content
      }
  """;

  final _formKey = GlobalKey<FormState>();

  String content = '';
  String email = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildInput((String val) => content = val, 'content'),
          _buildInput((String val) => email = val, 'email'),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Processing Data')));
                }

                _formKey.currentState!.save();
              },
              child: Text('Add comment'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInput(Function valSet, String inputLabel) {
    return TextFormField(
      decoration: InputDecoration(labelText: inputLabel),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Fill field please';
        }
        return null;
      },
      onSaved: (value) {
        if (value != null) {
          valSet(value);
        }
      },
    );
  }
}
