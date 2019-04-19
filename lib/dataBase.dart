import 'dart:async';
import 'package:mysql1/mysql1.dart';
import 'question.dart';
import 'category.dart';



Future buildDatabase() async{
  var connection = await MySqlConnection.connect(new ConnectionSettings(
      host: 'h2670460.stratoserver.net',
      port: 3306,
      user: 'sr_user',
      password: 'hackepeter',
      db: 'sr_db'
    )
  );

  var results = await connection.query('select * from questions_german');

  for (var row in results)  {
    question.addQuestion(row[0], row[1].toString(), row[2], row[3].toString(), row[4].toString(), row[5].toString(), row[6].toString(), row[7].toString(), row[8].toString());
  }

  connection.close();
}



