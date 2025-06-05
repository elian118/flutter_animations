import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animations/screens/detail_screen.dart';

class ContainerTransformGridView extends StatelessWidget {
  const ContainerTransformGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        childAspectRatio: 1 / 1.2,
      ),
      itemBuilder:
          (context, index) => OpenContainer(
            closedBuilder:
                (context, action) => Column(
                  children: [
                    Image.asset('assets/covers/${(index % 5) + 1}.jpg'),
                    Text('Dune soundtrack'),
                    Text('Hans Zimmer', style: TextStyle(fontSize: 14)),
                  ],
                ),
            openBuilder:
                (context, action) => DetailScreen(image: (index % 5) + 1),
          ),
    );
  }
}
