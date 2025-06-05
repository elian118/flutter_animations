import 'package:flutter/material.dart';
import 'package:flutter_animations/const/musics.dart';

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
          SizedBox(height: 30),
          Text(
            "${musics[image - 1]['movie']}",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 5),
          Text(
            "${musics[image - 1]['director']}",
            maxLines: 1,
            overflow: TextOverflow.visible,
            softWrap: false,
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 5),
          Text(
            "${musics[image - 1]['title']}",
            maxLines: 1,
            overflow: TextOverflow.visible,
            softWrap: false,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
