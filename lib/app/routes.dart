import 'package:flutter/material.dart';
import '../screens/game/game_screen.dart';

class Routes {
  static const mainMenu = '/';
  static const game = '/game';

  static final Map<String, WidgetBuilder> map = {
    mainMenu: ( context ) => const GameScreen(),
    game: ( context ) => const GameScreen(),
  };
}