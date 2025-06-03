import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RiveDwarfScreen extends StatefulWidget {
  const RiveDwarfScreen({super.key});

  @override
  State<RiveDwarfScreen> createState() => _RiveDwarfScreenState();
}

class _RiveDwarfScreenState extends State<RiveDwarfScreen> {
  late final StateMachineController _stateMachineController;

  void _onInit(Artboard artboard) {
    _stateMachineController =
        StateMachineController.fromArtboard(artboard, 'state')!;
    artboard.addController(_stateMachineController);
  }

  void _togglePanel() {
    // 애니메이터가 riv 파일을 제작하며 'panelActive' 라고 이름붙인 bool 타입의 state 인풋을 찾는다.
    final input = _stateMachineController.findInput<bool>('panelActive')!;
    input.change(!input.value);
  }

  @override
  void dispose() {
    _stateMachineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rive - Dwarf')),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 400,
              width: double.infinity,
              child: RiveAnimation.asset(
                'assets/animations/old-man-animation.riv',
                artboard: 'main',
                stateMachines: ['state'],
                onInit: _onInit,
              ),
            ),
            ElevatedButton(onPressed: _togglePanel, child: Text('Go!')),
          ],
        ),
      ),
    );
  }
}
