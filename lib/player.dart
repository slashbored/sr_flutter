class player  {
  int id;
  int i = 0;
  String name;
  String sex;
  int points;

  player(this.id, this.name, this.sex, this.points);

  player.addPlayer(String newName, String newSex) {
    name = newName;
    sex = newSex;
  }

}