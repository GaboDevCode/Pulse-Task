import 'package:flutter/material.dart';
import 'package:pulse_task/domain/datasources/local/database_helper.dart';
import 'package:pulse_task/domain/models/task_model/tarea.dart';

class TaskProvider extends ChangeNotifier {
  List<Tarea> _tareas = [];
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  TaskProvider(database);

  List<Tarea> get tareas => _tareas;

  Future<void> loadTareasPorProyecto(int proyectoId) async {
    _tareas = await _databaseHelper.readAllTaskProyect(proyectoId);
    notifyListeners();
  }

  Future<void> addTarea(Tarea tarea) async {
    await _databaseHelper.createTask(tarea);
    await loadTareasPorProyecto(tarea.proyectoId);
  }

  Future<void> updateTarea(Tarea tarea) async {
    await _databaseHelper.updateTask(tarea);
    await loadTareasPorProyecto(tarea.proyectoId);
  }

  Future<void> deleteTarea(Tarea tarea) async {
    await _databaseHelper.deleteTask(tarea);
    await loadTareasPorProyecto(tarea.proyectoId);
  }

  Future<void> marcarComoNotificada(int tareaId) async {
    await _databaseHelper.marcarComoNotificada(tareaId);
  }

  // Future<void> tareaCompletada(Tarea tarea, int completado) async {
  //   await _databaseHelper.tareaCompletada(tarea, tarea.completado);
  // }

  /// Filtra las tareas por vencer dentro de los próximos [dias]
  Future<List<Tarea>> getTareasPorVencerEn(int dias) async {
    return await _databaseHelper.getTaskPorVencerEn(dias);
  }
}
