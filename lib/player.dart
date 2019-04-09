class player {
  int id;
  String name;
  String sex;
  int points;
  static int i = 0;
  static var playerbase = {};

  player(this.id, this.name, this.sex, this.points);

  player.addPlayer(String newName, String newSex, int newPoints) {
    player newPlayer = new player(i, newName, newSex, newPoints);
    /* playerbase = {id: i, name: newName, sex: newSex, points: newPoints};*/
    playerbase[i] = newPlayer;
  }

  Map returnPlayerbase() {
    return playerbase;
  }

  player returnPlayer(int id)
  {
    return playerbase[i];
  }

  static String returnPlayerbaseNameAsString(int id) {
    player placeholder = playerbase[id];
    return placeholder.name.toString();
  }
}