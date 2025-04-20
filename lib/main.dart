import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pulse_task/configuration/router/routes.dart';
import 'package:pulse_task/presentation/providers/project_provider/projectprovider.dart';

void main() => runApp(
  MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => Projectprovider())],
    child: MyApp(),
  ),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      routerConfig: appRouter,
    );
  }
}
