//Configuracion principal de las rutas

import 'package:go_router/go_router.dart';
import 'package:pulse_task/configuration/router/route_names.dart';
import 'package:pulse_task/domain/models/proyect_model/proyecto.dart';
import 'package:pulse_task/presentation/screens/home/home_view.dart';
import 'package:pulse_task/presentation/screens/profile/profile_view.dart';
import 'package:pulse_task/presentation/screens/proyects/createproyect_view.dart';
import 'package:pulse_task/presentation/screens/proyects/detailsproyect_view.dart';

final appRouter = GoRouter(
  initialLocation: RouteNames.home,
  routes: [
    GoRoute(
      path: RouteNames.home,
      name: 'home',
      builder: (context, state) => const HomeView(),
      routes: [
        GoRoute(
          path: 'profile',
          name: 'profile',
          builder: (context, state) => const ProfileView(),
        ),
        GoRoute(
          path: 'proyects',
          name: 'proyects',
          builder: (context, state) => const CreateproyectView(),
        ),
        GoRoute(
          path: 'details_proyects',
          name: 'details_proyects',

          builder: (context, state) {
            final proyecto = state.extra as Proyecto;
            return DetailsproyectView(proyecto: proyecto);
          },
        ),
      ],
    ),
  ],
);
