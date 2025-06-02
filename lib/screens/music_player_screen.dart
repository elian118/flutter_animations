import 'dart:ui';

import 'package:flutter/material.dart';

import 'music_player_detail_screen.dart';

class MusicPlayerScreen extends StatefulWidget {
  const MusicPlayerScreen({super.key});

  @override
  State<MusicPlayerScreen> createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  final PageController _pageController = PageController(viewportFraction: 0.8);

  int _currentPage = 0;

  void _onPageChanged(int newPage) {
    setState(() {
      _currentPage = newPage;
    });
  }

  ValueNotifier<double> _scroll = ValueNotifier(0.0);

  void _onTabCover(int index) {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 700),
        reverseTransitionDuration: Duration(milliseconds: 700),
        pageBuilder:
            // ScaleTransition
            /*(context, animation, secondaryAnimation) => ScaleTransition(
              scale: animation,
              child: MusicPlayerDetailScreen(imgIdx: index),
            ),*/
            // RotationTransition
            /*(context, animation, secondaryAnimation) => RotationTransition(
              turns: animation,
              child: MusicPlayerDetailScreen(imgIdx: index),
            ),*/
            // SlideTransition
            /*(context, animation, secondaryAnimation) {
              final offset = Tween<Offset>(
                begin: Offset(1, 1),
                end: Offset.zero,
              ).animate(animation);
              return SlideTransition(
                position: offset,
                child: MusicPlayerDetailScreen(imgIdx: index),
              );
            }*/
            // PadeTransition
            (context, animation, secondaryAnimation) => FadeTransition(
              opacity: animation,
              child: MusicPlayerDetailScreen(imgIdx: index),
            ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      // print(_pageController.page); // 현재 페이지(스크롤 위치)
      _scroll.value = _pageController.page ?? 0;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Music Player')),
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            child: Container(
              // 키 속성을 부여해야 플러터에게 새로운 child가 생성됨을 알릴 수 있다.
              key: ValueKey(_currentPage),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/covers/${_currentPage + 1}.jpg'),
                  fit: BoxFit.cover, // 전체 확장
                ),
              ),
              // 배경필터 처리
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(color: Colors.black.withOpacity(0.5)),
              ),
            ),
          ),
          PageView.builder(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            itemCount: 5,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ValueListenableBuilder(
                    valueListenable: _scroll, // 여기서만 스크롤 값 추적
                    builder: (context, scroll, child) {
                      final difference = (scroll - index).abs();
                      final scale = 1 - (difference * 0.12);
                      /*print('카드 ${index + 1}에서 $difference만큼 떨어져 있습니다.');
                      print('카드 ${index + 1}은 $scale배가 됩니다.');*/

                      return GestureDetector(
                        onTap: () => _onTabCover(index + 1),
                        child: Hero(
                          tag: '${index + 1}',
                          child: Transform.scale(
                            scale: scale,
                            child: Container(
                              height: 350,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.4),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                    offset: Offset(0, 8),
                                  ),
                                ],
                                image: DecorationImage(
                                  image: AssetImage(
                                    'assets/covers/${index + 1}.jpg',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 35),
                  Text(
                    "Interstellar",
                    style: TextStyle(fontSize: 26, color: Colors.white),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Hans Zimmer",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
