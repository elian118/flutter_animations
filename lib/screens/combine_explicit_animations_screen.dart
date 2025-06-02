import 'package:flutter/material.dart';

class DecoratedBoxTransitionScreen extends StatefulWidget {
  const DecoratedBoxTransitionScreen({super.key});

  @override
  State<DecoratedBoxTransitionScreen> createState() =>
      _DecoratedBoxTransitionScreen();
}

class _DecoratedBoxTransitionScreen extends State<DecoratedBoxTransitionScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animatedController = AnimationController(
    vsync: this, // Ticker 주입되는 변수 -> 위젯 트리가 활성화 돼 있을 때만 Ticker 사용
    duration: Duration(seconds: 2),
  );

  late final Animation<Decoration> _decoration = DecorationTween(
    begin: BoxDecoration(
      color: Colors.amber,
      borderRadius: BorderRadius.circular(20),
    ),
    end: BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.circular(120),
    ),
  ).animate(_animatedController);

  late final Animation<double> _rotation = Tween(
    begin: 0.0,
    end: 2.0,
  ).animate(_animatedController);

  late final Animation<double> _scale = Tween(
    begin: 1.0,
    end: 1.1,
  ).animate(_animatedController);

  late final Animation<Offset> _position = Tween(
    begin: Offset.zero,
    end: Offset(0, -0.2), // y축으로 -20% 이동
  ).animate(_animatedController);

  void _play() {
    _animatedController.forward();
  }

  void _pause() {
    _animatedController.stop();
  }

  void _rewind() {
    _animatedController.reverse();
  }

  @override
  void dispose() {
    _animatedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Combine explicit animations')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlideTransition(
              position: _position,
              child: ScaleTransition(
                scale: _scale,
                child: RotationTransition(
                  turns: _rotation,
                  child: DecoratedBoxTransition(
                    decoration: _decoration,
                    child: SizedBox(height: 400, width: 400),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(onPressed: _play, child: Text("play")),
                ElevatedButton(onPressed: _pause, child: Text("pause")),
                ElevatedButton(onPressed: _rewind, child: Text("rewind")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
