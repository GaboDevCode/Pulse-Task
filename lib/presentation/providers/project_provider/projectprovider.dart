import 'package:flutter/material.dart';
import 'package:pulse_task/domain/datasources/local/database_helper.dart';
import 'package:pulse_task/domain/models/proyect_model/proyecto.dart';

class Projectprovider extends ChangeNotifier {
  List<Proyecto> _proyectos = [];
  final DatabaseHelper _databaseHelper = DatabaseHelper.instance;

  List<Proyecto> get proyectos => _proyectos;

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
}
