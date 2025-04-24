import 'package:pulse_task/domain/models/proyect_model/proyecto.dart';
import 'package:pulse_task/domain/models/task_model/tarea.dart';
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
        relevancia INTEGER NOT NULL, 
        fechaInicio TEXT NOT NULL,
        fechaFin TEXT

      )
    ''');

    await db.execute('''
      CREATE TABLE tareas (
         id INTEGER PRIMARY KEY AUTOINCREMENT,
         nombre TEXT NOT NULL,
         descripcion TEXT NOT NULL,
         estado TEXT NOT NULL,
         fechaCreacion TEXT NOT NULL,
         fechaVencimiento TEXT,
         notificado INTEGER NOT NULL DEFAULT 0,  
         proyectoId INTEGER NOT NULL,
         FOREIGN KEY (proyectoId) REFERENCES proyectos (id) ON DELETE CASCADE
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

  // Funciones de Tareas

  Future<int> createTask(Tarea tarea) async {
    final db = await instance.database;
    return await db.insert('Tareas', tarea.toMap());
  }

  Future<List<Tarea>> readAllTask() async {
    final db = await instance.database;
    final result = await db.query('tareas');
    return result.map((map) => Tarea.fromMap(map)).toList();
  }

  Future<int> updateTask(Tarea tarea) async {
    final db = await instance.database;
    return db.update(
      'tareas',
      tarea.toMap(),
      where: 'id = ?',
      whereArgs: [tarea.id],
    );
  }

  Future<int> deleteTask(Tarea tarea) async {
    final db = await instance.database;
    return db.delete('tareas', where: 'id = ?', whereArgs: [tarea.id]);
  }

  // Obtener todas las tareas por proyecto
  Future<List<Tarea>> readAllTaskProyect(int proyectoId) async {
    final db = await instance.database;
    final result = await db.query(
      'tareas',
      where: 'proyectoId = ?',
      whereArgs: [proyectoId],
    );
    return result.map((map) => Tarea.fromMap(map)).toList();
  }

  //obtener tareas por vencer en los próximos X días
  Future<List<Tarea>> getTaskPorVencerEn(int dias) async {
    final db = await instance.database;
    final ahora = DateTime.now();
    final limite = ahora.add(Duration(days: dias));

    final result = await db.query(
      'tareas',
      where:
          'fechaVencimiento IS NOT NULL AND fechaVencimiento <= ? AND notificado = 0',
      whereArgs: [limite.toIso8601String()],
    );

    return result.map((map) => Tarea.fromMap(map)).toList();
  }

  // actualizar campo 'notificado'
  Future<void> marcarComoNotificada(int tareaId) async {
    final db = await instance.database;
    await db.update(
      'tareas',
      {'notificado': 1},
      where: 'id = ?',
      whereArgs: [tareaId],
    );
  }
}
