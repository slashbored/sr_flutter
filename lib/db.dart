import 'dart:async';
import 'question.dart';
import 'package:mysql1/mysql1.dart';


Future builddb() async{
  var connection = await MySqlConnection.connect(new ConnectionSettings(
      host: 'h2670460.stratoserver.net',
      port: 3306,
      user: 'sr_user',
      password: 'hackepeter',
      db: 'sr_db'
    )
  );

  var results = await connection.query('select taska from questions_german');

  for (var row in results)  {
    /*print('${row[0]}');*/
    question.addQuestion(row[0].toString());
  }

  connection.close();
}

