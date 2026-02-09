import 'dart:math';
import 'package:ball_game/models/level_data.dart';
import 'package:ball_game/utils/constants.dart';

class LevelGenerator {
  static LevelData generate( int level ) {
    final random = Random();
    final rows = initialRows;
    final cols = initialCols;

    final probability = ( 0.15 + level * 0.02 ).clamp( 0.15, 0.45 );

    final grid = List.generate( rows, ( r ) {
      return List.generate( cols, ( c ) {
        // Inicio y meta siembre libres
        if (( r == 0 && c == 0 ) || ( r == rows - 1 && c == cols - 1 )) {
          return 0;
        }

        return random.nextDouble() < probability ? 1 : 0;
      });
    });

    return LevelData(
      rows: rows,
      columns: cols,
      grid: grid,
    );
  }
}