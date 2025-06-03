import 'package:flutter/material.dart';

class ValueNotifierScreen extends StatefulWidget {
  const ValueNotifierScreen({super.key});

  @override
  State<ValueNotifierScreen> createState() => _ValueNotifierScreenn();
}

class _ValueNotifierScreenn extends State<ValueNotifierScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animatedController = AnimationController(
    vsync: this, // Ticker 주입되는 변수 -> 위젯 트리가 활성화 돼 있을 때만 Ticker 사용
    duration: Duration(seconds: 2),
    reverseDuration: Duration(seconds: 1), // 되돌릴 땐 1초
  )..addListener(
    () => setState(() {
      _range.value = _animatedController.value;
    }),
  );
  /*..addStatusListener(
          // (status) => print(status); // 애니메이션 진행 상황 표시
          (status) =>
              status == AnimationStatus.completed
                  ? _animatedController.reverse()
                  : status == AnimationStatus.dismissed
                  ? _animatedController.forward()
                  : print(status), // 애니메이션 무한 반복
        );*/

  late final Animation<Decoration> _decoration = DecorationTween(
    begin: BoxDecoration(
      color: Colors.amber,
      borderRadius: BorderRadius.circular(20),
    ),
    end: BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.circular(120),
    ),
  ).animate(_curved);

  late final Animation<double> _rotation = Tween(
    begin: 0.0,
    end: 5.0,
  ).animate(_curved);

  late final Animation<double> _scale = Tween(
    begin: 1.0,
    end: 1.1,
  ).animate(_curved);

  late final Animation<Offset> _position = Tween(
    begin: Offset.zero,
    end: Offset(0, -0.2), // y축으로 -20% 이동
  ).animate(_curved);

  late final CurvedAnimation _curved = CurvedAnimation(
    parent: _animatedController,
    curve: Curves.elasticInOut,
    reverseCurve: Curves.bounceIn,
  );

  void _play() {
    _animatedController.forward();
  }

  void _pause() {
    _animatedController.stop();
  }

  void _rewind() {
    _animatedController.reverse();
  }

  final ValueNotifier<double> _range = ValueNotifier(
    0.0,
  ); // setState 없이 UI에 값 변경을 알려 리랜더링시킨다.

  void _onChanged(double value) {
    _range.value = 0.0;
    _animatedController.value = value; // 애니메이션 효과 없이 즉시 적용
    // _animatedController.animateTo(value); // 애니메이션으로 적용
  }

  bool _looping = false;

  void _toggleLooping() {
    _looping
        ? _animatedController.stop()
        : _animatedController.repeat(reverse: true);
    setState(() {
      _looping = !_looping;
    });
  }

  @override
  void dispose() {
    _animatedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print('build');
    return Scaffold(
      appBar: AppBar(title: Text('with Value notifier')),
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
                ElevatedButton(
                  onPressed: _toggleLooping,
                  child: Text("${_looping ? 'Stop' : 'Start'} looping"),
                ),
              ],
            ),
            SizedBox(height: 25),
            // Slider(value: _value.value, onChanged: _onChanged),
            // 플러터 버전 업 이후 굳이 아래 코드를 안 써도 ValueNotifier - Slider 자동 연동 / 최적화 됨
            ValueListenableBuilder(
              valueListenable: _range,
              builder:
                  (context, value, child) =>
                      Slider(value: value, onChanged: _onChanged),
            ),
          ],
        ),
      ),
    );
  }
}
