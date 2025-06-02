import 'package:flutter/material.dart';

class ExplicitAnimationScreen extends StatefulWidget {
  const ExplicitAnimationScreen({super.key});

  @override
  State<ExplicitAnimationScreen> createState() =>
      _ExplicitAnimationScreenState();
}

class _ExplicitAnimationScreenState extends State<ExplicitAnimationScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animatedController = AnimationController(
    vsync: this, // Ticker 주입되는 변수 -> 위젯 트리가 활성화 돼 있을 때만 Ticker 사용
    duration: Duration(seconds: 10),
    // lowerBound: 50.0,
    // upperBound: 100.0,
  );

  @override
  void initState() {
    super.initState();
    /*  Ticker 자체는 애니메이션 컨트롤러와 상관 없이 호출될 수 있지만,
        한 번 실행된 Ticker는 수동으로 멈추지 않는 한 백그라운드에서 계속 실행돼 시스템 자원을 잡아 먹는다. */
    // Ticker((elapsed) => print(elapsed)).start(); // Ticker 함수가 뭐 하는 건지 확인용
    /*  _animatedController.value는 _animatedController가 작동하면
        화면에 반영(위젯 리빌드)되지 않더라도 값이 변화함을 아래 타이머 주기 출력코드를 활성화해 알 수 있다. */
    /*Timer.periodic(
      const Duration(microseconds: 500),
      (timer) => print(_animatedController.value),
    );*/
  }

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
      appBar: AppBar(title: Text('Explicit Animations')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 추적하는 애니메이션 값이 변경되면 UI에 알려 다시 자동 빌드되도록 하는 위젯
            // -> 애니메니션별로 설정 가능하며, 적용 부분만 빌드하게 돼 성능적으로 더 좋다.
            AnimatedBuilder(
              animation: _animatedController,
              builder:
                  (context, child) => Text(
                    '${_animatedController.value}',
                    style: TextStyle(fontSize: 58),
                  ),
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
