import 'package:pluriza/domain/models/post.dart';
import 'package:sqflite/sqflite.dart';

abstract class SqfliteInterface {
  Future<Database> connectDatabase();

  Future<void> updatePost(Database database, Post post);

  Future<void> insertPosts(Database database, List<Post> posts);

  Future<List<Post>> retrievePosts(Database database);

  Future<void> deletePost(Database database, int id);

  Future<void> deleteAll(Database database);
}
