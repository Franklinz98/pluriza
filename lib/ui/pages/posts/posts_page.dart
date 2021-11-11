import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pluriza/domain/models/post.dart';
import 'package:pluriza/domain/use_cases/comment_management.dart';
import 'package:pluriza/domain/use_cases/controllers/comments.dart';
import 'package:pluriza/domain/use_cases/controllers/posts.dart';
import 'package:pluriza/domain/use_cases/controllers/users.dart';
import 'package:pluriza/domain/use_cases/post_management.dart';
import 'package:pluriza/domain/use_cases/user_management.dart';
import 'package:pluriza/ui/pages/posts/widgets/post_card.dart';
import 'package:pluriza/ui/pages/posts/widgets/scaffold.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  late PostController _controller;
  late UserController _usersController;
  late CommentController _commentController;
  late Future<List<Post>> _postsFuture;
  late PostsManager _manager;
  late CommentsManager _commentsManager;
  late UsersManager _usersManager;
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _controller = Get.find();
    _usersController = Get.find();
    _commentController = Get.find();
    _manager = PostsManager();
    _commentsManager = CommentsManager();
    _usersManager = UsersManager();
    _postsFuture = _manager.fetch(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return PostsScaffold(
      onRefresh: () => setState(
        () {
          _postsFuture = _manager.reload(_controller);
        },
      ),
      onFilter: (int index) {
        _controller.filter = index == 1;
        setState(() {
          _selectedTab = index;
        });
      },
      onDeleteAll: () {
        _manager.deleteAll(_controller);
        _usersManager.deleteAll(_usersController);
        _commentsManager.deleteAll(_commentController);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Visibility(
            visible: GetPlatform.isIOS,
            child: Material(
              child: CupertinoSegmentedControl<int>(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
                children: const {
                  0: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('All'),
                  ),
                  1: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Favorite'),
                  )
                },
                groupValue: _selectedTab,
                onValueChanged: (int index) {
                  _controller.filter = index == 1;
                  setState(() {
                    _selectedTab = index;
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Post>>(
              future: _postsFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Obx(() => Material(
                        child: ListView.separated(
                          itemCount: _controller.posts.length,
                          itemBuilder: (context, index) {
                            Post post = _controller.posts[index];
                            return Dismissible(
                              key: ValueKey('Post${post.id}'),
                              child: PostCard(
                                post: post,
                                onTap: () =>
                                    _manager.viewComment(_controller, post.id),
                              ),
                              background: Container(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                              onDismissed: (direction) =>
                                  _manager.delete(_controller, post.id),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Divider();
                          },
                        ),
                      ));
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                // By default, show a loading spinner.
                return Center(child: GetPlatform.isIOS?const CupertinoActivityIndicator(): const CircularProgressIndicator());
              },
            ),
          ),
          Visibility(
            visible: GetPlatform.isIOS,
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: CupertinoButton(
                borderRadius: const BorderRadius.all(Radius.zero),
                color: Theme.of(context).colorScheme.secondary,
                child: const Text(
                  'Delete All',
                ),
                onPressed: () {
                  PostsManager().deleteAll(_controller);
                  UsersManager().deleteAll(_usersController);
                  CommentsManager().deleteAll(_commentController);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
