import 'package:flutter/material.dart';
import 'package:pulse_task/presentation/screens/home/home_content.dart';
import 'package:pulse_task/presentation/screens/proyects/proyects_view.dart';
import 'package:pulse_task/presentation/widgets/custom_appbar.dart';
import 'package:pulse_task/presentation/widgets/custom_bottomnavigationbar.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedScreen = 0;

  final List<Widget> _screens = [
    const HomeContent(), 
    const ProyectsView()
    
    ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(greeting: 'hola', name: 'Lalo'),
      body: _screens[_selectedScreen],
      bottomNavigationBar: CustomBottomnavigationbar(
        onTabSelected: (index) => setState(() => _selectedScreen = index),
      ),
    );
  }
}
