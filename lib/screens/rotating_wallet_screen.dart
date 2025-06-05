import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_animations/const/credit_cards.dart';
import 'package:flutter_animations/widgets/comps/credit_card.dart';

class RotatingWalletScreen extends StatefulWidget {
  const RotatingWalletScreen({super.key});

  @override
  State<RotatingWalletScreen> createState() => _RotatingWalletScreenState();
}

class _RotatingWalletScreenState extends State<RotatingWalletScreen> {
  bool _isExpanded = true;

  void _onExpand() {
    setState(() {
      _isExpanded = true;
    });
  }

  void _onShrink() {
    setState(() {
      _isExpanded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wallet')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GestureDetector(
          onVerticalDragEnd: (_) => _onShrink(),
          onTap: _onExpand,
          child: Column(
            children: [
                  ...creditCard.mapIndexed(
                    (idx, card) => CreditCard(
                          bgColor: card['bgColor'],
                          username: card['username'],
                          number: card['number'],
                        )
                        .animate(
                          target: _isExpanded ? 0 : 1,
                          delay: 1.5.seconds,
                        )
                        .flipV(end: 0.1)
                        .slideY(end: -0.8 * idx),
                  ),
                ]
                .animate(interval: 0.2.seconds)
                .slideX(begin: -1, end: 0)
                .fadeIn(begin: 0),
          ),
        ),
      ),
    );
  }
}
