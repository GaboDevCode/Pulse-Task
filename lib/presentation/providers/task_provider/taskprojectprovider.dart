import 'package:flutter/material.dart';
import 'package:pulse_task/domain/datasources/local/database_helper.dart';
import 'package:pulse_task/domain/models/task_model/tarea.dart';
import 'package:pulse_task/presentation/widgets/InterstitialAdManager.dart';

class TaskProvider extends ChangeNotifier {
  List<Tarea> _tareas = [];
  InterstitialAdManager? _adManager;
  final DatabaseHelper _databaseHelper;
  int _tareasCreadas = 0;
  int _tareasEliminadas = 0;
  int _tareasCompletadas = 0;

  TaskProvider(this._adManager, this._databaseHelper) {
    // Precargar anuncio solo si está disponible
    _adManager?.loadInterstitialAd();
  }

  void updateAdManager(InterstitialAdManager newManager) {
    _adManager = newManager;
    // Precargar anuncio cuando se actualice
    _adManager?.loadInterstitialAd();
    notifyListeners();
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

    // Mostrar anuncio solo si está disponible y se cumple la condición
    if (_tareasCreadas % 3 == 0 && _adManager != null) {
      await _adManager!.showInterstitial();
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
    _tareasEliminadas++;

    if (_tareasEliminadas % 3 == 0 && _adManager != null) {
      await _adManager!.showInterstitial();
    }
  }

  Future<void> completarTarea(Tarea tarea) async {
    final tareaCompletada = tarea.copyWith(estado: 'completado');
    await _databaseHelper.updateTask(tareaCompletada);
    final index = _tareas.indexWhere((t) => t.id == tarea.id);
    if (index != -1) {
      _tareas[index] = tareaCompletada;
      notifyListeners();
    }
    _tareasCompletadas++;

    if (_tareasCompletadas % 2 == 0 && _adManager != null) {
      await _adManager!.showInterstitial();
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
