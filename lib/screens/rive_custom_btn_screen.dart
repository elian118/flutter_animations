import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RiveCustomBtnScreen extends StatefulWidget {
  const RiveCustomBtnScreen({super.key});

  @override
  State<RiveCustomBtnScreen> createState() => _RiveCustomBtnScreenState();
}

class _RiveCustomBtnScreenState extends State<RiveCustomBtnScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          RiveAnimation.asset(
            'assets/animations/custom-button-animation.riv',
            stateMachines: ['state'],
          ),
          Center(
            child: Text(
              'Login',
              style: TextStyle(color: Colors.white, fontSize: 28),
            ),
          ),
        ],
      ),
    );
  }
}
