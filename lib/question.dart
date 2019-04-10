class question  {
  int id;
  String descr;
  int time;
  String taska;
  String taskm;
  String tasky;
  String taskt;
  String taskr;
  static int qic = 0;
  static var questionbase = {};

  question(this.id, this.descr, this.time, this.taska, this.taskm, this.tasky, this.taskt, this.taskr);

  question.addQuestion(String descr){
      question newQuestion = new question(qic, descr, 0, '', '', '', '', '');
    questionbase[qic] = newQuestion;
    qic++;
  }
}