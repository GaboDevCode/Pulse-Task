import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pulse_task/presentation/providers/project_provider/projectprovider.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final colorTema = Theme.of(context).colorScheme.primary;

    return SafeArea(
      child: Consumer<Projectprovider>(
        builder: (context, projectProvider, child) {
          final proyectosAlta =
              projectProvider.proyectoPrioridadAlta
                  .where((proyecto) => proyecto.estado != 'completado')
                  .toList();

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: proyectosAlta.length,
            itemBuilder: (context, index) {
              final proyecto = proyectosAlta[index];

              return Card(
                color: Theme.of(context).cardColor,
                margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                elevation: 10,
                child: ListTile(
                  leading: Icon(Icons.assignment, color: colorTema),
                  title: Text(
                    proyecto.nombre,
                    style: const TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  onTap: () {
                    // Navegar a la vista de detalle del proyecto
                    context.goNamed('details_proyects', extra: proyecto);
                  },
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        proyecto.descripcion,
                        style: const TextStyle(
                          color: Color.fromARGB(179, 0, 0, 0),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.category,
                            color: const Color.fromARGB(255, 0, 0, 0),
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            proyecto.categoria,
                            style: TextStyle(
                              color: const Color.fromARGB(255, 0, 0, 0),
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
                              Icon(
                                Icons.calendar_today,
                                color: const Color.fromARGB(255, 37, 36, 36),
                                size: 14,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${DateFormat('dd/MM/yyyy').format(proyecto.fechaInicio)} - '
                                '${DateFormat('dd/MM/yyyy').format(proyecto.fechaFin!)}',
                                style: TextStyle(
                                  color: const Color.fromARGB(255, 34, 33, 33),
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
                        const Icon(Icons.priority_high, color: Colors.red),
                      IconButton(
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
                                      Provider.of<Projectprovider>(
                                        context,
                                        listen: false,
                                      ).deleteProyecto(proyecto.id!);
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
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
