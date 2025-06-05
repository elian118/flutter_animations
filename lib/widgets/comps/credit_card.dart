import 'package:flutter/material.dart';
import 'package:flutter_animations/const/credit_cards.dart';
import 'package:flutter_animations/screens/card_detail_screen.dart';

class CreditCard extends StatelessWidget {
  final Color bgColor;
  final String username;
  final int number;
  final bool isExpanded;

  const CreditCard({
    super.key,
    required this.bgColor,
    required this.username,
    required this.number,
    required this.isExpanded,
  });

  @override
  Widget build(BuildContext context) {
    void onTap() {
      int index = creditCard.indexWhere((card) => card['bgColor'] == bgColor);
      Navigator.push(
        context,
        // Scaffold -> Scaffold 이동 시 자식들이 잠시 부모가 없는 상태가 되며 스타일이 깨지게 된다.
        // 해결책: 스크린 이동을 요청하는 곳의 위젯을 Material(type: MaterialType.transparency, child: child)으로 감싸준다.
        MaterialPageRoute(
          builder: (context) => CardDetailScreen(index: index),
          fullscreenDialog: true,
        ),
      );
    }

    // Scaffold -> Scaffold 이동 시 스크린 이동 시
    // 자식들이 잠시 부모가 없는 상태가 되며 스타일이 깨지는 현상 방지를 위한 Material 랩핑
    return Material(
      type: MaterialType.transparency,
      child: AbsorbPointer(
        absorbing: !isExpanded, // 확장된 상태만 제스처 인식
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: bgColor,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              child: Column(
                children: [
                  SizedBox(height: 100),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            username,
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                          Text(
                            '**** **** **$number',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.amber,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 20,
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
