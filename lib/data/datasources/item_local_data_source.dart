import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../../src/models/item_model.dart';

class ItemLocalDataSource {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'teste_mobiles.db');

    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE publisher( id INTEGER PRIMARY KEY,  publisher TEXT, title TEXT,source_url TEXT,  recipe_id TEXT, image_url TEXT, social_rank REAL, publisher_url TEXT  )',
    );
  }

  Future<void> insertItem(ItemModel item) async {
    final db = await database;
    await db.insert(
      'publisher',
      item.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ItemModel>> getItems() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db. query('publisher');
    return List.generate(maps.length, (index) => ItemModel.fromJson(maps[index]));
  }

  Future<void> updateItem(ItemModel item) async {
    final db = await database;
    await db.update(
      'publisher',
      item.toJson(),
      where: 'id = ?',
      whereArgs: [item.recipeId],
    );
  }

  Future<void> deleteItem(String id) async {
    final db = await database;
    await db.delete(
      'publisher',
      where: 'recipe_id = ?',
      whereArgs: [id],
    );
  }
}
