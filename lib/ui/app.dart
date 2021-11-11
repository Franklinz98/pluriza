import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pluriza/domain/use_cases/controllers/comments.dart';
import 'package:pluriza/domain/use_cases/controllers/common.dart';
import 'package:pluriza/domain/use_cases/controllers/posts.dart';
import 'package:pluriza/domain/use_cases/controllers/users.dart';
import 'package:pluriza/ui/pages/content/content_page.dart';
import 'package:pluriza/ui/pages/posts/posts_page.dart';
import 'package:pluriza/ui/theme/theme.dart';
import 'package:sqflite/sqflite.dart';

class PlurizaApp extends StatelessWidget {
  final Database database;
  const PlurizaApp({Key? key, required this.database}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(PostController());
    Get.put(UserController());
    Get.put(CommentController());
    Get.put(CommonController(database: database));
    return GetMaterialApp(
      title: 'Pluriza Test',
      theme: AppTheme.ligthTheme,
      debugShowCheckedModeBanner: false,
      home: const PostsPage(),
      routes: {
        '/posts': (context) => const PostsPage(),
        '/content': (context) => const ContentPage(),
      },
    );
  }
}
