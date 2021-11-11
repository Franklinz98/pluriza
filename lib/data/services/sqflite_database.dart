import 'package:pluriza/domain/models/post.dart';
import 'package:pluriza/domain/services/sqflite_interface.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqfliteService extends SqfliteInterface {
  @override
  Future<Database> connectDatabase() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'posts_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE IF NOT EXISTS posts(id INTEGER PRIMARY KEY,userId INTEGER, title TEXT, body TEXT, read INTEGER, favorite INTEGER)',
        );
      },
      version: 1,
    );
    return await database;
  }

  @override
  Future<void> deletePost(Database database, int id) async {
    await database.delete(
      'posts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> insertPosts(Database database, List<Post> posts) async {
    for (var post in posts) {
      await database.insert(
        'posts',
        post.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  @override
  Future<List<Post>> retrievePosts(Database database) async {
    final List<Map<String, dynamic>> maps = await database.query('posts');
    return List.generate(maps.length, (i) {
      return Post(
        id: maps[i]['id'],
        userId: maps[i]['userId'],
        title: maps[i]['title'],
        body: maps[i]['body'],
        read: maps[i]['read'] == 0 ? false : true,
        favorite: maps[i]['favorite'] == 0 ? false : true,
      );
    });
  }

  @override
  Future<void> deleteAll(Database database) async {
    await database.delete(
      'posts',
    );
  }

  @override
  Future<void> updatePost(Database database, Post post) async {
    await database.update(
      'posts',
      post.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [post.id],
    );
  }
}
