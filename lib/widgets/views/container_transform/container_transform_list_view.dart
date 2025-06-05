import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animations/const/musics.dart';
import 'package:flutter_animations/screens/detail_screen.dart';

class ContainerTransformListView extends StatelessWidget {
  const ContainerTransformListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder:
          (context, index) => OpenContainer(
            closedElevation: 0,
            openElevation: 0,
            transitionDuration: Duration(milliseconds: 800),
            openBuilder:
                (context, action) => DetailScreen(image: (index % 5) + 1),
            closedBuilder:
                (context, action) => ListTile(
                  title: Text("${musics[(index % 5)]['movie']}"),
                  subtitle: Text("${musics[(index % 5)]['title']}"),
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/covers/${(index % 5) + 1}.jpg',
                        ),
                      ),
                    ),
                  ),
                ),
          ),
      separatorBuilder: (context, index) => SizedBox(height: 20),
      itemCount: 20,
    );
  }
}
