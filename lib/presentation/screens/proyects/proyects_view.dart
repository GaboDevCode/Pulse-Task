import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:pulse_task/presentation/providers/project_provider/projectprovider.dart';

class ProyectsView extends StatelessWidget {
  const ProyectsView({super.key});

  @override
  Widget build(BuildContext context) {
    final proyectoProvider = Provider.of<Projectprovider>(context);
    final proyectos = proyectoProvider.proyectos;
    WidgetsBinding.instance.addPersistentFrameCallback((_) {
      proyectoProvider.loadProyectos();
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('Mis Proyectos'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => proyectoProvider.loadProyectos(),
          ),
        ],
      ),
      body:
          proyectos.isEmpty
              ? Center(child: Text('No hay proyectos creados'))
              : ListView.builder(
                itemCount: proyectos.length,
                itemBuilder: (context, index) {
                  final proyecto = proyectos[index];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      title: Text(proyecto.nombre),
                      subtitle: Text(proyecto.categoria),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          await proyectoProvider.deleteProyecto(proyecto.id!);
                        },
                      ),
                      onTap: () {
                        context.goNamed('details_proyects', extra: proyecto);
                      },
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // Navegar a la pantalla de creación de proyectos
          context.goNamed('proyects');
        },
      ),
    );
  }
}
