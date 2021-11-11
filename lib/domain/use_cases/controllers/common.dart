import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';

class CommonController extends GetxController {
  final Database _database;

  CommonController({required Database database}) : _database = database;

  Database get database => _database;
}
