import 'package:flutter/material.dart';

class NavigationPageView extends StatelessWidget {
  final IconData icon;
  final String text;
  const NavigationPageView({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48),
            Text(text, style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
    );
  }
}
