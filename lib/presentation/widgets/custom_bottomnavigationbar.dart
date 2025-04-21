import 'package:flutter/material.dart';

class CustomBottomnavigationbar extends StatefulWidget {
  final Function(int) onTabSelected;

  const CustomBottomnavigationbar({super.key, required this.onTabSelected});

  @override
  State<CustomBottomnavigationbar> createState() =>
      _CustomBottomnavigationbarState();
}

class _CustomBottomnavigationbarState extends State<CustomBottomnavigationbar> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFF222121),
      currentIndex: _currentIndex,
      onTap: (index) {
        setState(() => _currentIndex = index);
        widget.onTabSelected(index);
      },
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.white,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Proyects'),
      ],
    );
  }
}
