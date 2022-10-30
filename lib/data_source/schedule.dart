// ignore_for_file: depend_on_referenced_packages

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stv_test/model/schedule.dart';

const String scheduleTables = 'schedules';

class ScheduleFields {
  static final List<String> values = [
    id,
    name,
    from,
    to,
    isAllDay,
    comment,
  ];

  static const String id = "_id";
  static const String name = "_name";
  static const String from = "_from";
  static const String to = "_to";
  static const String isAllDay = "_isAllDay";
  static const String comment = "_comment";
}

class ScheduleDataSource {
  static final ScheduleDataSource instance = ScheduleDataSource._init();

  static Database? _database;

  ScheduleDataSource._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('diaries.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';

    await db.execute('''
CREATE TABLE $scheduleTables ( 
  ${ScheduleFields.id} $idType, 
  ${ScheduleFields.name} $textType,
  ${ScheduleFields.from} $textType,
  ${ScheduleFields.to} $textType,
  ${ScheduleFields.isAllDay} $boolType
  ${ScheduleFields.comment} $textType
  )
''');
  }

  Future<Schedule> create(Schedule schedule) async {
    final db = await instance.database;

    final id = await db.insert(scheduleTables, schedule.toJson());
    return schedule.copyWith(id: id);
  }

  Future<Schedule> readDiary(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      scheduleTables,
      columns: ScheduleFields.values,
      where: '${ScheduleFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Schedule.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<int> update(Schedule schedule) async {
    final db = await instance.database;

    return db.update(
      scheduleTables,
      schedule.toJson(),
      where: '${ScheduleFields.id} = ?',
      whereArgs: [schedule.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      scheduleTables,
      where: '${ScheduleFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
