import 'package:pulse_task/domain/datasources/local/localdatasource.dart';
import 'package:pulse_task/domain/models/proyect_model/proyecto.dart';

class ProyectoLocalDatasourceImpl implements LocalDataSource {
  //final DatabaseHelper dbHelper;
  // ProyectoLocalDataSourceImpl(this.dbHelper);

  @override
  Future<int> createProyect(Proyecto proyecto) {
    // TODO: implement createProyect
    throw UnimplementedError();
  }

  @override
  Future<void> deleteProyecto(int id) {
    // TODO: implement deleteProyecto
    throw UnimplementedError();
  }

  @override
  Future<List<Proyecto>> getProyectos() {
    // TODO: implement getProyectos
    throw UnimplementedError();
  }

  @override
  Future<void> updateProyect(Proyecto proyecto) {
    // TODO: implement updateProyect
    throw UnimplementedError();
  }
}
