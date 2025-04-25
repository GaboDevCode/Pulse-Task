import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pulse_task/domain/models/task_model/tarea.dart';
import 'package:pulse_task/presentation/providers/task_provider/taskprojectprovider.dart';
import 'package:pulse_task/presentation/widgets/tareasformcard.dart';

class TaskListWidget extends StatefulWidget {
  final int proyectoId;

  const TaskListWidget({super.key, required this.proyectoId});

  @override
  State<TaskListWidget> createState() => _TaskListWidgetState();
}

class _TaskListWidgetState extends State<TaskListWidget> {
  bool _isLoading = true;
  @override
  void initState() {
    super.initState();
    _loadTareas();
  }

  Future<void> _loadTareas() async {
    await Provider.of<TaskProvider>(
      context,
      listen: false,
    ).loadTareasPorProyecto(widget.proyectoId);
    setState(() {
      _isLoading = false;
    });
  }

  void mostrarFormularioEditarTarea(BuildContext context, Tarea tarea) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return TareaFormCard(
          proyectoId: tarea.proyectoId,
          tareaExistente: tarea,
          onGuardar: (tareaEditada) async {
            await Provider.of<TaskProvider>(
              context,
              listen: false,
            ).updateTarea(tareaEditada);
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Expanded(
      child: SafeArea(
        child: Consumer<TaskProvider>(
          builder: (context, taskprovider, child) {
            final tareas =
                taskprovider.tareas
                    .where((t) => t.proyectoId == widget.proyectoId)
                    .toList();

            if (tareas.isEmpty) {
              return const Center(child: Text("No hay tareas aún"));
            }

            return ListView.builder(
              itemCount: tareas.length,
              itemBuilder: (context, index) {
                final tarea = tareas[index];
                return Card(
                  elevation: 6,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 4,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Checkbox(
                          value: tarea.estado == 'completado',
                          onChanged: (bool? value) {
                            if (value != null) {
                              final nuevoEstado =
                                  value ? 'completado' : 'pendiente';
                              final tareaActualizada = Tarea(
                                id: tarea.id,
                                nombre: tarea.nombre,
                                descripcion: tarea.descripcion,
                                estado: nuevoEstado,
                                fechaCreacion: tarea.fechaCreacion,
                                notificado: tarea.notificado,
                                proyectoId: tarea.proyectoId,
                              );
                              Provider.of<TaskProvider>(
                                context,
                                listen: false,
                              ).updateTarea(tareaActualizada);
                            }
                          },
                        ),
                        // Contenido principal
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(tarea.nombre),
                              Text(
                                _formatDate(
                                  tarea.fechaVencimiento ?? DateTime.now(),
                                ),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                        // Iconos
                        Row(
                          mainAxisSize: MainAxisSize.min, // Importante
                          children: [
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        tarea.nombre,
                                        textAlign: TextAlign.center,
                                      ),
                                      content: Text(tarea.descripcion),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Cerrar'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: Icon(Icons.remove_red_eye_sharp),
                            ),

                            IconButton(
                              onPressed: () {
                                mostrarFormularioEditarTarea(context, tarea);
                              },
                              icon: Icon(Icons.wallet),
                            ),
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text(
                                        'Seguro que desea eliminar esta tarea?',
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
                                            Provider.of<TaskProvider>(
                                              context,
                                              listen: false,
                                            ).deleteTarea(tarea);
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
                              icon: Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}
