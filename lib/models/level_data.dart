class Cell {
  bool top = true;
  bool bottom = true;
  bool left = true;
  bool right = true;
  bool visited = false;
}

class LevelData {
  final int rows;
  final int cols;
  final List<List<Cell>> grid;

  LevelData({
    required this.rows,
    required this.cols,
    required this.grid,
  });
}