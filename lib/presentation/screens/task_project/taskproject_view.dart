import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pulse_task/domain/models/task_model/tarea.dart';
import 'package:pulse_task/presentation/providers/task_provider/taskprojectprovider.dart';

void mostrarFormularioCrearTarea(BuildContext context, int proyectoId) {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nombreController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();
  DateTime? fechaSeleccionada;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
          top: 20,
          left: 20,
          right: 20,
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Nueva Tarea",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(height: 16),

                // Nombre
                TextFormField(
                  controller: nombreController,
                  decoration: InputDecoration(labelText: 'Nombre de la tarea'),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Este campo es obligatorio'
                              : null,
                ),
                SizedBox(height: 12),

                // Descripción
                TextFormField(
                  controller: descripcionController,
                  decoration: InputDecoration(labelText: 'Descripción'),
                  maxLines: 2,
                ),
                SizedBox(height: 12),

                // Fecha de vencimiento
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        fechaSeleccionada == null
                            ? 'Seleccionar fecha de vencimiento'
                            : 'Vence: ${fechaSeleccionada!.toLocal().toString().split(' ')[0]}',
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.calendar_today),
                      onPressed: () async {
                        final DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 365)),
                        );
                        if (pickedDate != null) {
                          fechaSeleccionada = pickedDate;
                        }
                      },
                    ),
                  ],
                ),

                SizedBox(height: 20),

                // Botón Guardar
                ElevatedButton(
                  child: Text('Guardar'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final tarea = Tarea(
                        nombre: nombreController.text,
                        descripcion: descripcionController.text,
                        estado: 'pendiente',
                        fechaCreacion: DateTime.now(),
                        fechaVencimiento: fechaSeleccionada,
                        notificado: 0,
                        proyectoId: proyectoId,
                      );

                      await Provider.of<TaskProvider>(
                        context,
                        listen: false,
                      ).addTarea(tarea);
                      Navigator.pop(context); // Cierra el modal
                    }
                  },
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      );
    },
  );
}
