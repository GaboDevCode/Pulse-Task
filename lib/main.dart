import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pulse_task/configuration/notifications/notification_service.dart';
import 'package:pulse_task/configuration/router/routes.dart';
import 'package:pulse_task/configuration/theme/app_theme.dart';
import 'package:pulse_task/domain/datasources/local/database_helper.dart';
import 'package:pulse_task/firebase_options.dart';
import 'package:pulse_task/presentation/providers/profile_provider/profile_provider.dart';
import 'package:pulse_task/presentation/providers/project_provider/projectprovider.dart';
import 'package:pulse_task/presentation/providers/task_provider/taskprojectprovider.dart';
import 'package:pulse_task/presentation/providers/theme_provider/ThemeProvider.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // inicializar firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  // 1. Bloquear orientación
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // 2. Inicializar la base de datos ANTES de runApp
  final database = DatabaseHelper;

  // 3. Inicializar las notificaciones ANTES de runApp
  await NotificationService.initialize();

  runApp(
    MultiProvider(
      providers: [
        // 4. Pasar la BD a los providers que lo necesiten (ej: TaskProvider)
        ChangeNotifierProvider(create: (_) => Projectprovider(database)),
        ChangeNotifierProvider(create: (_) => Themeprovider()),
        ChangeNotifierProvider(
          create: (_) => TaskProvider(database), // Ejemplo: Inyectar BD
        ),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
