import 'package:flutter/material.dart';
import 'package:flutter_animations/const/credit_cards.dart';
import 'package:flutter_animations/widgets/comps/credit_card.dart';

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
          ],
        ),
      ),
    );
  }
}
