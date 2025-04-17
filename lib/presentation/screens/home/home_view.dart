import 'package:flutter/material.dart';
import 'package:pulse_task/presentation/widgets/custom_appbar.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(greeting: 'hola', name: 'Lalo'),
      body: Center(child: Text('Contenido del home')),
    );
  }
}
