class player {
  int id;
  static int i = 0;
  String name;
  String sex;
  int points;
  static Map playerbase;
  static var playerbase2;

  player(this.id, this.name, this.sex, this.points);

  player.addPlayer(String newName, String newSex, int newPoints) {
    /*newPlayer.id = i;
    player newPlayer = new player(newId, newName, newSex, newPoints);
    newPlayer.name = newName;
    newPlayer.sex = newSex;*/
    playerbase = {id: i, name: newName, sex: newSex, points: newPoints};
    playerbase.pu
    playerbase2 = {id: i, name: newName, sex: newSex, points: newPoints};
    i++;
  }

  Map returnPlayerbase() {
    return playerbase;
  }

  player returnPlayer()
  {

  }

  String returnPlayerbaseAsString(int id) {
    return playerbase2[id][name];
  }
}