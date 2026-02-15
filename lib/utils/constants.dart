import 'package:flutter/material.dart';

Color getWorldColor(int world) {
  switch (world) {
    case 1:
      return Colors.blue;
    case 2:
      return Colors.black;
    case 3:
      return Colors.white;
    case 4:
      return Colors.red;
    default:
      return Colors.blue;
  }
}

Color getWallColor( int world ) {
  switch (world) {
    case 1:
      return Colors.white;
    case 2:
      return Colors.white;
    case 3:
      return Colors.black;
    case 4:
      return Colors.black;
    default:
      return Colors.white;
  }
}

Color getBallColor( int world ) {
  switch (world) {
    case 1:
      return Colors.orange;
    case 2:
      return Colors.white;
    case 3:
      return Colors.black;
    case 4:
      return Colors.black;
    default:
      return Colors.white;
  }
}

// =======================
// GAME SETTINGS
// =======================

const int maxLevels = 20;
const int totalWorlds = 4;

// =======================
// TIME SETTINGS
// =======================

const double initialGameTime = 300; // seconds

const double bonusWorld1 = 5;
const double bonusWorld2 = 4;
const double bonusWorld3 = 3;
const double bonusWorld4 = 2;

// =======================
// MAZE SETTINGS
// =======================

const int initialRows = 8;
const int initialCols = 6;
const double cellPadding = 4.0;
const double wallThickness = 3.0;

// =======================
// BALL SETTINGS
// =======================

const double ballRadius = 20;
const double ballSpeed = 200;

// =======================
// ACCELEROMETER
// =======================

const double accelerometerSensitivity = 15.0;

// =======================
// HUD / UI
// =======================

const double hudFontSize = 24;
const double hudPadding = 8;

// =======================
// OVERLAYS
// =======================

const String overlayHud = 'HUD';
const String overlayGameOver = 'GameOver';
const String overlayVictory = 'Victory';
const String overlayLevelComplete = 'LevelComplete';
const String overlayDebug = 'DebugButton';
const String overlayPauseMenu = 'PauseMenu';
