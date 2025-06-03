import 'package:flutter/material.dart';
import 'package:flutter_animations/screens/apple_watch_screen.dart';
import 'package:flutter_animations/screens/color_tween_screen.dart';
import 'package:flutter_animations/screens/curved_animation_screen.dart';
import 'package:flutter_animations/screens/implicit_animation_screen.dart';
import 'package:flutter_animations/screens/music_player_screen.dart';
import 'package:flutter_animations/screens/rive_custom_balls_screen.dart';
import 'package:flutter_animations/screens/rive_custom_btn_screen.dart';
import 'package:flutter_animations/screens/rive_dwarf_screen.dart';
import 'package:flutter_animations/screens/rive_stars_screen.dart';
import 'package:flutter_animations/screens/swiping_cards_screen.dart';
import 'package:flutter_animations/screens/value_notifier_screen.dart';

import 'combine_explicit_animations_screen.dart';
import 'explicit_animation_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  void _goToPage(BuildContext context, Widget screen) =>
      Navigator.push(context, MaterialPageRoute(builder: (context) => screen));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fluter Animations')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => _goToPage(context, ImplicitAnimationScreen()),
              child: Text('Implicit animation'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _goToPage(context, ExplicitAnimationScreen()),
              child: Text('Explicit animation'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _goToPage(context, ColorTweenScreen()),
              child: Text('Color Tween animation'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed:
                  () => _goToPage(context, DecoratedBoxTransitionScreen()),
              child: Text('Combine explicit animations'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _goToPage(context, CurvedAnimationScreen()),
              child: Text('Curved animation'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _goToPage(context, ValueNotifierScreen()),
              child: Text('with Value notifier'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _goToPage(context, AppleWatchScreen()),
              child: Text('Apple Watch'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _goToPage(context, SwipingCardsScreen()),
              child: Text('Swiping Cards'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _goToPage(context, MusicPlayerScreen()),
              child: Text('Music Player'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _goToPage(context, RiveDwarfScreen()),
              child: Text('Rive - Dwarf'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _goToPage(context, RiveStarsScreen()),
              child: Text('Rive - Stars'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _goToPage(context, RiveCustomBallsScreen()),
              child: Text('Rive - Custom Balls'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _goToPage(context, RiveCustomBtnScreen()),
              child: Text('Rive - Custom Button'),
            ),
          ],
        ),
      ),
    );
  }
}
