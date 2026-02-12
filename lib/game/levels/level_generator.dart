import 'dart:math';
import 'package:ball_game/models/level_data.dart';
import 'package:ball_game/utils/constants.dart';

class LevelGenerator {
  static LevelData generate( int level ) {
    final rows = initialRows;
    final cols = initialCols;

    final grid = List.generate(
      rows,
      ( _ ) => List.generate( cols, ( _ ) => Cell() ),
    );

    _generateMaze( grid, rows, cols );

    return LevelData(
      rows: rows,
      cols: cols,
      grid: grid,
    );
  }
}