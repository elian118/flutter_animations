import 'package:flutter_animations/screens/apple_watch_screen.dart';
import 'package:flutter_animations/screens/color_tween_screen.dart';
import 'package:flutter_animations/screens/combine_explicit_animations_screen.dart';
import 'package:flutter_animations/screens/container_transform_screen.dart';
import 'package:flutter_animations/screens/curved_animation_screen.dart';
import 'package:flutter_animations/screens/explicit_animation_screen.dart';
import 'package:flutter_animations/screens/fade_through_screen.dart';
import 'package:flutter_animations/screens/implicit_animation_screen.dart';
import 'package:flutter_animations/screens/music_player_screen.dart';
import 'package:flutter_animations/screens/rive_custom_balls_screen.dart';
import 'package:flutter_animations/screens/rive_custom_btn_screen.dart';
import 'package:flutter_animations/screens/rive_dwarf_screen.dart';
import 'package:flutter_animations/screens/rive_stars_screen.dart';
import 'package:flutter_animations/screens/shared_axis_screen.dart';
import 'package:flutter_animations/screens/swiping_cards_screen.dart';
import 'package:flutter_animations/screens/value_notifier_screen.dart';

List<Map<String, dynamic>> screens = [
  {"title": "Implicit animation", "widget": ImplicitAnimationScreen()},
  {"title": "Explicit animation", "widget": ExplicitAnimationScreen()},
  {"title": "Color Tween animation", "widget": ColorTweenScreen()},
  {
    "title": "Combine explicit animations",
    "widget": DecoratedBoxTransitionScreen(),
  },
  {"title": "Curved animation", "widget": CurvedAnimationScreen()},
  {"title": "with Value notifier", "widget": ValueNotifierScreen()},
  {"title": "Apple Watch", "widget": AppleWatchScreen()},
  {"title": "Swiping Cards", "widget": SwipingCardsScreen()},
  {"title": "Music Player", "widget": MusicPlayerScreen()},
  {"title": "Rive - Dwarf", "widget": RiveDwarfScreen()},
  {"title": "Rive - Stars", "widget": RiveStarsScreen()},
  {"title": "Rive - Custom Balls", "widget": RiveCustomBallsScreen()},
  {"title": "Rive - Custom Button", "widget": RiveCustomBtnScreen()},
  {"title": "Container transform", "widget": ContainerTransformScreen()},
  {"title": "Shared Axis", "widget": SharedAxisScreen()},
  {"title": "Fade Through", "widget": FadeThroughScreen()},
];
