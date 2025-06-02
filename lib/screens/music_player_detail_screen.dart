import 'package:flutter/material.dart';

class MusicPlayerDetailScreen extends StatefulWidget {
  final int imgIdx;

  const MusicPlayerDetailScreen({super.key, required this.imgIdx});

  @override
  State<MusicPlayerDetailScreen> createState() =>
      _MusicPlayerDetailScreenState();
}

class _MusicPlayerDetailScreenState extends State<MusicPlayerDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Interstellar")),
      body: Column(
        children: [
          SizedBox(height: 30),
          Align(
            alignment: Alignment.center,
            child: Hero(
              tag: '${widget.imgIdx}',
              child: Container(
                height: 350,
                width: 350,
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
                    image: AssetImage('assets/covers/${widget.imgIdx}.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
