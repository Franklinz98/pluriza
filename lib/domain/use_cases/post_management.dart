import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pluriza/data/repositories/json_placeholder.dart';
import 'package:pluriza/data/services/sqflite_database.dart';
import 'package:pluriza/domain/models/post.dart';
import 'package:pluriza/domain/use_cases/controllers/common.dart';
import 'package:pluriza/domain/use_cases/controllers/posts.dart';
import 'package:sqflite/sqflite.dart';

class PostsManager {
  final Database _database = Get.find<CommonController>().database;
  final SqfliteService _service = SqfliteService();

  Future<List<Post>> fetch(PostController controller) async {
    if (controller.posts.isEmpty) {
      List<Post> cached = await _service.retrievePosts(_database);
      if (cached.isEmpty) {
        controller.newPosts = await JsonPlaceholder().fetchPost();
        await _service.insertPosts(_database, controller.posts);
      } else {
        controller.newPosts = cached;
      }
    }
    return controller.posts;
  }

  Future<List<Post>> reload(PostController controller) async {
    controller.newPosts = await JsonPlaceholder().fetchPost();
    await _service.insertPosts(_database, controller.posts);
    return controller.posts;
  }

  Future<void> deleteAll(PostController controller) async {
    await _service.deleteAll(_database);
    controller.deleteAll();
  }

  Future<void> delete(PostController controller, int postId) async {
    await _service.deletePost(_database, postId);
    controller.delete(postId);
  }

  void viewComment(PostController controller, int postId) {
    controller.selected = postId;
    Get.toNamed('/content');
  }

  Post selected(PostController controller) {
    return controller.selectedPost;
  }

  void markAsRead(PostController controller) {
    if (controller.selectecId == -1) {
      Get.back();
    } else {
      // We refresh the state controller after layout changes are done.
      WidgetsBinding.instance!.addPostFrameCallback((_) async {
        controller.markAsRead();
        await _service.updatePost(_database, controller.selectedPost);
      });
    }
  }

  Future<void> toggleFav(PostController controller) async {
    controller.toggleFavorite();
    await _service.updatePost(_database, controller.selectedPost);
  }
}
