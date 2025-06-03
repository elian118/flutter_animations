import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RiveStarsScreen extends StatefulWidget {
  const RiveStarsScreen({super.key});

  @override
  State<RiveStarsScreen> createState() => _RiveStarsScreenState();
}

class _RiveStarsScreenState extends State<RiveStarsScreen> {
  late final StateMachineController _stateMachineController;

  void _onInit(Artboard artboard) {
    _stateMachineController =
        StateMachineController.fromArtboard(
          artboard,
          'state',
          onStateChange: (stateMachineName, stateName) {
            print(stateMachineName);
            print(stateName);
          },
        )!;
    artboard.addController(_stateMachineController);
  }

  @override
  void dispose() {
    _stateMachineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rive - Stars')),
      body: Center(
        child: Container(
          color: Color(0xFFFF2ECC),
          width: double.infinity,
          child: RiveAnimation.asset(
            'assets/animations/stars-animation.riv',
            artboard: 'artboard',
            stateMachines: ['state'],
            onInit: _onInit,
          ),
        ),
      ),
    );
  }
}
