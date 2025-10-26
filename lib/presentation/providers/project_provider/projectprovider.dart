import 'package:flutter/material.dart';
import 'package:pulse_task/domain/datasources/local/database_helper.dart';
import 'package:pulse_task/domain/models/proyect_model/proyecto.dart';
import 'package:pulse_task/domain/models/task_model/tarea.dart';
import 'package:pulse_task/presentation/widgets/InterstitialAdManager.dart';

class Projectprovider extends ChangeNotifier {
  List<Proyecto> _proyectos = [];
  InterstitialAdManager? _adManager;
  final DatabaseHelper _databaseHelper;

  Projectprovider(this._adManager, this._databaseHelper) {
    // Precargar anuncio solo si está disponible
    _adManager?.loadInterstitialAd();
  }

  void updateAdManager(InterstitialAdManager newManager) {
    _adManager = newManager;
    // Precargar anuncio cuando se actualice
    _adManager?.loadInterstitialAd();
    notifyListeners();
  }

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

    // Mostrar anuncio solo si está disponible
    if (_adManager != null) {
      final adShow = await _adManager!.showInterstitial();
      if (!adShow) {
        debugPrint("Error al mostrar el anuncio");
      }
    }
  }

  Future<void> updateProyecto(Proyecto proyecto) async {
    await _databaseHelper.updateProyecto(proyecto);
    await loadProyectos();

    if (_adManager != null) {
      final adShow = await _adManager!.showInterstitial();
      if (!adShow) {
        debugPrint("Error al mostrar el anuncio");
      }
    }
  }

  Future<void> deleteProyecto(int id) async {
    await _databaseHelper.deleteProyecto(id);
    await loadProyectos();

    if (_adManager != null) {
      final adShow = await _adManager!.showInterstitial();
      if (!adShow) {
        debugPrint("Error al mostrar el anuncio");
      }
    }
  }

  List<Proyecto> get proyectoPrioridadAlta {
    return _proyectos.where((p) => p.relevancia == 3).toList();
  }

  Future<void> actualizarEstadoProyecto(
    int proyectoId,
    String nuevoEstado,
  ) async {
    final db = await _databaseHelper.database;

    await db.update(
      'proyectos',
      {'estado': nuevoEstado},
      where: 'id =?',
      whereArgs: [proyectoId],
    );

    final idx = _proyectos.indexWhere((p) => p.id == proyectoId);
    if (idx != -1) {
      final proyecto = _proyectos[idx];
      final estadoAnterior = proyecto.estado;

      proyecto.estado = nuevoEstado;
      notifyListeners();

      // Mostrar anuncio solo si está disponible y se cumplen las condiciones
      if (estadoAnterior != "completado" &&
          nuevoEstado == "completado" &&
          _adManager != null) {
        try {
          await _adManager!.showInterstitial();
        } catch (e) {
          debugPrint("Error al mostrar anuncio: $e");
        }
      }
    }
  }

  List<Proyecto> get proyectosActivos =>
      _proyectos.where((p) => p.estado != 'completado').toList();

  List<Proyecto> get proyectosCompletados =>
      _proyectos.where((p) => p.estado == 'completado').toList();
}
