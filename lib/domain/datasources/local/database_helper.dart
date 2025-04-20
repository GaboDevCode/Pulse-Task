import 'package:pulse_task/domain/models/proyect_model/proyecto.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('proyectos.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE proyectos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT NOT NULL,
        descripcion TEXT NOT NULL,
        categoria TEXT NOT NULL,
        fechaInicio TEXT NOT NULL,
        fechaFin TEXT
        )
    ''');
  }

  Future<int> createProyecto(Proyecto proyecto) async {
    final db = await instance.database;
    return await db.insert('proyectos', proyecto.toMap());
  }

  Future<List<Proyecto>> readallProyectos() async {
    final db = await instance.database;
    final result = await db.query('proyectos');
    return result.map((map) => Proyecto.fromMap(map)).toList();
  }

  Future<int> updateProyecto(Proyecto proyecto) async {
    final db = await instance.database;
    return await db.update(
      'proyectos',
      proyecto.toMap(),
      where: 'id=?',
      whereArgs: [proyecto.id],
    );
  }

  Future<int> deleteProyecto(int id) async {
    final db = await instance.database;

    return await db.delete('proyectos', where: 'id=?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
