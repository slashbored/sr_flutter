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

  var questionsFromDB = await connection.query('select * from questions_german');
  for (var row in questionsFromDB)  {
    question.addQuestion(row[0], row[1].toString(), row[2], row[3], row[4], row[5], row[6].toString(), row[7].toString(), row[8].toString(), row[9].toString(), row[10].toString(), row[11].toString());
  }

  var categoriesFromDB = await connection.query('select * from categories');
  for (var row in categoriesFromDB)  {
    category.addCategory(row[0], row[1].toString(), row[2].toString());
  }

  var typesFromDB = await connection.query('select * from type');
  for (var row in typesFromDB)  {
    type.addType(row[0], row[1].toString());
  }

  var subtypesFromDB = await connection.query('select * from subtype');
  for (var row in subtypesFromDB)  {
    subtype.addSubtype(row[0], row[1].toString());
  }

  connection.close();
}


