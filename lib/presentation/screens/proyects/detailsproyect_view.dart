import 'package:flutter/material.dart';
import 'package:pulse_task/domain/models/proyect_model/proyecto.dart';
import 'package:pulse_task/presentation/screens/task_project/%20tasklistwidget.dart';
import 'package:pulse_task/presentation/screens/task_project/taskproject_view.dart';

class DetailsproyectView extends StatelessWidget {
  final Proyecto proyecto;

  const DetailsproyectView({super.key, required this.proyecto});

  @override
  Widget build(BuildContext context) {
    //   final colorTheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: const Color(0xFF222121),

      appBar: AppBar(
        title: Text(
          proyecto.nombre,
          style: TextStyle(color: const Color(0xFFFFFFFF)),
        ),
        backgroundColor: const Color(0xFF222121),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
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
                        // Icono en la parte superior derecha
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.pending_actions_outlined),
                          color: const Color.fromARGB(255, 31, 31, 31),
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
                const Text(
                  'Tarea',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                    color: Color(0xFFFFFFFF),
                  ),
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

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
