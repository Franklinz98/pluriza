import 'package:pluriza/domain/models/comment.dart';
import 'package:pluriza/domain/models/post.dart';
import 'package:pluriza/domain/models/user.dart';

abstract class JsonPlaceholderInterface {
  String get baseUrl;

  // Fetch all post
  Future<List<Post>> fetchPost();

  // Fetch user by id
  Future<User> fetchUser(int userId);

  // Fetch comments by post id
  Future<List<PostComment>> fetchComments(int postId);
}
