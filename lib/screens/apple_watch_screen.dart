import 'dart:math';

import 'package:flutter/material.dart';

class AppleWatchScreen extends StatefulWidget {
  const AppleWatchScreen({super.key});

  @override
  State<AppleWatchScreen> createState() => _AppleWatchScreenState();
}

class _AppleWatchScreenState extends State<AppleWatchScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: Duration(seconds: 1),
  )..forward(); // 보이자마자 바로 시작

  late final CurvedAnimation _curve = CurvedAnimation(
    parent: _animationController,
    curve: Curves.bounceOut,
  );

  late Animation<double> _redProgress = Tween(
    begin: 0.005,
    end: Random().nextDouble() * 2.0,
  ).animate(_curve);

  late Animation<double> _greenProgress = Tween(
    begin: 0.005,
    end: Random().nextDouble() * 2.0,
  ).animate(_curve);

  late Animation<double> _blueProgress = Tween(
    begin: 0.005,
    end: Random().nextDouble() * 2.0,
  ).animate(_curve);

  void _animateValues() {
    final random = Random();

    final newRedBegin = _redProgress.value;
    final newRedEnd = random.nextDouble() * 2.0;
    _redProgress = Tween(begin: newRedBegin, end: newRedEnd).animate(_curve);

    final newGreenBegin = _greenProgress.value;
    final newGreenEnd = random.nextDouble() * 2.0;
    _greenProgress = Tween(
      begin: newGreenBegin,
      end: newGreenEnd,
    ).animate(_curve);

    final newBlueBegin = _blueProgress.value;
    final newBlueEnd = random.nextDouble() * 2.0;
    _blueProgress = Tween(begin: newBlueBegin, end: newBlueEnd).animate(_curve);

    setState(() {
      _animationController.forward(from: 0);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 다크모드 설정하면 되지만, 귀찮아서 그냥 블랙 배경 줌
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Apple Watch"),
        backgroundColor: Colors.black,
        titleTextStyle: TextStyle(color: Colors.white),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _animationController,
          builder:
              (context, child) => CustomPaint(
                painter: AppleWatchPainter(
                  redProgress: _redProgress.value,
                  blueProgress: _blueProgress.value,
                  greenProgress: _greenProgress.value,
                ),
                size: Size(400, 400),
              ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _animateValues,
        child: Icon(Icons.refresh),
      ),
    );
  }
}

class AppleWatchPainter extends CustomPainter {
  final double redProgress;
  final double greenProgress;
  final double blueProgress;

  AppleWatchPainter({
    required this.redProgress,
    required this.greenProgress,
    required this.blueProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    // final paint = Paint()..color = Colors.blue;
    // canvas.drawRect(rect, paint);

    final radius = size.width / 2;
    final center = Offset(radius, radius);
    final redCircleRadius = radius * 0.9;
    final greenCircleRadius = radius * 0.76;
    final blueCircleRadius = radius * 0.62;
    final startingAngle = -0.5 * pi;

    // draw red circle
    final redCirclePaint =
        Paint()
          ..color = Colors.red.shade400.withOpacity(0.3)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 25;
    canvas.drawCircle(center, redCircleRadius, redCirclePaint);

    // draw green circle
    final greenCirclePaint =
        Paint()
          ..color = Colors.green.shade400.withOpacity(0.3)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 25;
    canvas.drawCircle(center, greenCircleRadius, greenCirclePaint);

    // draw blue circle
    final blueCirclePaint =
        Paint()
          ..color = Colors.blue.shade400.withOpacity(0.3)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 25;
    canvas.drawCircle(center, blueCircleRadius, blueCirclePaint);

    // red arc
    final redAcrRect = Rect.fromCircle(center: center, radius: redCircleRadius);
    final redArcPaint =
        Paint()
          ..color = Colors.red
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 25;
    canvas.drawArc(
      redAcrRect,
      startingAngle,
      redProgress * pi,
      false,
      redArcPaint,
    );

    // green arc
    final greenAcrRect = Rect.fromCircle(
      center: center,
      radius: greenCircleRadius,
    );
    final greenArcPaint =
        Paint()
          ..color = Colors.green.shade400
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 25;
    canvas.drawArc(
      greenAcrRect,
      startingAngle,
      greenProgress * pi,
      false,
      greenArcPaint,
    );

    // blue arc
    final blueAcrRect = Rect.fromCircle(
      center: center,
      radius: blueCircleRadius,
    );
    final blueArcPaint =
        Paint()
          ..color = Colors.blue.shade400
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..strokeWidth = 25;
    canvas.drawArc(
      blueAcrRect,
      startingAngle,
      blueProgress * pi,
      false,
      blueArcPaint,
    );
  }

  // 속성 값이 변경되면 리페인팅 해야 하는가? -> setState 역할
  @override
  bool shouldRepaint(covariant AppleWatchPainter oldDelegate) {
    return oldDelegate.redProgress != redProgress ||
        oldDelegate.greenProgress != greenProgress ||
        oldDelegate.blueProgress != blueProgress;
  }
}
