import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
      body: Center(
        child: Text('Hello!', style: TextStyle(fontSize: 66))
            .animate()
            .fadeIn(begin: 0, duration: 1.seconds)
            .scale(
              alignment: Alignment.center,
              begin: Offset.zero,
              end: Offset(1, 1),
              duration: 1.seconds,
            )
            .then(delay: 1.seconds)
            .slideX(begin: 0, end: -10, duration: 2.seconds),
      ),
    );
  }
}
