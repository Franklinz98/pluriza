import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:mockito/mockito.dart';
import 'package:pluriza/data/repositories/json_placeholder.dart';
import 'package:pluriza/domain/models/comment.dart';
import 'package:pluriza/domain/use_cases/comment_management.dart';
import 'package:pluriza/domain/use_cases/controllers/comments.dart';

class MockJson extends Mock implements JsonPlaceholder {
  @override
  Future<List<PostComment>> fetchComments(int postId) async {
    return List<PostComment>.generate(
      12,
      (i) => PostComment(
          id: i,
          postId: postId,
          name: "Mock$i",
          body: "body",
          email: "mock$i@pluriza.test.com"),
    );
  }
}

class MockManager extends Mock implements CommentsManager {
  @override
  Future<List<PostComment>> commentsById(
      CommentController controller, int postId) async {
    if (controller.comments.isEmpty ||
        controller.getCommentsById(postId).isEmpty) {
      controller.newComments = await MockJson().fetchComments(postId);
    }
    return controller.getCommentsById(postId);
  }

  @override
  void deleteAll(CommentController controller) => controller.deleteAll();
}

void main() {
  Get.put(CommentController());
  late CommentController controller;
  late MockManager manager;

  setUp(() {
    controller = Get.find();
    manager = MockManager();
  });

  test('comment-by-id', () async {
    await manager.commentsById(controller, 2);
    expect(controller.comments.length, 12);
    await manager.commentsById(controller, 4);
    expect(controller.comments.length, 24);
  });

  test('delete-all-comments', () async {
    expect(controller.comments.length, 24);
    manager.deleteAll(controller);
    expect(controller.comments.length, 0);
  });
}
