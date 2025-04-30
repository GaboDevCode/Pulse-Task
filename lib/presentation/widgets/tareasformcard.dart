import 'package:flutter/material.dart';
import 'package:pulse_task/domain/models/task_model/tarea.dart';

class TareaFormCard extends StatefulWidget {
  final int proyectoId;
  final Tarea? tareaExistente;
  final Function(Tarea) onGuardar;

  const TareaFormCard({
    super.key,
    required this.proyectoId,
    this.tareaExistente,
    required this.onGuardar,
  });

  @override
  // ignore: library_private_types_in_public_api
  _TareaFormCardState createState() => _TareaFormCardState();
}

class _TareaFormCardState extends State<TareaFormCard> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nombreController;
  late TextEditingController descripcionController;
  DateTime? fechaSeleccionada;

  @override
  void initState() {
    super.initState();
    nombreController = TextEditingController(
      text: widget.tareaExistente?.nombre,
    );
    descripcionController = TextEditingController(
      text: widget.tareaExistente?.descripcion,
    );
    fechaSeleccionada = widget.tareaExistente?.fechaVencimiento;
  }

  @override
  void dispose() {
    nombreController.dispose();
    descripcionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                widget.tareaExistente == null ? "Nueva Tarea" : "Editar Tarea",
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
                        initialDate: fechaSeleccionada ?? DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(Duration(days: 365)),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          fechaSeleccionada = pickedDate;
                        });
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
                      id: widget.tareaExistente?.id,
                      nombre: nombreController.text,
                      descripcion: descripcionController.text,
                      estado: widget.tareaExistente?.estado ?? 'pendiente',
                      fechaCreacion:
                          widget.tareaExistente?.fechaCreacion ??
                          DateTime.now(),
                      fechaVencimiento: fechaSeleccionada,
                      notificado: widget.tareaExistente?.notificado ?? 0,
                      proyectoId: widget.proyectoId,
                    );

                    widget.onGuardar(tarea);
                  }
                },
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
