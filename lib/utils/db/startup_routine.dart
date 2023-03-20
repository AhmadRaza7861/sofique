import 'dart:io';
import 'package:flutter/services.dart';

// 3rd party packages
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

//Utils
import 'package:sofiqe/utils/constants/database_names.dart';
import 'package:sofiqe/utils/states/launch_status.dart';

Future<void> sfDBStartupRoutine() async {
  if (await sfDidAppLaunchFirstTime()) {
    await _sfDBCopyDatabases();
  }
}

Future<void> _sfDBCopyDatabases() async {
  _sfDBCopyDatabase(dbName: DatabaseNames.dbQuestionnaire);
  _sfDBCopyDatabase(dbName: DatabaseNames.dbAnswer);
}

Future<void> _sfDBCopyDatabase({required String dbName}) async {
  var databasesPath = await getDatabasesPath();
  var path = join(databasesPath, dbName);

// Check if the database exists
  // ignore: unused_local_variable
  var exists = await databaseExists(path);

  try {
    await Directory(dirname(path)).create(recursive: true);
  } catch (_) {}

  // Copy from asset
  ByteData data = await rootBundle.load(join("assets", "db/$dbName"));
  List<int> bytes =
      data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

  // Write and flush the bytes written
  await File(path).writeAsBytes(bytes, flush: true);
}
