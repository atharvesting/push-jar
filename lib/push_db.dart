import 'dart:convert';
import 'package:path/path.dart';
import 'package:push_jar/push.dart';
import 'package:sqflite/sqflite.dart';

class PushDatabase {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'pushes.db');

    _db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE pushes (
            id INTEGER PRIMARY KEY,
            title TEXT NOT NULL,
            date_time INTEGER NOT NULL,
            tags TEXT NOT NULL
          )
        ''');
      },
    );

    return _db!;
  }

  static Future<void> insertPush(Push push) async {
    final db = await database;
    await db.insert(
      'pushes',
      push.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Push>> getAllPushes() async {
    final db = await database;
    final maps = await db.query('pushes');
    return maps.map((m) => Push.fromMap(m)).toList();
  }

  static void clearPushes() async {
    final db = await database;
    db.delete('pushes');
  }
}
