class Cell {
  bool top = true;
  bool bottom = true;
  bool left = true;
  bool right = true;
  bool visited = false;
}

class LevelData {
  final int rows;
  final int columns;
  final List<List<int>> grid;

  LevelData({
    required this.rows,
    required this.columns,
    required this.grid,
  });
}