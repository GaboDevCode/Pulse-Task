import 'package:pulse_task/domain/models/proyect_model/proyecto.dart';

abstract class LocalDataSource {
  Future<int> createProyect(Proyecto proyecto);
  Future<List<Proyecto>> getProyectos();
  Future<void> updateProyect(Proyecto proyecto);
  Future<void> deleteProyecto(int id);
}
