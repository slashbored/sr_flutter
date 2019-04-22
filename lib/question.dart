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
  static int qic = 0;
  static var questionDatabase = {};

  question(this.id,  this.descr, this.cat_id, this.type_id, this.subtype_id, this.time, this.taska, this.taskm, this.tasky, this.taskt, this.taskr, this.taskq);

  question.addQuestion(int id, String descr, int cat_id, int type_id, int subtype_id, int time, String taska, String taskm, String tasky, String taskt, String taskr, String taskq){
      question _newQuestion = new question(id, descr, cat_id, type_id, subtype_id, time, taska, taskm, tasky, taskt, taskr, taskq);
    questionDatabase[id] = _newQuestion;
    //qic++;
  }

  static int getQuestionTime(int id){
    question _questionplaceholder = questionDatabase[id];
    return _questionplaceholder.time;
  }

  static String getQuestionText(int id, String char){
    String _questionText;
    question _questionplaceholder = questionDatabase[id];
    switch (char){
      case 'a':{
        _questionText = _questionplaceholder.taska;
      }
      break;
      case 'm':{
        _questionText = _questionplaceholder.taskm;
      }
      break;
      case 'y':{
        _questionText = _questionplaceholder.tasky;
      }
      break;
      case 't':{
        _questionText = _questionplaceholder.taskt;
      }
      break;
      case 'r':{
        _questionText = _questionplaceholder.taskr;
      }
      break;
      case 'q':{
        _questionText = _questionplaceholder.taskq;
      }
      break;
    }
    return _questionText;
  }

}