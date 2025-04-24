import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pulse_task/configuration/router/routes.dart';
import 'package:pulse_task/configuration/theme/app_theme.dart';
import 'package:pulse_task/domain/datasources/local/database_helper.dart';
import 'package:pulse_task/presentation/providers/project_provider/projectprovider.dart';
import 'package:pulse_task/presentation/providers/task_provider/taskprojectprovider.dart';
import 'package:pulse_task/presentation/providers/theme_provider/ThemeProvider.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Bloquear orientación
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // 2. Inicializar la base de datos ANTES de runApp
  final database = DatabaseHelper;

  runApp(
    MultiProvider(
      providers: [
        // 3. Pasar la BD a los providers que lo necesiten (ej: TaskProvider)
        ChangeNotifierProvider(create: (_) => Projectprovider(database)),
        ChangeNotifierProvider(create: (_) => Themeprovider()),
        ChangeNotifierProvider(
          create: (_) => TaskProvider(database), // Ejemplo: Inyectar BD
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<Themeprovider>(context);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.getTheme(themeProvider.selectedColorIndex),
      routerConfig: appRouter,
    );
  }
}
