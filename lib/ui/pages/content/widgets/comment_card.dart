import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pluriza/domain/models/comment.dart';

class CommentCard extends StatelessWidget {
  final PostComment comment;

  const CommentCard({
    Key? key,
    required this.comment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      subtitle: Text(
        comment.body,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
