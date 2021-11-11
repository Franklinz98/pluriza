import 'package:get/get.dart';
import 'package:pluriza/domain/models/comment.dart';

class CommentController extends GetxController {
  final _comments = Rx<List<PostComment>>([]);

  set newComments(List<PostComment> newComments) {
    if (comments
        .where((comment) => comment.postId == newComments[0].postId)
        .isEmpty) {
      _comments.value.addAll(newComments);
    }
  }

  void deleteAll() {
    _comments.value = [];
  }

  List<PostComment> get comments => _comments.value;

  List<PostComment> getCommentsById(int postId) {
    return comments.where((comment) => comment.postId == postId).toList();
  }
}
