import 'package:flutter/material.dart';
import 'package:pulse_task/domain/datasources/local/database_helper.dart';
import 'package:pulse_task/domain/models/proyect_model/proyecto.dart';
import 'package:pulse_task/domain/models/task_model/tarea.dart';

class Projectprovider extends ChangeNotifier {
  List<Proyecto> _proyectos = [];
  List<Tarea> _tareas = [];

  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  Projectprovider(Type database);

  List<Proyecto> get proyectos => _proyectos;

  double calcularProgresoProyecto(int proyectoId, List<Tarea> tareas) {
    final tareasProyecto =
        tareas.where((t) => t.proyectoId == proyectoId).toList();
    if (tareasProyecto.isEmpty) return 0.0;

    final tareasCompletadas =
        tareasProyecto.where((t) => t.estado == 'completado').length;
    return tareasCompletadas / tareasProyecto.length;
  }

  Future<void> loadProyectos() async {
    _proyectos = await _databaseHelper.readallProyectos();
    notifyListeners();
  }

  Future<void> addProyecto(Proyecto proyecto) async {
    await _databaseHelper.createProyecto(proyecto);
    await loadProyectos();
  }

  Future<void> updateProyecto(Proyecto proyecto) async {
    await _databaseHelper.updateProyecto(proyecto);
    await loadProyectos();
  }

  Future<void> deleteProyecto(int id) async {
    await _databaseHelper.deleteProyecto(id);
    await loadProyectos();
  }

  List<Proyecto> get proyectoPrioridadAlta {
    return _proyectos.where((p) => p.relevancia == 3).toList();
  }

  Future<void> actualizarEstadoProyecto(
    int proyectoId,
    String nuevoEstado,
  ) async {
    final db = await DatabaseHelper.instance.database;
    await db.update(
      'proyectos',
      {'estado': nuevoEstado},
      where: 'id =?',
      whereArgs: [proyectoId],
    );

    // Refrescar la memoria
    final idx = _proyectos.indexWhere((p) => p.id == proyectoId);
    if (idx != -1) {
      _proyectos[idx].estado = nuevoEstado;
      notifyListeners();
    }
  }

  List<Proyecto> get proyectosActivos =>
      _proyectos.where((p) => p.estado != 'completado').toList();

  List<Proyecto> get proyectosCompletados =>
      _proyectos.where((p) => p.estado == 'completado').toList();
}
