import 'package:flutter/material.dart';
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
          children: [
            ...creditCard.map(
              (card) => CreditCard(
                bgColor: card['bgColor'],
                username: card['username'],
                number: card['number'],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
