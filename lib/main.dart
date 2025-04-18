import 'package:flutter/material.dart';
import 'package:pulse_task/configuration/router/routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false, 
      theme: ThemeData.dark(),
      routerConfig: appRouter);
  }
}
