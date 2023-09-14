import 'package:sqflite/sqflite.dart';

import '../models/task.dart';

class DBHelper{
  static Database? _db;
  static final int _ver = 1;

  static Future<void> init() async {
    if (_db != null) {
      return;
    }
    try {
      _db = await openDatabase(
          await getDatabasesPath() + "tasks.db",
          version: _ver,
          onCreate: (db, version) {
            print("creating a new database");
            return db.execute(
                "CREATE TABLE tasks("
                    "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                    "title TEXT, note TEXT, startTime DATETIME, "
                    "endTime DATETIME, remind INTEGER, repeat TEXT, "
                    "color INTEGER, isCompleted INTEGER)"
            );
          }
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insert(Task task) async {
    final db = await _db;
    print("insertion called");
    return await db!.insert("tasks", task.toJson());
  }

  static Future<List<Task>> tasks() async {
    // Get a reference to the database.
    final db = await _db;

    // Query the table for all The Dogs.
    final List<Map<String, dynamic>> lists = await db!.query('tasks');

    // Convert the List<Map<String, dynamic> into a List<Dog>.
    return List.generate(lists.length, (i) {
      return Task(
        id: lists[i]['id'],
        title: lists[i]['title'],
        note: lists[i]['note'],
        isCompleted: lists[i]['isCompleted'],
        startTime: lists[i]['startTime'],
        endTime: lists[i]['endTime'],
        remind: lists[i]['remind'],
        repeat: lists[i]['repeat'],
        color: lists[i]['color'],
      );
    });
  }

  static Future<void> updateTask(Task task) async {
    // Get a reference to the database.
    final db = await _db;

    // Update the given Dog.
    await db!.update(
      'tasks',
      task.toJson(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [task.id],
    );
  }
}