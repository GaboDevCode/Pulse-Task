//Configuracion principal de las rutas

import 'package:go_router/go_router.dart';
import 'package:pulse_task/configuration/router/route_names.dart';
import 'package:pulse_task/domain/models/proyect_model/proyecto.dart';
import 'package:pulse_task/presentation/screens/home/home_view.dart';
import 'package:pulse_task/presentation/screens/profile/profile_view.dart';
import 'package:pulse_task/presentation/screens/proyects/detailsproyect_view.dart';
import 'package:pulse_task/presentation/widgets/proyectform.dart';

final appRouter = GoRouter(
  initialLocation: RouteNames.home,
  routes: [
    GoRoute(
      path: RouteNames.home,
      name: 'home',
      builder: (context, state) => const HomeView(),
      routes: [
        GoRoute(
          path: 'proyects/form', // Ruta única para el formulario
          name: 'proyect_form',
          builder: (context, state) {
            // Si hay "extra", es edición; si no, es creación
            final proyecto = state.extra as Proyecto?;
            return Proyectform(
              proyectoExistente: proyecto,
              isEditing: proyecto != null, // true si hay proyecto
            );
          },
        ),
        GoRoute(
          path: 'details_proyects',
          name: 'details_proyects',
          builder: (context, state) {
            final proyecto = state.extra as Proyecto;
            return DetailsproyectView(proyecto: proyecto);
          },
        ),
        GoRoute(
          path: 'profile', // Ruta única para el formulario
          name: 'profile',
          builder: (context, state) => const ProfileView(),
        ),
      ],
    ),
  ],
);
