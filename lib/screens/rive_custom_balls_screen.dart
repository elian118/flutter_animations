import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RiveCustomBallsScreen extends StatefulWidget {
  const RiveCustomBallsScreen({super.key});

  @override
  State<RiveCustomBallsScreen> createState() => _RiveCustomBallsScreenState();
}

class _RiveCustomBallsScreenState extends State<RiveCustomBallsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          RiveAnimation.asset(
            'assets/animations/balls-animation.riv',
            fit: BoxFit.cover,
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
              child: Center(
                child: Text(
                  'Welcome To AI App',
                  style: TextStyle(fontSize: 28),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
