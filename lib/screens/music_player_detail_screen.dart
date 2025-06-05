import 'package:flutter/material.dart';
import 'package:flutter_animations/widgets/views/music_player_detail/detail_content_view.dart';
import 'package:flutter_animations/widgets/views/music_player_detail/side_menu_view.dart';

import '../const/menus.dart';

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
    reverseDuration: Duration(seconds: 1),
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

  late final Animation<Offset> _marqueeTween = Tween<Offset>(
    begin: Offset(0.1, 0),
    end: Offset(-0.6, 0),
  ).animate(_marqueeController);

  late final Animation<double> _screenScale = Tween<double>(
    begin: 1.0,
    end: 0.7,
  ).animate(
    // Interval -> 부모 애니메이션의 동작 구간 중 일부에서만 이 애니메이션이 실행하도록 설정
    CurvedAnimation(
      parent: _menuController,
      curve: Interval(0.0, 0.3, curve: _menuCurve),
    ),
  );

  late final Animation<Offset> _screenOffset = Tween<Offset>(
    begin: Offset.zero,
    end: Offset(0.5, 0.0),
  ).animate(
    CurvedAnimation(
      parent: _menuController,
      curve: Interval(0.2, 0.4, curve: _menuCurve),
    ),
  );

  late final Animation<double> _closeBtnOpacity = Tween<double>(
    begin: 0.0,
    end: 1.0,
  ).animate(
    CurvedAnimation(
      parent: _menuController,
      curve: Interval(0.3, 0.5, curve: _menuCurve),
    ),
  );

  late final List<Animation<Offset>> _menuAnimations = [
    for (var i = 0; i < menus.length; i++)
      Tween<Offset>(begin: Offset(-1, 0), end: Offset.zero).animate(
        CurvedAnimation(
          parent: _menuController,
          curve: Interval(0.4 + (0.1 * i), 0.7 + (0.1 * i), curve: _menuCurve),
        ),
      ),
  ];

  // 다른 방식
  /*late final List<Animation<Offset>> _menuAnimations =
      menus.asMap().entries.map((entry) {
        final int i = entry.key;
        return Tween<Offset>(begin: Offset(-1, 0), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _menuController,
            curve: Interval(
              0.4 + (0.1 * i),
              0.7 + (0.1 * i),
              curve: _menuCurve,
            ),
          ),
        );
      }).toList();*/

  late final Animation<Offset> _logoutSlide = Tween<Offset>(
    begin: Offset(-1, 0),
    end: Offset.zero,
  ).animate(
    CurvedAnimation(
      parent: _menuController,
      curve: Interval(0.8, 1.0, curve: _menuCurve),
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
    _menuController.dispose();
    _progressController.dispose();
    _marqueeController.dispose();
    _playPauseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // menu - 개발중에는 제일 아래쪽에 배치해야 테스트가 쉽다.
        SideMenuView(
          closeBtnOpacity: _closeBtnOpacity,
          logoutSlide: _logoutSlide,
          menuAnimations: _menuAnimations,
          closeMenu: _closeMenu,
        ),
        // music player
        DetailContentView(
          progressController: _progressController,
          playPauseController: _playPauseController,
          screenOffset: _screenOffset,
          screenScale: _screenScale,
          marqueeTween: _marqueeTween,
          imgIdx: widget.imgIdx,
          volume: _volume,
          dragging: _dragging,
          openMenu: _openMenu,
          onPlayPauseTap: _onPlayPauseTap,
          onVolumeDragUpdate: _onVolumeDragUpdate,
          toggleDragging: _toggleDragging,
        ),
      ],
    );
  }
}
