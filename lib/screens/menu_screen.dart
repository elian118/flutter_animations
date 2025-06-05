import 'package:flutter/material.dart';
import 'package:flutter_animations/const/screens.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  void _goToPage(BuildContext context, Widget screen) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => screen));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fluter Animations')),
      body: Center(
        child: ListView.separated(
          itemBuilder:
              (context, index) => Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () => _goToPage(context, screens[index]['widget']),
                  child: Text(screens[index]['title']),
                ),
              ),
          separatorBuilder: (context, index) => SizedBox(height: 10),
          itemCount: 15,
        ),
      ),
    );
  }
}
