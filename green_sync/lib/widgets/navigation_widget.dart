import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  const Navigation(
      {super.key, required this.currentIndex, required this.onIndexChanged});
  final int currentIndex;
  final Function(int) onIndexChanged;

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: widget.currentIndex,
        selectedIconTheme: const IconThemeData(size: 50, color: Colors.green),
        unselectedIconTheme: const IconThemeData(size: 40, color: Colors.grey),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.spa), label: ''),
        ],
        onTap: (index) {
          widget.onIndexChanged(index);
        },
      ),
    );
  }
}
