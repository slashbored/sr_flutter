class player {
  int id;
  String name;
  String sex;
  int points;
  static int pic = 0;
  static var playerbase = {};

  player(this.id, this.name, this.sex, this.points);

  player.addPlayer(String newName, String newSex, int newPoints) {
    player newPlayer = new player(pic, newName, newSex, newPoints);
    playerbase[pic] = newPlayer;

  }

}