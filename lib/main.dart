import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:pulse_task/configuration/router/routes.dart';
import 'package:pulse_task/configuration/theme/app_theme.dart';
import 'package:pulse_task/domain/datasources/local/database_helper.dart';
import 'package:pulse_task/presentation/providers/profile_provider/profile_provider.dart';
import 'package:pulse_task/presentation/providers/project_provider/projectprovider.dart';
import 'package:pulse_task/presentation/providers/task_provider/taskprojectprovider.dart';
import 'package:pulse_task/presentation/providers/theme_provider/ThemeProvider.dart';
import 'package:flutter/services.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializaciones esenciales y rápidas
  tz.initializeTimeZones();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Inicialización CRÍTICA: Base de datos local
  final database = DatabaseHelper.instance;
  await dotenv.load();

  runApp(
    MultiProvider(
      providers: [
        // Proveedores con adManager
        ChangeNotifierProvider(create: (_) => Projectprovider(null, database)),
        ChangeNotifierProvider(create: (_) => TaskProvider(null, database)),
        ChangeNotifierProvider(create: (_) => Themeprovider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Inicialización en segundo plano
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<Themeprovider>().selectedColorIndex;

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.getTheme(themeProvider),
      routerConfig: appRouter,
    );
  }
}
