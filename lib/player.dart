import 'dart.collection';

class player  {
  int id;
  int i = 0;
  String name;
  String sex;
  int points;
  Map playerbase = {};

  player(this.id, this.name, this.sex, this.points);

  player.addPlayer(String newName, String newSex) {
    player newPlayer;
    newPlayer.id = i;
    i++;
    newPlayer.name = newName;
    newPlayer.sex = newSex;
    playerbase.map(newPlayer);
  }

}