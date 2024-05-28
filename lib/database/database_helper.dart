import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

abstract class DatabaseHelper {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initialize();
    return _database!;
  }

  Future<Database> _initialize() async {
    final path = join(await getDatabasesPath(), 'finances.db');
    var database = await openDatabase(path, version: 1, onCreate: _onCreate);
    return database;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS accounts (
        "id" INTEGER NOT NULL PRIMARY KEY,
        "name" TEXT NOT NULL,
        "initialBalance" INTEGER NOT NULL,
        "balance" INTEGER NOT NULL,
        "currency" TEXT NOT NULL,
        "deleted" BOOL NOT NULL DEFAULT FALSE
      );
    ''');
  }
}
