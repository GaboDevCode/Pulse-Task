import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:pulse_task/presentation/providers/project_provider/projectprovider.dart';

class ProyectsView extends StatefulWidget {
  const ProyectsView({super.key});

  @override
  State<ProyectsView> createState() => _ProyectsViewState();
}

class _ProyectsViewState extends State<ProyectsView> {
  @override
  void initState() {
    super.initState();
    // Carga inicial de los proyectos
    Future.microtask(
      () =>
          // ignore: use_build_context_synchronously
          Provider.of<Projectprovider>(context, listen: false).loadProyectos(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final proyectos = context.watch<Projectprovider>().proyectos;

    return Scaffold(
      backgroundColor: const Color(0xFF222121),

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
                      title: Text(
                        proyecto.nombre,
                        selectionColor: const Color.fromARGB(179, 0, 0, 0),
                      ),
                      subtitle: Text(
                        proyecto.categoria,
                        selectionColor: const Color.fromARGB(255, 66, 60, 60),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  'Seguro que desea eliminar el proyecto?',
                                ),
                                content: Text(
                                  'Esta acción no se puede deshacer.',
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Cancelar'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      // Aquí puedes agregar la lógica para eliminar el proyecto
                                      Provider.of<Projectprovider>(
                                        context,
                                        listen: false,
                                      ).deleteProyecto(proyecto.id!);
                                      // Cerrar el diálogo
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Eliminar'),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      onTap: () {
                        // Navegar a la vista de detalle del proyecto
                        context.goNamed('details_proyects', extra: proyecto);
                      },
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        elevation: 40.0,
        onPressed: () {
          context.goNamed('proyects');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
