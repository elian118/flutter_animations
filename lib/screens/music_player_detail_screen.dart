import 'package:flutter/material.dart';

class MusicPlayerDetailScreen extends StatefulWidget {
  final int imgIdx;

  const MusicPlayerDetailScreen({super.key, required this.imgIdx});

  @override
  State<MusicPlayerDetailScreen> createState() =>
      _MusicPlayerDetailScreenState();
}

class _MusicPlayerDetailScreenState extends State<MusicPlayerDetailScreen> {
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
          CustomPaint(
            size: Size(size.width - 80, 5),
            painter: ProgressBar(progresValue: 180),
          ),
        ],
      ),
    );
  }
}

class ProgressBar extends CustomPainter {
  final double progresValue;

  ProgressBar({super.repaint, required this.progresValue});

  @override
  void paint(Canvas canvas, Size size) {
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
      progresValue,
      size.height,
      Radius.circular(10),
    );

    canvas.drawRRect(progressRRect, progressPaint);

    // thumb
    canvas.drawCircle(
      Offset(progresValue, size.height / 2),
      10,
      progressPaint, // 진행바 페인트 재활용
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    //
    return true;
  }
}
