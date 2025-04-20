import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:pulse_task/presentation/providers/project_provider/projectprovider.dart';

class ProyectsView extends StatefulWidget {
  const ProyectsView({super.key});

  @override
  State<ProyectsView> createState() => _ProyectsViewState();
}

class _ProyectsViewState extends State<ProyectsView> {
  @override
  void initState() {
    super.initState();
    // Carga inicial de los proyectos
    Future.microtask(
      () =>
          // ignore: use_build_context_synchronously
          Provider.of<Projectprovider>(context, listen: false).loadProyectos(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final proyectos = context.watch<Projectprovider>().proyectos;

    return Scaffold(
      body:
          proyectos.isEmpty
              ? Center(child: Text('No hay proyectos creados'))
              : ListView.builder(
                itemCount: proyectos.length,
                itemBuilder: (context, index) {
                  final proyecto = proyectos[index];
                  return Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      title: Text(proyecto.nombre),
                      subtitle: Text(proyecto.categoria),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          await Provider.of<Projectprovider>(
                            context,
                            listen: false,
                          ).deleteProyecto(proyecto.id!);
                        },
                      ),
                      onTap: () {
                        context.goNamed('details_proyects', extra: proyecto);
                      },
                    ),
                  );
                },
              ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          context.goNamed('proyects');
        },
      ),
    );
  }
}
