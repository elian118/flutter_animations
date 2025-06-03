import 'dart:math';

import 'package:flutter/material.dart';

import '../widgets/comps/cover.dart';

class SwipingCardsScreen extends StatefulWidget {
  const SwipingCardsScreen({super.key});

  @override
  State<SwipingCardsScreen> createState() => _SwipingCardsScreenState();
}

class _SwipingCardsScreenState extends State<SwipingCardsScreen>
    with SingleTickerProviderStateMixin {
  double posX = 0;
  late final size = MediaQuery.of(context).size;
  late final _pos = AnimationController(
    vsync: this,
    duration: Duration(seconds: 1),
    value: 0.0,
    // dropZone 결과를 받아들일 수 있도록 화면너비에 애니메이션 허용 범위 보정 + 100
    lowerBound: (size.width + 100) * -1,
    upperBound: (size.width + 100),
  );

  late final Tween<double> _rotation = Tween(begin: -15, end: 15);
  late final Tween<double> _scale = Tween(begin: 0.8, end: 1);
  late final Tween<double> _btnScale = Tween(begin: 1, end: 1.2);

  int _index = 1;

  void _whenComplete() {
    _pos.value = 0; // 카드 원위치
    setState(() {
      _index = _index % 5 > 0 ? _index + 1 : 1; // 원위치 타이밍에 새 카드 이미지로 교체
    });
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    _pos.value += details.delta.dx; // 사용자가 드래그한 만큼 누적해 x좌표에 대입
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    // print(_pos.value.abs()); // 절대값
    // print(size.width - 100); // 카드를 없앨 기준 너비 -> 초과 시 카드 제거
    final bound = size.width - 180; // 원위치 처리 너비 범위
    final dropZone = size.width + 100;
    _pos.value.abs() >= bound
        ? _pos
            .animateTo(dropZone * (_pos.value.isNegative ? -1 : 1))
            .whenComplete(_whenComplete)
        : _pos.animateTo(0, curve: Curves.bounceOut);
  }

  void _onBtnClick(bool isLeftSide) {
    _pos
        .animateTo(
          isLeftSide ? _pos.lowerBound : _pos.upperBound,
          curve: Curves.easeOut,
        )
        .whenComplete(_whenComplete);
  }

  @override
  void dispose() {
    _pos.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Swiping Cards')),
      body: AnimatedBuilder(
        animation: _pos,
        builder: (context, child) {
          final moveX = _pos.value;
          final transX = moveX.abs() / size.width;
          final scale = _scale.transform(transX);
          final btnScale = _btnScale.transform(transX);

          final angle = _rotation.transform(
            (moveX + size.width / 2) / size.width,
          ); // [좌우 움직임 너비 -> 각도] 보간값(-15 ~ 15도) 변환;
          /*print('(좌우 움직임 너비 + 화면너비 절반) / 화면너비 = 움직일 각도 => 카드 회전 각');
          print(
            '$moveX + ${size.width / 2} / ${size.width} = $angle => ${angle * pi / 180}',
          );*/

          final Color btnColor =
              ColorTween(
                begin: Theme.of(context).scaffoldBackgroundColor,
                end: moveX < 0 ? Colors.red.shade100 : Colors.green.shade100,
              ).transform(transX) ??
              Theme.of(context).scaffoldBackgroundColor;

          return Stack(
            alignment: Alignment.topCenter,
            children: [
              Positioned(
                top: 100,
                child: Transform.scale(
                  // 1을 넘어가면 애니메이션 패턴으로 인해 본래 크기보다 커지는 일 발생하므로 1.0보다 커지지 않도록 강제
                  scale: min(scale, 1.0),
                  child: Cover(index: _index % 5 > 0 ? _index + 1 : 1),
                ),
              ),
              Positioned(
                top: 100,
                child: Transform.translate(
                  offset: Offset(_pos.value, 0),
                  child: GestureDetector(
                    onHorizontalDragUpdate: _onHorizontalDragUpdate,
                    onHorizontalDragEnd: _onHorizontalDragEnd,
                    child: Transform.rotate(
                      angle: angle * pi / 180, // 180도 이내로 한정
                      child: Cover(index: _index),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 150,
                child: Row(
                  children: [
                    Transform.scale(
                      scale: moveX > 0 ? 1 : btnScale,
                      child: Material(
                        elevation: 10,
                        shape: CircleBorder(
                          // 원형 버튼에 적합한 Shape
                          side: BorderSide(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            width: 3.0,
                          ),
                        ),
                        color:
                            moveX > 0
                                ? Theme.of(context).scaffoldBackgroundColor
                                : btnColor,
                        child: IconButton(
                          onPressed: () => _onBtnClick(true),
                          splashColor: Colors.red.shade100, // 탭 시 붉은색 그림자
                          highlightColor: Colors.red.shade100,
                          icon: Icon(
                            Icons.close,
                            color: Colors.red,
                            size: 40.0,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 40),
                    Transform.scale(
                      scale: moveX > 0 ? btnScale : 1,
                      child: Material(
                        elevation: 10,
                        shape: CircleBorder(
                          side: BorderSide(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            width: 3.0,
                          ),
                        ),
                        color:
                            moveX > 0
                                ? btnColor
                                : Theme.of(context).scaffoldBackgroundColor,
                        child: IconButton(
                          onPressed: () => _onBtnClick(false),
                          splashColor: Colors.green.shade100, // 탭 시 붉은색 그림자
                          highlightColor: Colors.green.shade100,
                          icon: Icon(
                            Icons.check,
                            color: Colors.green,
                            size: 40.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
