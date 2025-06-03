import 'package:flutter/material.dart';
import 'package:flutter_animations/utils/format.dart';

import '../const/menus.dart';
import '../widgets/painers/progress_bar.dart';
import '../widgets/painers/volume_painter.dart';

class MusicPlayerDetailScreen extends StatefulWidget {
  final int imgIdx;

  const MusicPlayerDetailScreen({super.key, required this.imgIdx});

  @override
  State<MusicPlayerDetailScreen> createState() =>
      _MusicPlayerDetailScreenState();
}

class _MusicPlayerDetailScreenState extends State<MusicPlayerDetailScreen>
    with TickerProviderStateMixin {
  late final AnimationController _menuController = AnimationController(
    vsync: this,
    duration: Duration(seconds: 2),
  );

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

  late final Animation<double> _screenScale = Tween(
    begin: 1.0,
    end: 0.7,
  ).animate(
    // Interval -> 부모 애니메이션의 동작 구간 중 일부에서만 이 애니메이션이 실행하도록 설정
    CurvedAnimation(
      parent: _menuController,
      curve: Interval(0.0, 0.5, curve: _menuCurve),
    ),
  );

  late final Animation<Offset> _screenOffset = Tween(
    begin: Offset.zero,
    end: Offset(0.5, 0.0),
  ).animate(
    CurvedAnimation(
      parent: _menuController,
      curve: Interval(0.5, 1.0, curve: _menuCurve),
    ),
  );

  late final size = MediaQuery.of(context).size;
  final Curve _menuCurve = Curves.easeInOutCubic;
  final ValueNotifier<double> _volume = ValueNotifier(0);
  bool _dragging = false;

  void _onPlayPauseTap() {
    _playPauseController.isCompleted
        ? _playPauseController.reverse()
        : _playPauseController.forward();
  }

  void _toggleDragging() {
    setState(() {
      _dragging = !_dragging;
    });
  }

  void _onVolumeDragUpdate(DragUpdateDetails details) {
    _volume.value += details.delta.dx; // 볼륨 변화량 반영
    _volume.value = _volume.value.clamp(
      0.0,
      size.width - 80,
    ); // 초과 볼륨 값을 상/하한값으로 돌려놓기
  }

  void _openMenu() {
    _menuController.forward();
  }

  void _closeMenu() {
    _menuController.reverse();
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

    return Stack(
      children: [
        // menu - 개발중에는 제일 아래쪽에 배치해야 테스트가 쉽다.
        Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            leading: IconButton(onPressed: _closeMenu, icon: Icon(Icons.close)),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                SizedBox(height: 30),
                ...menus.map(
                  (menu) => Column(
                    children: [
                      Row(
                        children: [
                          Icon(menu['icon'], color: Colors.grey.shade200),
                          SizedBox(width: 10),
                          Text(
                            menu['text'],
                            style: TextStyle(
                              color: Colors.grey.shade200,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
                Spacer(),
                Row(
                  children: [
                    Icon(Icons.logout, color: Colors.red),
                    SizedBox(width: 10),
                    Text(
                      'Log out',
                      style: TextStyle(color: Colors.red, fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(height: 100),
              ],
            ),
          ),
        ),
        // music player
        SlideTransition(
          position: _screenOffset,
          child: ScaleTransition(
            scale: _screenScale,
            child: Scaffold(
              appBar: AppBar(
                title: Text("Interstellar"),
                actions: [
                  IconButton(onPressed: _openMenu, icon: Icon(Icons.menu)),
                ],
              ),
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
                            image: AssetImage(
                              'assets/covers/${widget.imgIdx}.jpg',
                            ),
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
                  SizedBox(height: 30),
                  GestureDetector(
                    onHorizontalDragUpdate: _onVolumeDragUpdate,
                    onHorizontalDragStart: (_) => _toggleDragging(),
                    onHorizontalDragEnd: (_) => _toggleDragging(),
                    child: AnimatedScale(
                      scale: _dragging ? 1.1 : 1,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.bounceOut,
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ValueListenableBuilder(
                          valueListenable: _volume,
                          builder:
                              (context, value, child) => CustomPaint(
                                size: Size(size.width - 80, 50),
                                painter: VolumePainter(volume: _volume.value),
                              ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
