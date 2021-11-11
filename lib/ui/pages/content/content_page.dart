import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pluriza/domain/models/comment.dart';
import 'package:pluriza/domain/models/post.dart';
import 'package:pluriza/domain/models/user.dart';
import 'package:pluriza/domain/use_cases/comment_management.dart';
import 'package:pluriza/domain/use_cases/controllers/comments.dart';
import 'package:pluriza/domain/use_cases/controllers/posts.dart';
import 'package:pluriza/domain/use_cases/controllers/users.dart';
import 'package:pluriza/domain/use_cases/post_management.dart';
import 'package:pluriza/domain/use_cases/user_management.dart';
import 'package:pluriza/ui/pages/content/widgets/comment_card.dart';
import 'package:pluriza/ui/pages/content/widgets/scaffold.dart';

class ContentPage extends StatelessWidget {
  const ContentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final PostController _controller = Get.find();
    final UserController _usersController = Get.find();
    final CommentController _commentController = Get.find();
    final PostsManager manager = PostsManager();
    manager.markAsRead(_controller);
    final Post post = manager.selected(_controller);
    return ContentScaffold(
      trailingIcon: _responsiveIcon(_controller),
      onFavorite: () => manager.toggleFav(_controller),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Description',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                post.body,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'User',
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Expanded(
              flex: 1,
              child: FutureBuilder<User>(
                future: UsersManager().userById(_usersController, post.userId),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    User user = snapshot.data!;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name',
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              Text(
                                'Email',
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              Text(
                                'Phone',
                                style: Theme.of(context).textTheme.headline2,
                              ),
                              Text(
                                'Website',
                                style: Theme.of(context).textTheme.headline2,
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 12.0,
                          ),
                          Expanded(
                            flex: 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  user.name,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                Text(
                                  user.email,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                Text(
                                  user.phone,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                Text(
                                  user.website,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  // By default, show a loading spinner.
                  return Center(child: GetPlatform.isIOS?const CupertinoActivityIndicator(): const CircularProgressIndicator());
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'COMMENTS',
                style: Theme.of(context).textTheme.headline1,
              ),
              color: Colors.grey[350],
            ),
            Expanded(
              flex: 4,
              child: FutureBuilder<List<PostComment>>(
                future:
                    CommentsManager().commentsById(_commentController, post.id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Material(
                      child: ListView.separated(
                        itemCount: _commentController.comments.length,
                        itemBuilder: (context, index) {
                          PostComment comment =
                              _commentController.comments[index];
                          return CommentCard(
                            comment: comment,
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  }

                  // By default, show a loading spinner.
                  return Center(child: GetPlatform.isIOS?const CupertinoActivityIndicator(): const CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _responsiveIcon(PostController controller) {
    if (GetPlatform.isIOS) {
      return Obx(
        () => Icon(
          controller.selectedPost.favorite
              ? CupertinoIcons.star_fill
              : CupertinoIcons.star,
          color: Colors.white,
          size: 20.0,
        ),
      );
    } else {
      return Obx(
        () => Icon(
          controller.selectedPost.favorite
              ? Icons.star_rounded
              : Icons.star_outline_rounded,
        ),
      );
    }
  }
}
