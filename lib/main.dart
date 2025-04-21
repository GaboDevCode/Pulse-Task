import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pulse_task/configuration/router/routes.dart';
import 'package:pulse_task/configuration/theme/app_theme.dart';
import 'package:pulse_task/presentation/providers/project_provider/projectprovider.dart';
import 'package:pulse_task/presentation/providers/task_provider/taskprojectprovider.dart';
import 'package:pulse_task/presentation/providers/theme_provider/ThemeProvider.dart';

void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Projectprovider()),
      ChangeNotifierProvider(create: (_) => Themeprovider()),
      ChangeNotifierProvider(create: (_) => TaskProvider()),
    ],
    child: MyApp(),
  ),
);

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
