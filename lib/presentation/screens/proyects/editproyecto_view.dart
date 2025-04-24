import 'package:flutter/material.dart';
import 'package:pulse_task/domain/models/proyect_model/proyecto.dart';
import 'package:pulse_task/presentation/widgets/proyectform.dart';

class EditProyectoView extends StatelessWidget {
  final Proyecto proyecto;

  const EditProyectoView({super.key, required this.proyecto});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Proyectform(proyectoExistente: proyecto, isEditing: true),
    );
  }
}
