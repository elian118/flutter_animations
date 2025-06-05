import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class SharedAxisScreen extends StatefulWidget {
  const SharedAxisScreen({super.key});

  @override
  State<SharedAxisScreen> createState() => _SharedAxisScreenState();
}

class _SharedAxisScreenState extends State<SharedAxisScreen> {
  int _currentImage = 1;

  void _goToImage(int newImage) {
    setState(() {
      _currentImage = newImage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shared Axis')),
      body: Column(
        children: [
          PageTransitionSwitcher(
            duration: Duration(milliseconds: 800),
            transitionBuilder:
                (child, primaryAnimation, secondaryAnimation) =>
                    SharedAxisTransition(
                      animation: primaryAnimation,
                      secondaryAnimation: secondaryAnimation,
                      transitionType: SharedAxisTransitionType.scaled,
                      child: child,
                    ),
            child: Container(
              // 키를 설정하지 않으면 transitionBuilder에서 child 변경됨을 인지하지 못해 애니메이션 처리를 하지 않는다.
              key: ValueKey(_currentImage),
              // clipBehavior: Clip.hardEdge,
              // decoration: BoxDecoration(shape: BoxShape.circle),
              child: Image.asset('assets/covers/$_currentImage.jpg'),
            ),
          ),
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ...[1, 2, 3, 4, 5].map(
                  (btn) => ElevatedButton(
                    onPressed: () => _goToImage(btn),
                    child: Text('$btn'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
