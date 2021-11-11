import 'package:pluriza/data/repositories/json_placeholder.dart';
import 'package:pluriza/domain/models/comment.dart';
import 'package:pluriza/domain/use_cases/controllers/comments.dart';

class CommentsManager {
  Future<List<PostComment>> commentsById(
      CommentController controller, int postId) async {
    if (controller.comments.isEmpty ||
        controller.getCommentsById(postId).isEmpty) {
      controller.newComments = await JsonPlaceholder().fetchComments(postId);
    }
    return controller.getCommentsById(postId);
  }

  void deleteAll(CommentController controller) => controller.deleteAll();
}
