import 'package:flutter/material.dart';
import 'package:pulse_task/presentation/widgets/proyectform.dart';

class CreateProyectoView extends StatelessWidget {
  const CreateProyectoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Proyectform(isEditing: true));
  }
}
