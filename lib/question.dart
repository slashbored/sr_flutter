class question  {
  int id;
  String descr;
  int cat_id;
  int type_id;
  int subtype_id;
  int time;
  String taska;
  String taskm;
  String tasky;
  String taskt;
  String taskr;
  String taskq;
  //static int qic = 0;
  static var questionbase = {};

  question(this.id,  this.descr, this.cat_id, this.type_id, this.subtype_id, this.time, this.taska, this.taskm, this.tasky, this.taskt, this.taskr, this.taskq);

  question.addQuestion(int id, String descr, int cat_id, int type_id, int subtype_id, int time, String taska, String taskm, String tasky, String taskt, String taskr, String taskq){
      question newQuestion = new question(id, descr, cat_id, type_id, subtype_id, time, taska, taskm, tasky, taskt, taskr, taskq);
    questionbase[id] = newQuestion;
    //qic++;
  }
}