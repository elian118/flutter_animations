import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animations/widgets/views/fade_through/navigation_page_view.dart';

class FadeThroughScreen extends StatefulWidget {
  const FadeThroughScreen({super.key});

  @override
  State<FadeThroughScreen> createState() => _FadeThroughScreenState();
}

class _FadeThroughScreenState extends State<FadeThroughScreen> {
  int _index = 0;

  void _onNewDestination(int index) {
    setState(() {
      _index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fade Through')),
      body: PageTransitionSwitcher(
        duration: Duration(milliseconds: 800),
        transitionBuilder:
            (child, primaryAnimation, secondaryAnimation) =>
                FadeThroughTransition(
                  fillColor: Colors.black, // 깜빡이는 효과처럼 연출 가능
                  animation: primaryAnimation,
                  secondaryAnimation: secondaryAnimation,
                  child: child,
                ),
        child:
            [
              NavigationPageView(
                key: ValueKey(0),
                text: 'Profile',
                icon: Icons.person,
              ),
              NavigationPageView(
                key: ValueKey(1),
                text: 'Notification',
                icon: Icons.notifications,
              ),
              NavigationPageView(
                key: ValueKey(2),
                text: 'Settings',
                icon: Icons.settings,
              ),
            ][_index],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: _onNewDestination,
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_outlined),
            selectedIcon: Icon(Icons.notifications),
            label: 'Notification',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
