import 'package:flutter/material.dart';
import 'package:pulse_task/domain/datasources/local/database_helper.dart';
import 'package:pulse_task/domain/models/task_model/tarea.dart';
import 'package:pulse_task/presentation/widgets/InterstitialAdManager.dart';

class TaskProvider extends ChangeNotifier {
  List<Tarea> _tareas = [];
  final InterstitialAdManager _adManager;
  final DatabaseHelper _databaseHelper;
  int _tareasCreadas = 0;

  TaskProvider(this._adManager, this._databaseHelper) {
    _adManager.loadInterstitialAd();
  }
  List<Tarea> get tareas => _tareas;

  Future<void> loadTareasPorProyecto(int proyectoId) async {
    _tareas = await _databaseHelper.readAllTaskProyect(proyectoId);
    notifyListeners();
  }

  Future<void> addTarea(Tarea tarea) async {
    await _databaseHelper.createTask(tarea);
    await loadTareasPorProyecto(tarea.proyectoId);
    _tareasCreadas++;

    if (_tareasCreadas % 3 == 0) {
      await _adManager.showIntersticial();
    }
  }

  Future<void> updateTarea(Tarea tarea) async {
    await _databaseHelper.updateTask(tarea);
    final index = _tareas.indexWhere((t) => t.id == tarea.id);
    if (index != -1) {
      _tareas[index] = tarea;
      notifyListeners();
    }
  }

  Future<void> deleteTarea(Tarea tarea) async {
    await _databaseHelper.deleteTask(tarea);
    await loadTareasPorProyecto(tarea.proyectoId);
  }

  Future<void> completarTarea(Tarea tarea) async {
    final tareaCompletada = tarea.copyWith(estado: 'completado');
    await _databaseHelper.updateTask(tareaCompletada);
    final index = _tareas.indexWhere((t) => t.id == tarea.id);
    if (index != -1) {
      _tareas[index] = tareaCompletada;
      notifyListeners();
    }
  }

  Future<void> marcarComoNotificada(int tareaId) async {
    await _databaseHelper.marcarComoNotificada(tareaId);
  }

  Future<List<Tarea>> getTareasPorVencerEn(int dias) async {
    return await _databaseHelper.getTaskPorVencerEn(dias);
  }

  void cargarTareas(List<Tarea> tareas) {
    _tareas = tareas;
    notifyListeners();
  }
}
