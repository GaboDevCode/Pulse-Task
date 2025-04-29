import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
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
    final proyectos = context.watch<Projectprovider>().proyectosActivos;
    final colorTema = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: const Color(0xFF222121),
      body:
          proyectos.isEmpty
              ? const Center(child: Text('No hay proyectos creados'))
              : ListView.builder(
                itemCount: proyectos.length,
                itemBuilder: (context, index) {
                  final proyecto = proyectos[index];
                  return Card(
                    color: Theme.of(context).cardColor,
                    margin: const EdgeInsets.symmetric(
                      vertical: 6,
                      horizontal: 8,
                    ),
                    elevation: 10,
                    child: InkWell(
                      onTap: () {
                        // Navegar a la vista de detalle del proyecto
                        context.goNamed('details_proyects', extra: proyecto);
                      },
                      child: ListTile(
                        leading: Icon(Icons.assignment, color: colorTema),
                        title: Text(
                          proyecto.nombre,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              proyecto.descripcion,
                              style: const TextStyle(color: Colors.black87),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.category,
                                  color: Colors.black,
                                  size: 14,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  proyecto.categoria,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            if (proyecto.fechaFin != null)
                              Padding(
                                padding: const EdgeInsets.only(top: 4),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.calendar_today,
                                      color: Colors.black54,
                                      size: 14,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      '${DateFormat('dd/MM/yyyy').format(proyecto.fechaInicio)} - '
                                      '${DateFormat('dd/MM/yyyy').format(proyecto.fechaFin!)}',
                                      style: const TextStyle(
                                        color: Colors.black54,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (proyecto.relevancia == 3)
                              const Icon(
                                Icons.priority_high,
                                color: Colors.red,
                              ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () async {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text(
                                        ' ¿Seguro que desea eliminar el proyecto?',
                                      ),
                                      content: const Text(
                                        'Esta acción no se puede deshacer.',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Cancelar'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Provider.of<Projectprovider>(
                                              context,
                                              listen: false,
                                            ).deleteProyecto(proyecto.id!);
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Eliminar'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        elevation: 40.0,
        onPressed: () {
          context.pushNamed('proyect_form'); // O:
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
