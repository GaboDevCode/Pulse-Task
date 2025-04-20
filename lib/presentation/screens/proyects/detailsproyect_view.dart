import 'package:flutter/material.dart';
import 'package:pulse_task/domain/models/proyect_model/proyecto.dart';

class DetailsproyectView extends StatelessWidget {
  final Proyecto proyecto; // Recibimos el proyecto directamente

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
            Text('Descripción:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(proyecto.descripcion),
            SizedBox(height: 20),
            Text('Categoría:', style: TextStyle(fontWeight: FontWeight.bold)),
            Text(proyecto.categoria),
            SizedBox(height: 20),
            Text(
              'Fecha de inicio:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(_formatDate(proyecto.fechaInicio)),
            SizedBox(height: 20),
            if (proyecto.fechaFin != null) ...[
              Text('Fecha fin:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(_formatDate(proyecto.fechaFin!)),
              SizedBox(height: 20),
            ],
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
