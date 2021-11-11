import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:pluriza/data/repositories/json_placeholder.dart';
import 'package:pluriza/domain/models/post.dart';
import 'package:pluriza/domain/use_cases/controllers/posts.dart';
import 'package:pluriza/domain/use_cases/post_management.dart';

class MockJson extends Mock implements JsonPlaceholder {
  @override
  Future<List<Post>> fetchPost() async {
    return List<Post>.generate(
        20, (i) => Post(id: i, userId: i, title: "Mock$i", body: "body"));
  }
}

class MockManager extends Mock implements PostsManager {
  @override
  Future<List<Post>> fetch(PostController controller) async {
    if (controller.posts.isEmpty) {
      controller.newPosts = await MockJson().fetchPost();
    }
    return controller.posts;
  }

  @override
  Future<List<Post>> reload(PostController controller) async {
    controller.newPosts = await MockJson().fetchPost();
    return controller.posts;
  }

  @override
  Future<void> deleteAll(PostController controller) async {
    controller.deleteAll();
  }

  @override
  Future<void> delete(PostController controller, int postId) async {
    controller.delete(postId);
  }

  @override
  void viewComment(PostController controller, int postId) {
    controller.selected = postId;
  }

  @override
  Post selected(PostController controller) {
    return controller.selectedPost;
  }

  @override
  void markAsRead(PostController controller) {
    controller.markAsRead();
  }

  @override
  Future<void> toggleFav(PostController controller) async {
    controller.toggleFavorite();
  }
}

void main() {
  Get.put(PostController());
  late PostController controller;
  late MockManager manager;

  setUp(() {
    controller = Get.find();
    manager = MockManager();
  });

  test('fetch-post', () async {
    await manager.fetch(controller);
    expect(controller.posts.length, 20);
  });

  test('mark-as-read', () async {
    controller.selected = 1;
    manager.markAsRead(controller);
    expect(controller.selectedPost.read, true);
  });

  test('toggle-fav', () async {
    controller.selected = 1;
    expect(controller.selectedPost.favorite, false);
    await manager.toggleFav(controller);
    expect(controller.selectedPost.favorite, true);
    await manager.toggleFav(controller);
    expect(controller.selectedPost.favorite, false);
  });

  test('delete-post', () async {
    await manager.delete(controller, 1);
    expect(controller.posts.length, 19);
  });

  test('reload-post', () async {
    expect(controller.posts.length, 19);
    await manager.reload(controller);
    expect(controller.posts.length, 20);
  });

  test('delete-all-post', () async {
    expect(controller.posts.length, 20);
    await manager.deleteAll(controller);
    expect(controller.posts.length, 0);
  });
}
