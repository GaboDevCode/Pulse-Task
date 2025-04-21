import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pulse_task/domain/models/proyect_model/proyecto.dart';
import 'package:pulse_task/presentation/providers/task_provider/taskprojectprovider.dart';
import 'package:pulse_task/presentation/screens/task_project/taskproject_view.dart';

class DetailsproyectView extends StatelessWidget {
  final Proyecto proyecto;

  const DetailsproyectView({super.key, required this.proyecto});

  @override
  Widget build(BuildContext context) {
    //   final colorTheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: Text(proyecto.nombre)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card con la información del proyecto
            Card(
              elevation: 10,
              margin: const EdgeInsets.only(bottom: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Primera fila: Descripción y Categoría
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Columna izquierda (etiquetas)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoLabel('Descripción:', Colors.black),
                            const SizedBox(height: 16),
                            _buildInfoLabel('Categoría:', Colors.black),
                            const SizedBox(height: 16),
                            _buildInfoLabel('Fecha de inicio:', Colors.black),
                            if (proyecto.fechaFin != null)
                              const SizedBox(height: 16),
                            if (proyecto.fechaFin != null)
                              _buildInfoLabel('Fecha fin:', Colors.black),
                          ],
                        ),
                        const SizedBox(width: 16),
                        // Columna derecha (valores)
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildInfoValue(proyecto.descripcion),
                              const SizedBox(height: 16),
                              _buildInfoValue(proyecto.categoria),
                              const SizedBox(height: 16),
                              _buildInfoValue(
                                _formatDate(proyecto.fechaInicio),
                              ),
                              if (proyecto.fechaFin != null)
                                const SizedBox(height: 16),
                              if (proyecto.fechaFin != null)
                                _buildInfoValue(
                                  _formatDate(proyecto.fechaFin!),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tarea',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                ),
                IconButton(
                  onPressed: () {
                    mostrarFormularioCrearTarea(context, proyecto.id!);
                  },
                  icon: Icon(Icons.add_box),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Lista de tareas recientes
            TaskListWidget(proyectoId: proyecto.id!),
          ],
        ),
      ),
    );
  }

  // Métodos auxiliares para los estilos
  Widget _buildInfoLabel(String text, Color black) {
    return SizedBox(
      width: 100, // Ancho fijo para alinear las etiquetas
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Color.fromARGB(179, 0, 0, 0),
        ),
      ),
    );
  }

  Widget _buildInfoValue(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        color: Color.fromARGB(255, 66, 60, 60),
      ),
      softWrap: true,
    );
  }

  Widget _buildTaskItem(String title, String timeAgo) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  '# 1000ms',
                  style: TextStyle(
                    color: Color.fromARGB(255, 66, 60, 60),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            Text(
              timeAgo,
              style: const TextStyle(
                color: Color.fromARGB(255, 66, 60, 60),
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}

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

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return SizedBox(
      height: 400, // altura que quieras para la lista
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
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: ListTile(
                  title: Text(tarea.nombre),
                  subtitle: Text(
                    _formatDate(tarea.fechaVencimiento ?? DateTime.now()),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  // Suponiendo que ya tenés este método definido donde usás este widget:
  Widget _buildTaskItem(String nombre, String fecha) {
    return ListTile(title: Text(nombre), subtitle: Text(fecha));
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}
