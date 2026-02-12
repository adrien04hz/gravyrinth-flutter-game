import 'dart:math';
import 'package:ball_game/models/level_data.dart';
import 'package:ball_game/utils/constants.dart';

class LevelGenerator {
  static LevelData generate( int level ) {
    final growth = (level - 1) ~/ 2;

    final rows = initialRows + growth;
    final cols = initialCols + (growth ~/ 3);


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

  static void _generateMaze( List<List<Cell>> grid, int rows, int cols  ) {
    final random = Random();

    void dfs( int r, int c ) {
      grid[r][c].visited = true;

      final directions = [
        [0, 1], // derecha
        [1, 0], // abajo
        [0, -1], // izquierda
        [-1, 0], // arriba
      ]..shuffle( random );

      for ( final dir in directions ) {
        final nr = r + dir[0];
        final nc = c + dir[1];

        if ( nr >= 0 && 
            nc >= 0 && 
            nr < rows && 
            nc < cols && 
            !grid[nr][nc].visited ) {
          
          // Romper paredes entre celdas
          if ( dir[0] == 0 && dir[1] == 1 ) {
            grid[r][c].right = false;
            grid[nr][nc].left = false;
          } else if ( dir[0] == 1 && dir[1] == 0 ) {
            grid[r][c].bottom = false;
            grid[nr][nc].top = false;
          } else if ( dir[0] == 0 && dir[1] == -1 ) {
            grid[r][c].left = false;
            grid[nr][nc].right = false;
          } else if ( dir[0] == -1 && dir[1] == 0 ) {
            grid[r][c].top = false;
            grid[nr][nc].bottom = false;
          }

          dfs( nr, nc );
        }
      }
    }
    dfs( 0, 0 );
  }
}