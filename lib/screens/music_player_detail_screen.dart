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
    with TickerProviderStateMixin {
  late final AnimationController _progressController = AnimationController(
    vsync: this,
    value: 0.0,
    duration: Duration(minutes: 100),
  )..repeat(reverse: true); // 리버스 반복 옵션 추가

  late final AnimationController _marqueeController = AnimationController(
    vsync: this,
    duration: Duration(seconds: 20),
  )..repeat(reverse: true);

  late final AnimationController _playPauseController = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 500),
  );

  late final Animation<Offset> _marqueeTween = Tween(
    begin: Offset(0.1, 0),
    end: Offset(-0.6, 0),
  ).animate(_marqueeController);

  void _onPlayPauseTap() {
    _playPauseController.isCompleted
        ? _playPauseController.reverse()
        : _playPauseController.forward();
  }

  @override
  void dispose() {
    _progressController.dispose();
    _marqueeController.dispose();
    _playPauseController.dispose();
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
          SizedBox(height: 10),
          Text(
            "Interstellar",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 5),
          SlideTransition(
            position: _marqueeTween,
            child: Text(
              "A Film by Christopher Nolan - Original Motion Picture Soundtrack",
              maxLines: 1,
              overflow: TextOverflow.visible,
              softWrap: false,
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(height: 30),
          GestureDetector(
            onTap: _onPlayPauseTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedIcon(
                  icon: AnimatedIcons.pause_play,
                  progress: _playPauseController,
                  size: 60,
                ),
                /*LottieBuilder.asset(
                  "assets/animations/play-lottie.json",
                  controller: _playPauseController,
                  // 애니메이션 시간을 로티 애니메이션 시간으로 동기화
                  onLoaded: (composition) {
                    _playPauseController.duration = composition.duration;
                  },
                  width: 80,
                  height: 80,
                ),*/
              ],
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
