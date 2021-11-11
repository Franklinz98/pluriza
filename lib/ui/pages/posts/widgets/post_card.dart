import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:pluriza/domain/models/post.dart';

class PostCard extends StatelessWidget {
  final Post post;
  final VoidCallback onTap;

  const PostCard({
    Key? key,
    required this.post,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      minLeadingWidth: 0,
      subtitle: Text(
        post.body,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      leading: _leadingIcon,
      trailing: _trailingIcon,
      onTap: onTap,
    );
  }

  Widget? get _leadingIcon {
    if (GetPlatform.isIOS) {
      return SizedBox(
        height: 24.0,
        width: 24.0,
        child: Center(
            child: !post.read
                ? Icon(
                    Icons.brightness_1,
                    size: 12.0,
                    color: Colors.blue[400],
                  )
                : Icon(
                    post.favorite
                        ? CupertinoIcons.star_fill
                        : CupertinoIcons.star,
                    size: 20.0,
                    color: Colors.yellow[600],
                  )),
      );
    } else if (!post.read) {
      return SizedBox(
        height: 24.0,
        width: 24.0,
        child: Center(
          child: Icon(
            Icons.brightness_1,
            size: 12.0,
            color: Colors.blue[400],
          ),
        ),
      );
    }
  }

  Icon get _trailingIcon {
    if (GetPlatform.isIOS) {
      return Icon(
        CupertinoIcons.chevron_forward,
        color: Colors.grey[400],
      );
    } else {
      return Icon(
        post.favorite ? Icons.star_rounded : Icons.star_outline_rounded,
        color: Colors.yellow[600],
      );
    }
  }
}
