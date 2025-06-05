import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animations/const/credit_cards.dart';
import 'package:flutter_animations/widgets/comps/credit_card.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wallet')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          // 메서드 체이닝 방식
          children: [
                ...creditCard.map(
                  (card) => CreditCard(
                    bgColor: card['bgColor'],
                    username: card['username'],
                    number: card['number'],
                    isExpanded: true,
                  ),
                ),
              ]
              .animate(interval: 0.2.seconds)
              .slideX(begin: -1, end: 0)
              .fadeIn(begin: 0),

          // 코드를 더 명확화한 방식
          // children: [AnimateList(
          //   effects: [
          //     SlideEffect(begin: Offset(-1, 0), end: Offset.zero),
          //     FadeEffect(begin: 0, end: 1),
          //   ],
          //   interval: 0.2.seconds, // 200.ms
          //   children: [
          //     ...creditCard.map(
          //       (card) => CreditCard(
          //         bgColor: card['bgColor'],
          //         username: card['username'],
          //         number: card['number'],
          //       ),
          //     ),
          //   ],
          // )],
        ),
      ),
    );
  }
}
