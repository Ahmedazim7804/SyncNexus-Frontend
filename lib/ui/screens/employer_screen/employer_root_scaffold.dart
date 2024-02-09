import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EmployerRootScaffold extends StatefulWidget {
  const EmployerRootScaffold({super.key, required this.child});

  final Widget child;

  @override
  State<EmployerRootScaffold> createState() => _EmployerRootScaffoldState();
}

class _EmployerRootScaffoldState extends State<EmployerRootScaffold> {
  int _selectedIndex = 0;

  void onItemTapped(int selected) {
    setState(() {
      _selectedIndex = selected;
    });

    if (selected == 0) {
      context.go('/screens/employer/homescreen');
    } else if (selected == 1) {
      context.go('/screens/employer/payment');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 226, 181, 31),
        onTap: onItemTapped,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
              label: "Dashboard", icon: Icon(Icons.dashboard)),
          BottomNavigationBarItem(label: "Payment", icon: Icon(Icons.payment))
        ],
      ),
    );
  }
}
