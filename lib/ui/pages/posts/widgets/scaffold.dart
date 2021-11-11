import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/platform/platform.dart';

class PostsScaffold extends StatelessWidget {
  final VoidCallback onRefresh, onDeleteAll;
  final ValueChanged<int> onFilter;
  final Widget child;

  const PostsScaffold(
      {Key? key,
      required this.onRefresh,
      required this.onFilter,
      required this.onDeleteAll,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (GetPlatform.isIOS) {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          middle: const Text(
            "Posts",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            child: const Icon(
              CupertinoIcons.refresh_bold,
              color: Colors.white,
              size: 20.0,
            ),
            onPressed: onRefresh,
          ),
        ),
        child: child,
      );
    } else {
      return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Posts"),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.refresh_rounded,
                ),
                onPressed: onRefresh,
              ),
            ],
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: const <Widget>[Tab(text: 'ALL'), Tab(text: 'FAVORITES')],
              onTap: onFilter,
            ),
          ),
          body: child,
          floatingActionButton: FloatingActionButton(
            child: const Icon(
              Icons.delete_rounded,
              color: Colors.white,
            ),
            onPressed: onDeleteAll,
          ),
        ),
      );
    }
  }
}
