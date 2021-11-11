import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pluriza/domain/models/user.dart';
import 'package:pluriza/domain/models/post.dart';
import 'package:pluriza/domain/models/comment.dart';
import 'package:pluriza/domain/repositories/placeholder_interface.dart';

class JsonPlaceholder implements JsonPlaceholderInterface {
  @override
  String get baseUrl => 'jsonplaceholder.typicode.com';

  @override
  Future<List<Post>> fetchPost() async {
    var uri = Uri.https(baseUrl, '/posts');
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      final List<Post> posts = [];
      for (var post in res) {
        posts.add(Post.fromJson(post));
      }
      for (var i = 0; i < 20; i++) {
        posts[i].read = false;
      }
      return posts;
    } else {
      throw Exception('Error on request');
    }
  }

  @override
  Future<User> fetchUser(int userId) async {
    var uri = Uri.https(baseUrl, '/users/$userId');
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      final User user = User.fromJson(res);
      return user;
    } else {
      throw Exception('Error on request');
    }
  }

  @override
  Future<List<PostComment>> fetchComments(int postId) async {
    var uri = Uri.https(baseUrl, '/posts/$postId/comments');
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      final List<PostComment> comments = [];
      for (var comment in res) {
        comments.add(PostComment.fromJson(comment));
      }
      return comments;
    } else {
      throw Exception('Error on request');
    }
  }
}
