import 'dart:ui';

import 'package:flutter/material.dart';

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
                  Container(
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
                        image: AssetImage('assets/covers/${index + 1}.jpg'),
                        fit: BoxFit.cover,
                      ),
                    ),
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
