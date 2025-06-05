import 'package:flutter/material.dart';
import 'package:flutter_animations/const/menus.dart';

class SideMenuView extends StatelessWidget {
  final Animation<double> closeBtnOpacity;
  final void Function()? closeMenu;
  final List<Animation<Offset>> menuAnimations;
  final Animation<Offset> logoutSlide;

  const SideMenuView({
    super.key,
    required this.closeBtnOpacity,
    this.closeMenu,
    required this.menuAnimations,
    required this.logoutSlide,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        leading: FadeTransition(
          opacity: closeBtnOpacity,
          child: IconButton(onPressed: closeMenu, icon: Icon(Icons.close)),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(height: 30),
            ...menus.asMap().entries.map((entry) {
              final int idx = entry.key;
              final Map<String, dynamic> menu = entry.value;

              return Column(
                children: [
                  SlideTransition(
                    position: menuAnimations[idx],
                    child: Row(
                      children: [
                        Icon(menu['icon'], color: Colors.grey.shade200),
                        SizedBox(width: 10),
                        Text(
                          menu['text'],
                          style: TextStyle(
                            color: Colors.grey.shade200,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              );
            }),
            Spacer(),
            SlideTransition(
              position: logoutSlide,
              child: Row(
                children: [
                  Icon(Icons.logout, color: Colors.red),
                  SizedBox(width: 10),
                  Text(
                    'Log out',
                    style: TextStyle(color: Colors.red, fontSize: 18),
                  ),
                ],
              ),
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
