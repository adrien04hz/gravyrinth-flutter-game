import 'dart:math';
import 'package:ball_game/models/level_data.dart';
import 'package:ball_game/utils/constants.dart';

class LevelGenerator {
  static LevelData generate( int level ) {
    final random = Random();
    final rows = initialRows;
    final cols = initialCols;

    final probability = ( 0.15 + level * 0.02 ).clamp( 0.15, 0.45 );

    List<List<int>> grid;

    do {
      grid = List.generate( rows, ( r ) {
        return List.generate( cols, ( c ) {
          // Inicio y meta siembre libres
          if (( r == 0 && c == 0 ) || ( r == rows - 1 && c == cols - 1 )) {
            return 0;
          }

          return random.nextDouble() < probability ? 1 : 0;
        });
      });
      
    } while ( !_isSolvable( grid ) );


    return LevelData(
      rows: rows,
      columns: cols,
      grid: grid,
    );
  }

  static bool _hasPathDFS(
    List<List<int>> grid,
    int r,
    int c,
    List<List<bool>> visited,
  ) {
    final rows = grid.length;
    final cols = grid[0].length;

    // Fuera de limites
    if ( r < 0 || c < 0 || r >= rows || c >= cols ) return false;

    // Pared o ya visitado
    if ( grid[r][c] == 1 || visited[r][c] ) return false;

    // Meta alcanzada
    if ( r == rows - 1 && c == cols - 1 ) return true;

    visited[r][c] = true;

    // Explorar vecinos
    return _hasPathDFS( grid, r + 1, c, visited ) ||
        _hasPathDFS( grid, r - 1, c, visited ) ||
        _hasPathDFS( grid, r, c + 1, visited ) ||
        _hasPathDFS( grid, r, c - 1, visited );
  }

  // Funcion para validar que el nivel generado tenga un camino valido
  static bool _isSolvable( List<List<int>> grid ) {
    final rows = grid.length;
    final cols = grid[0].length;

    final visited = List.generate(
      rows,
      ( _ ) => List.filled( cols, false ),
    );

    return _hasPathDFS( grid, 0, 0, visited );
  }
}