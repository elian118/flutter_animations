import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animations/const/credit_cards.dart';
import 'package:flutter_animations/widgets/comps/credit_card.dart';
import 'package:flutter_animations/widgets/comps/history.dart';

class CardDetailScreen extends StatelessWidget {
  final int index;
  const CardDetailScreen({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    // Scaffold -> Scaffold 이동 시 자식들이 잠시 부모가 없는 상태가 되며 스타일이 깨지게 된다.
    return Scaffold(
      appBar: AppBar(title: Text('Transactions')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Hero(
              tag: '$index',
              child: CreditCard(
                bgColor: creditCard[index]['bgColor'],
                username: creditCard[index]['username'],
                number: creditCard[index]['number'],
                isExpanded: false,
              ),
            ),
            // animate가 분리된 배열에만 적용되도록
            // 스프레드 연산자 사용해 대상 배열만 골라 배열 안의 배열로 변경
            ...[
                  ...[1, 1, 1, 1, 1, 1].map(
                    (e) => Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: History(),
                    ),
                  ),
                ]
                .toList()
                .animate(interval: 0.4.seconds)
                .fadeIn(begin: 0)
                .slideY(begin: 1, end: 0)
                .fadeIn(begin: 0)
                .then()
                .flipV(begin: -5, end: 0, curve: Curves.bounceOut),
          ],
        ),
      ),
    );
  }
}

// ListView.builder(
// itemCount: 6,
// itemBuilder: (context, index) => History(),
// )
