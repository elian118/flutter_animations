import 'package:flutter/material.dart';
import 'package:flutter_animations/const/musics.dart';
import 'package:flutter_animations/utils/format.dart';
import 'package:flutter_animations/widgets/painers/progress_bar.dart';
import 'package:flutter_animations/widgets/painers/volume_painter.dart';

class DetailContentView extends StatelessWidget {
  final AnimationController progressController;
  final Animation<Offset> screenOffset;
  final Animation<double> screenScale;
  final Animation<Offset> marqueeTween;
  final Animation<double> playPauseController;
  final int imgIdx;
  final bool dragging;
  final ValueNotifier<double> volume;
  final void Function() openMenu;
  final void Function() onPlayPauseTap;
  final void Function(DragUpdateDetails) onVolumeDragUpdate;
  final void Function() toggleDragging;

  const DetailContentView({
    super.key,
    required this.progressController,
    required this.playPauseController,
    required this.screenOffset,
    required this.screenScale,
    required this.marqueeTween,
    required this.imgIdx,
    required this.volume,
    required this.dragging,
    required this.openMenu,
    required this.onPlayPauseTap,
    required this.onVolumeDragUpdate,
    required this.toggleDragging,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SlideTransition(
      position: screenOffset,
      child: ScaleTransition(
        scale: screenScale,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Interstellar"),
            actions: [IconButton(onPressed: openMenu, icon: Icon(Icons.menu))],
          ),
          body: Column(
            children: [
              SizedBox(height: 30),
              Align(
                alignment: Alignment.center,
                child: Hero(
                  tag: '$imgIdx',
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
                        image: AssetImage('assets/covers/$imgIdx.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),
              AnimatedBuilder(
                animation: progressController,
                builder:
                    (context, child) => CustomPaint(
                      size: Size(size.width - 80, 5),
                      painter: ProgressBar(
                        progressValue: progressController.value,
                      ),
                    ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: AnimatedBuilder(
                  animation: progressController,
                  builder: (context, child) {
                    String playTime = Format.toTime(
                      progressController.value,
                      progressController.duration!,
                    );
                    String restTime = Format.toTime(
                      1 - progressController.value,
                      progressController.duration!,
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
                "${musics[imgIdx - 1]['movie']}",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 5),
              SlideTransition(
                position: marqueeTween,
                child: Text(
                  "A Film by ${musics[imgIdx - 1]['director']} - ${musics[imgIdx - 1]['title']}",
                  maxLines: 1,
                  overflow: TextOverflow.visible,
                  softWrap: false,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 30),
              GestureDetector(
                onTap: onPlayPauseTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedIcon(
                      icon: AnimatedIcons.pause_play,
                      progress: playPauseController,
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
                onHorizontalDragUpdate: onVolumeDragUpdate,
                onHorizontalDragStart: (_) => toggleDragging(),
                onHorizontalDragEnd: (_) => toggleDragging(),
                child: AnimatedScale(
                  scale: dragging ? 1.1 : 1,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.bounceOut,
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ValueListenableBuilder(
                      valueListenable: volume,
                      builder:
                          (context, value, child) => CustomPaint(
                            size: Size(size.width - 80, 50),
                            painter: VolumePainter(volume: volume.value),
                          ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
