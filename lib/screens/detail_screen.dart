import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final int image;

  const DetailScreen({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail Screen")),
      body: Column(
        children: [
          Image.asset("assets/covers/$image.jpg"),
          Text("Detail Screen", style: TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}
