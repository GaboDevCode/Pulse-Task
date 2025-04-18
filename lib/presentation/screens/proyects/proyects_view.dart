import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProyectsView extends StatelessWidget {
  const ProyectsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('menu'),
            SizedBox(height: 580), // Add spacing between the text and button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Background color
              ),

              onPressed: () {
                context.goNamed('proyects');
              },

              child: Text('Agregar Proyecto'),
            ),
          ],
        ),
      ),
    );
  }
}
