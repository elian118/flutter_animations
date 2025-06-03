import 'package:flutter/material.dart';
import 'package:flutter_animations/utils/format.dart';

class MusicPlayerDetailScreen extends StatefulWidget {
  final int imgIdx;

  const MusicPlayerDetailScreen({super.key, required this.imgIdx});

  @override
  State<MusicPlayerDetailScreen> createState() =>
      _MusicPlayerDetailScreenState();
}

class _MusicPlayerDetailScreenState extends State<MusicPlayerDetailScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _progressController = AnimationController(
    vsync: this,
    value: 0.0,
    duration: Duration(minutes: 150),
  )..repeat(reverse: true); // 리버스 반복 옵션 추가

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text("Interstellar")),
      body: Column(
        children: [
          SizedBox(height: 30),
          Align(
            alignment: Alignment.center,
            child: Hero(
              tag: '${widget.imgIdx}',
              child: Container(
                height: 350,
                width: 350,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.4),
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: Offset(0, 8),
                    ),
                  ],
                  image: DecorationImage(
                    image: AssetImage('assets/covers/${widget.imgIdx}.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 50),
          AnimatedBuilder(
            animation: _progressController,
            builder:
                (context, child) => CustomPaint(
                  size: Size(size.width - 80, 5),
                  painter: ProgressBar(
                    progressValue: _progressController.value,
                  ),
                ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: AnimatedBuilder(
              animation: _progressController,
              builder: (context, child) {
                String playTime = Format.toTime(
                  _progressController.value,
                  _progressController.duration!,
                );
                String restTime = Format.toTime(
                  1 - _progressController.value,
                  _progressController.duration!,
                );

                return Row(
                  children: [
                    Text(
                      playTime,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Spacer(),
                    Text(
                      restTime,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ProgressBar extends CustomPainter {
  final double progressValue;

  ProgressBar({super.repaint, required this.progressValue});

  @override
  void paint(Canvas canvas, Size size) {
    final progress = size.width * progressValue; // 0~1 -> 사이즈 변환 값

    // track bar
    final trackPaint =
        Paint()
          ..color = Colors.grey.shade300
          ..style = PaintingStyle.fill;

    final trackRRect = RRect.fromLTRBR(
      0,
      0,
      // CustomPaint(size: Size(size.width - 80, 5), ...)
      size.width, // size.width - 80
      size.height, // 5
      Radius.circular(10),
    );

    canvas.drawRRect(trackRRect, trackPaint);

    // progress
    final progressPaint =
        Paint()
          ..color = Colors.grey.shade500
          ..style = PaintingStyle.fill;

    final progressRRect = RRect.fromLTRBR(
      0,
      0,
      progress,
      size.height,
      Radius.circular(10),
    );

    canvas.drawRRect(progressRRect, progressPaint);

    // thumb
    canvas.drawCircle(
      Offset(progress, size.height / 2),
      10,
      progressPaint, // 진행바 페인트 재활용
    );
  }

  @override
  bool shouldRepaint(covariant ProgressBar oldDelegate) {
    return oldDelegate.progressValue != progressValue;
  }
}
