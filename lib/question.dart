class question  {
  int id;
  String descr;
  int time;
  String taska;
  String taskm;
  String tasky;
  String taskt;
  String taskr;
  String taskq;
  static int qic = 0;
  static var questionbase = {};

  question(this.id, this.descr, this.time, this.taska, this.taskm, this.tasky, this.taskt, this.taskr, this.taskq);

  question.addQuestion(int id, String descr, int time, String taska, String taskm, String tasky, String taskt, String taskr, String taskq){
      question newQuestion = new question(id, descr, time, taska, taskm, tasky, taskt, taskr, taskq);
    questionbase[id] = newQuestion;
    qic++;
  }
}