import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'sudutmovie.db');
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY,
        email TEXT,
        password TEXT
      )
    ''');
  }

  Future<bool> register(String email, String password) async {
    Database? db = await instance.database;
    try {
      await db?.insert('users', {'email': email, 'password': password});
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> login(String email, String password) async {
    Database? db = await instance.database;
    List<Map<String, dynamic>> user = await db?.query('users',
            where: 'email = ? AND password = ?',
            whereArgs: [email, password]) ??
        [];
    return user.isNotEmpty;
  }
}
