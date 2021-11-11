import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:get/route_manager.dart';

class ContentScaffold extends StatelessWidget {
  final Widget trailingIcon;
  final VoidCallback onFavorite;
  final Widget child;

  const ContentScaffold(
      {Key? key,
      required this.trailingIcon,
      required this.onFavorite,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (GetPlatform.isIOS) {
      return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            leading: CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Icon(
                CupertinoIcons.left_chevron,
                color: Colors.white,
                size: 20.0,
              ),
              onPressed: () => Get.back(),
            ),
            middle: const Text(
              "Post",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              child: trailingIcon,
              onPressed: onFavorite,
            ),
          ),
          child: child);
    } else {
      return Scaffold(
          appBar: AppBar(
            title: const Text('Post'),
            actions: [
              IconButton(
                icon: trailingIcon,
                onPressed: onFavorite,
              )
            ],
          ),
          body: child);
    }
  }
}
