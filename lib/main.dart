import 'package:flutter/material.dart';
import 'package:pluriza/data/services/sqflite_database.dart';
import 'package:pluriza/ui/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await SqfliteService().connectDatabase();
  runApp(
    PlurizaApp(
      database: database,
    ),
  );
}
