// 3rd party packages
import 'dart:convert';
import 'package:sqflite/sqflite.dart';

// Utils
import 'package:sofiqe/utils/constants/database_names.dart';

Future<List<Map<String, dynamic>>> sfDBReadQuestionnaireFromDatabase() async {
  // Database db = await openDatabase(DatabaseNames.dbQuestionnaire);
  List<Map<String, dynamic>> resultList = []; //= await db.query('questions');

  resultList.addAll([
    {
      "entity_id": 7,
      "question_id": 7,
      "question_type": "",
      "questions": "What colours does your veins have on your underarm?",
      "answers": json.encode({
        "option_1": "Green",
        "option_2": "Blue",
        "option_3": "Cannot see them",
      }),
    },
    {
      "entity_id": 8,
      "question_id": 8,
      "question_type": "",
      "questions":
          "If wearing jewelry, which one does make you look raidant or glow?",
      "answers": json.encode({
        "option_1": "Gold",
        "option_2": "Silver",
        "option_3": "Neutral",
      }),
    },
    {
      "entity_id": 9,
      "question_id": 9,
      "question_type": "",
      "questions": "When you're out in the sun, do you tend to burn or tan?",
      "answers": json.encode({
        "option_1": "Burn",
        "option_2": "Tan",
      }),
    },
    {
      "entity_id": 10,
      "question_id": 10,
      "question_type": "",
      "questions": "What skin tone do you have?",
      "answers": json.encode({
        "option_1": "Fair",
        "option_2": "Light",
        "option_3": "Medium",
        "option_4": "Dark",
      }),
    },
    {
      "entity_id": 11,
      "question_id": 11,
      "question_type": "",
      "questions": "What is your eyecolour?",
      "answers": json.encode({
        "option_1": "Green",
        "option_2": "Blue",
        "option_3": "Brown",
        "option_4": "Black",
      }),
    },
  ]);

  return resultList;
}

Future<void> sfDBAddNewQuestionsToDatabase() async {
  try {
    Database db = await openDatabase(DatabaseNames.dbQuestionnaire);
    List<dynamic> questionList = []; //= await sfAPIFetchQuestionFromRemote();
    await db.delete('questions');
    await db.rawQuery(
        'CREATE TABLE IF NOT EXISTS "questions" ("entity_id"	INTEGER NOT NULL UNIQUE,"question_id"	INTEGER NOT NULL UNIQUE,"question_type"	TEXT NOT NULL,"questions"	TEXT NOT NULL,"answers"	TEXT NOT NULL,PRIMARY KEY("entity_id" AUTOINCREMENT))');

    questionList.addAll([
      {
        "entity_id": 7,
        "question_id": 7,
        "question_type": "",
        "questions": "What colours does your veins have on your underarm?",
        "answers": json.encode({
          "option_1": "Green",
          "option_2": "Blue",
          "option_3": "Cannot see them",
        }),
      },
      {
        "entity_id": 8,
        "question_id": 8,
        "question_type": "",
        "questions":
            "If wearing jewelry, which one does make you look raidant or glow?",
        "answers": json.encode({
          "option_1": "Gold",
          "option_2": "Silver",
          "option_3": "Neutral",
        }),
      },
      {
        "entity_id": 9,
        "question_id": 9,
        "question_type": "",
        "questions": "When you're out in the sun, do you tend to burn or tan?",
        "answers": json.encode({
          "option_1": "Burn",
          "option_2": "Tan",
        }),
      },
      {
        "entity_id": 10,
        "question_id": 10,
        "question_type": "",
        "questions": "What skin tone do you have?",
        "answers": json.encode({
          "option_1": "Fair",
          "option_2": "Light",
          "option_3": "Medium",
          "option_4": "Dark",
        }),
      },
      {
        "entity_id": 11,
        "question_id": 11,
        "question_type": "",
        "questions": "What is your eyecolour?",
        "answers": json.encode({
          "option_1": "Green",
          "option_2": "Blue",
          "option_3": "Brown",
          "option_4": "Black",
        }),
      },
    ]);
    questionList.forEach(
      (dynamic question) async {
        await db.insert('questions', question);
      },
    );
  } catch (e) {
    print('Error fetching/saving questions: $e');
  }
}

Future<void> sfDBAddAnswerToDatabase(List response) async {
  Database db = await openDatabase(DatabaseNames.dbQuestionnaire);
  await db.rawQuery(
      'CREATE TABLE IF NOT EXISTS "answers" ("question_id"	INTEGER NOT NULL UNIQUE,"questions"	TEXT NOT NULL UNIQUE,"answer"	TEXT NOT NULL,PRIMARY KEY("question_id"))');
  print(await db.delete('answers'));
  db.delete('answers');
  response.forEach(
    (dynamic answer) async {
      await db.rawInsert(
        "INSERT INTO answers VALUES(?, ?, ?)",
        [
          answer['question_id'],
          answer['question'],
          json.encode(answer['answers']),
        ],
      );

      // await db.rawQuery(
      //     "INSERT INTO answers VALUES(\'${answer['question_id']}\', \'${answer['question']}\', \'${json.encode(answer['answers'])}\')");
    },
  );
}

Future<void> sfDBStoredResponse() async {
  Database db = await openDatabase(DatabaseNames.dbQuestionnaire);
  print(await db.rawQuery('SELECT * FROM answers'));
}
