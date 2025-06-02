import 'package:flutter/material.dart';

class ColorTweenScreen extends StatefulWidget {
  const ColorTweenScreen({super.key});

  @override
  State<ColorTweenScreen> createState() => _ColorTweenScreenState();
}

class _ColorTweenScreenState extends State<ColorTweenScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animatedController = AnimationController(
    vsync: this, // Ticker 주입되는 변수 -> 위젯 트리가 활성화 돼 있을 때만 Ticker 사용
    duration: Duration(seconds: 2),
  );

  // 색상 특화 Tween -> ColorTween
  late final Animation<Color?> _color = ColorTween(
    begin: Colors.amber,
    end: Colors.red,
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Color Tween Animation')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _color,
              builder:
                  (context, child) =>
                      Container(color: _color.value, width: 400, height: 400),
            ),
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
