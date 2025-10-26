import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:pulse_task/presentation/providers/project_provider/projectprovider.dart';

class ProyectosCompletadosView extends StatelessWidget {
  const ProyectosCompletadosView({super.key});

  @override
  Widget build(BuildContext context) {
    final proyectosCompletados =
        context.watch<Projectprovider>().proyectosCompletados;
    final colorTema = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Proyectos Completados',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: const Color(0xFF222121),
        automaticallyImplyLeading: true, // Ensures the back button is shown
      ),
      backgroundColor: const Color(0xFF222121),

      body:
          proyectosCompletados.isEmpty
              ? Center(child: Text('No hay proyectos completados'))
              : ListView.builder(
                itemCount: proyectosCompletados.length,
                itemBuilder: (context, index) {
                  final proyecto = proyectosCompletados[index];
                  return Card(
                    color: Theme.of(context).cardColor,
                    margin: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                    elevation: 10,
                    child: ListTile(
                      leading: Icon(Icons.assignment, color: colorTema),
                      title: Text(proyecto.nombre),
                      subtitle: Text(proyecto.descripcion),
                      onTap: () {
                        context.pushNamed('details_proyects', extra: proyecto);
                      },
                    ),
                  );
                },
              ),
    );
  }
}
