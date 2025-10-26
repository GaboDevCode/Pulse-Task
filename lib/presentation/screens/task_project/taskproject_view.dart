import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pulse_task/presentation/providers/task_provider/taskprojectprovider.dart';
import 'package:pulse_task/presentation/widgets/tareasformcard.dart';

void mostrarFormularioCrearTarea(BuildContext context, int proyectoId) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return TareaFormCard(
        proyectoId: proyectoId,
        onGuardar: (nuevaTarea) async {
          await Provider.of<TaskProvider>(
            context,
            listen: false,
          ).addTarea(nuevaTarea);
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
        },
      );
    },
  );
}
