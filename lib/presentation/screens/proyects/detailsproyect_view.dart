import 'package:flutter/material.dart';
import 'package:pulse_task/domain/models/proyect_model/proyecto.dart';

class DetailsproyectView extends StatelessWidget {
  final Proyecto proyecto;

  const DetailsproyectView({super.key, required this.proyecto});
  @override
  Widget build(BuildContext context) {
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
              color: Colors.blueGrey,
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
                            _buildInfoLabel('Descripción:'),
                            const SizedBox(height: 16),
                            _buildInfoLabel('Categoría:'),
                            const SizedBox(height: 16),
                            _buildInfoLabel('Fecha de inicio:'),
                            if (proyecto.fechaFin != null)
                              const SizedBox(height: 16),
                            if (proyecto.fechaFin != null)
                              _buildInfoLabel('Fecha fin:'),
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
            // Lista de tareas recientes
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Tarea',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.add_box)),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildTaskItem('Content updates', '10 days ago'),
                  _buildTaskItem('App QA', '9 days ago'),
                  _buildTaskItem('Marketing strategy', '9 days ago'),
                  _buildTaskItem('Deployment flow', '9 days ago'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Métodos auxiliares para los estilos
  Widget _buildInfoLabel(String text) {
    return SizedBox(
      width: 100, // Ancho fijo para alinear las etiquetas
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.white70,
        ),
      ),
    );
  }

  Widget _buildInfoValue(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 16, color: Colors.white),
      softWrap: true,
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 16)),
      ],
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
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
            Text(
              timeAgo,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
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
